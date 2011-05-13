{-# LANGUAGE GeneralizedNewtypeDeriving, BangPatterns, CPP #-}
{- The Computer Language Benchmarks Game
   http://shootout.alioth.debian.org/
   Written by Tom Pledger, 13 Nov 2006. modified by Don Stewart
   Updated for chameneos-redux by Spencer Janssen, 27 Nov 2007
   Modified by Péter Diviánszky, 19 May 2010
   Modified by Louis Wasserman, 14 June 2010

   Should be compiled with -O2 -threaded -fvia-c -optc-O3 and run with +RTS -N<number of cores>.
   -}

import Control.Concurrent
import Control.Monad
import Data.Char
import Data.IORef
import System.Environment
import System.IO
import GHC.Conc
import Foreign hiding (complement)

import Fibon.Run.BenchmarkHelper

newtype Color = C Int deriving (Storable,Enum)

#define Y (C 2)
#define R (C 1)
#define B (C 0)

instance Show Color where
	show Y = "yellow"
	show R = "red"
	show B = "blue"

complement :: Color -> Color -> Color
complement !a !b = case a of
    B -> case b of R -> Y; B -> B; _ -> R
    R -> case b of B -> Y; R -> R; _ -> B
    Y -> case b of B -> R; Y -> Y; _ -> B

type Chameneous = Ptr Color
data MP = Nobody !Int | Somebody !Int !Chameneous !(MVar Chameneous)

arrive :: MVar MP -> MVar (Int, Int) -> Chameneous -> IO ()
arrive !mpv !finish !ch = do
    waker <- newEmptyMVar
    let inc x = (fromEnum (ch == x) +)
        go !t !b = do
            w <- takeMVar mpv
            case w of
                Nobody 0
                 -> do
                    putMVar mpv w
                    putMVar finish (t, b)
  		Nobody q -> do
                    putMVar mpv $ Somebody q ch waker
                    ch' <- takeMVar waker
                    go (t+1) $ inc ch' b

                Somebody q ch' waker' -> do
                    c  <- peek ch
                    c' <- peek ch'
                    let !c'' = complement c c'
                    poke ch  c''
                    poke ch' c''
                    putMVar waker' ch
                    let !q' = q-1
                    putMVar mpv $ Nobody q'
                    go (t+1) $ inc ch' b
    go 0 0

showN = unwords . map ((digits !!) . digitToInt) . show

digits = words "zero one two three four five six seven eight nine"

run :: (String -> IO ()) -> Int -> Int -> [Color] -> IO (IO ())
run fibonPutStr n cpu cs = do
    fs    <- replicateM (length cs) newEmptyMVar
    mpv   <- newMVar (Nobody n)
    withArrayLen cs $ \ n cols -> do
    	zipWithM_ ((forkOn cpu .) . arrive mpv) fs (take n (iterate (`advancePtr` 1) cols))

    	return $ do
	  fibonPutStr . map toLower . unwords . ([]:) . map show $ cs
	  ns    <- mapM takeMVar fs
    -- dmp: commenting this out to reduce output variabilty
	  --putStr . map toLower . unlines $ [unwords [show n, showN b] | (n, b) <- ns]
	  fibonPutStr . (" "++) . showN . sum . map fst $ ns
	  fibonPutStr ""

oldmain 0   = return ()
oldmain cnt = do
    fibonPutStr . map toLower . unlines $
        [unwords [show a, "+", show b, "->", show $ complement a b]
            | a <- [B..Y], b <- [B..Y]]

    n <- readIO . head =<< getArgs
    actions <- zipWithM (run fibonPutStr n) [0..] [[B..Y],[B,R,Y,R,Y,B,R,Y,R,B]]
    sequence_ actions
    oldmain (cnt-1)
    where
      fibonPutStr :: String -> IO ()
      fibonPutStr = if cnt == 1 then putStrLn else flip deepseq (return ())

main = fibonMain oldmain
