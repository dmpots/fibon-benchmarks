--
-- The Great Computer Language Shootout
-- http://shootout.alioth.debian.org/
-- by Don Stewart, Einar Karttunen, Branimir Maksimovic and Bertram Felgenhauer
--

import System.Environment

import Fibon.Run.BenchmarkHelper
import Data.IORef

data F = F !Integer !Integer !Integer !Integer

main = fibonMain topmain

topmain n = do
  nsr <- newIORef ([] :: [f])
  newmain n nsr

newmain :: Int -> IORef [F] -> IO ()
newmain 0 _ = return ()
newmain cnt nsr = do
  writeIORef nsr [ F k (4*k+2) 0 (2*k+1) | k <- [1..] ]
  n  <- getArgs >>= return . read . head
  ns <- readIORef nsr
  loop fibonOut 10 0 (take n (str (F 1 0 0 1) ns))
  writeIORef nsr []
  newmain (cnt-1) nsr
  where fibonOut s = if cnt == 1 then putStr s else deepseq s (return ())

loop :: (String -> IO ()) -> Int -> Integer -> [Integer] -> IO ()
loop out n s []     = out $ replicate n ' ' ++ "\t:" ++ show s ++ "\n"
loop out 0 s xs     = out ("\t:"++show s ++ "\n") >> loop out 10 s xs
loop out n s (x:xs) = out(show x)          >> loop out (n-1) (s+1) xs

flr  x           (F q r s t) = (q*x + r) `div` (s*x + t)
comp1 (F q r s t) (F u v w x) = F (q*u+r*w) (q*v+r*x) (t*w) (t*x)
comp2 (F q r s t) (F u v w x) = F (q*u) (q*v+r*x) (s*u) (s*v+t*x)

str z (x:xs) | y == flr 4 z = y : str (comp1 (F 10 (-10*y) 0 1) z) (x:xs)
             | otherwise    =     str (comp2 z x) xs     where y = flr 3 z
