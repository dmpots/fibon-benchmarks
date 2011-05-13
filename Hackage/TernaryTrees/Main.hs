module Main where
    
import Data.Binary
import Data.Set.TernarySet
-- These imports are here for testing mainly
-- import Data.Set.StringSet
-- import Data.Map.TernaryMap
-- import qualified Data.Set.StringSet
-- import qualified Data.Map.TernaryMap
-- import Data.Set
import System.IO
import System.Environment

import Fibon.Run.BenchmarkHelper
import Control.Monad

main = fibonMain oldmain

oldmain :: Int -> IO ()
oldmain 0 = return ()
oldmain n = do
    (file:queries:_) <- getArgs -- get file name
    contents <- readFile file -- read the file contents
    -- input <- getContents
    let wds = words contents -- separate the words
        tree = fromList $ wds -- put them in the tree
        newname = (file ++ ".bin")
    -- print . treeSize $ tree
    
    when (n == 1) $ putStr "All input words are in dictionary: "
    fibonOutput . all (`member` tree) $ wds -- make sure all words are actually in the tree
    
    when (n == 1) $ putStr "Same number of words as input: "
    fibonOutput (size tree == length wds) -- make sure the same number of words are in the tree
    
    when (n == 1) $ putStr ("Writing " ++ newname ++ "... ")
    encodeFile newname tree -- write the tree to a file as "filename.bin"
    
    when (n == 1) $ putStr "done.\nReading data back in... "
    ntree <- decodeFile newname -- read in the file and decode it
    
    when (n == 1) $ putStr "done.\nRead in data matches original: "
    fibonOutput (tree == ntree) -- check the read in tree is the same as the one we wrote
        -- 
    -- Comment out these lines for benchmarking.
    when (n == 1) $ putStrLn "\n-- Enter a word to see if it is in the dictionary (^C to exit):"
    withFile queries ReadMode (hInteract fibonOutput (`member` tree))
    oldmain (n-1)
    where
      fibonOutput :: (Show a, NFData a) => a -> IO ()
      fibonOutput a = if n == 1 then putStrLn (show a) else deepseq a (return ())

hInteract :: (Bool -> IO ()) -> (String -> Bool) -> Handle  -> IO ()
hInteract fibonOutput f h = do
    eof <- hIsEOF h
    if eof
      then return ()
      else do
        line <- hGetLine h
        mapM_  (fibonOutput . f) (words line)
        hInteract fibonOutput f h
