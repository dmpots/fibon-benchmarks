-----------------------------------------------------------------------------
-- |
-- Module      :  Data.Algorithms.Palindromes.Main
-- Copyright   :  (c) 2007 - 2010 Johan Jeuring
-- License     :  BSD3
--
-- Maintainer  :  johan@jeuring.net
-- Stability   :  experimental
-- Portability :  portable
--
-----------------------------------------------------------------------------
module Main where

import System.Environment (getArgs)
import System.Console.GetOpt 

import Data.Algorithms.Palindromes.Options

import Fibon.Run.BenchmarkHelper

-----------------------------------------------------------------------------
-- main
-----------------------------------------------------------------------------

handleFilesWith :: Int -> (String -> String) -> [String] -> IO ()
handleFilesWith iters f = 
  let hFW filenames = 
        case filenames of
          []        ->  putStr (f "")
          (fn:fns)  ->  do  input <- readFile fn
                            let res = f input in do
                            fibonOutput (putStrLn  res) res
                            hFW fns
      fibonOutput a b = if iters == 1 then a else deepseq b (return ())
  in hFW                                 


handleStandardInputWith :: (String -> String) -> IO ()
handleStandardInputWith function = 
  do input <- getContents
     putStrLn (function input) 

main :: IO ()
main = fibonMain oldmain

oldmain :: Int -> IO ()
oldmain 0 = return ()
oldmain n = do  args <- getArgs
                let (optionArgs,files,errors) = getOpt Permute options args
                if not (null errors) 
                  then putStrLn (concat errors) 
                  else let (function,fromfile) = handleOptions optionArgs
                      in  if fromfile 
                          then handleFilesWith n function files  >> oldmain (n-1)
                          else handleStandardInputWith function  >> oldmain (n-1)
    
    
