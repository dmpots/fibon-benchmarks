{-# LANGUAGE BangPatterns #-}
module Main(main) where
import Data.Graph.Inductive.Graph
import Data.Graph.Inductive.Graphviz
import Data.Graph.Inductive.PatriciaTree
import Data.Graph.Inductive.Query.DFS
import Data.Graph.Inductive.Query.BCC
import qualified Data.IntSet as Set
import System.Environment
import qualified Data.ByteString.Char8 as B

import Fibon.Run.BenchmarkHelper
import Control.Monad(when)

main = fibonMain oldmain

oldmain 0 = return ()
oldmain n = do
  fs <- getArgs
  mapM_ (doAlgs (n == 1)) fs
  oldmain (n-1)

doAlgs :: Bool -> FilePath -> IO ()
doAlgs fibonShow f = do
  mbG <- readDimacsGraph f
  case mbG of
    Just (nodes,edges) -> do
      let g = mkUGraph nodes edges :: UGr
      when fibonShow (putStrLn f)
      let g' = bcc g
      let ts = concatMap topsort g'
      g' `seq` ts `seq` when fibonShow $ putStrLn (show ts)
    Nothing -> putStrLn $ "Graph parse failed for file: "++f

printG :: UGr -> IO ()
printG g = putStrLn $ graphviz g "" (1.0,1.0) (1,1) Landscape

readDimacsGraph :: FilePath -> IO (Maybe ([Node], [Edge]))
readDimacsGraph f = do
  contents <- B.readFile f
  case go (B.lines contents) (Set.empty) [] of 
    Right r -> return   (Just r)
    Left  e -> putStrLn ("Bad line: "++ (B.unpack e)) >> return Nothing
  where
    go  []       !ns !es = Right ((Set.toList ns), es)
    go (line:ls) !ns !es = 
      if (B.pack "e ") `B.isPrefixOf` line then
        case B.readInt (B.drop 2 line) of 
          Just (u, v') ->
            case B.readInt (B.drop 1 v') of
              Just (v, _) -> go ls (Set.insert u ns) ((u, v):es)
              Nothing     -> Left line
          Nothing -> Left line
      else
        go ls ns es

