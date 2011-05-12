{-# OPTIONS_GHC -fno-warn-missing-signatures #-}
module Fibon.Benchmarks.Hackage.Happy.Fibon.Instance(
  mkInstance
)
where
import Fibon.BenchmarkInstance

sharedConfig = BenchmarkInstance {
    flagConfig = FlagConfig {
        configureFlags = []
      , buildFlags     = []
      , runFlags       = ["-t", "."]
      }
    , stdinInput     = Nothing
    , output         = [(Stderr, Diff "happy.stderr.expected")]
    , expectedExit   = ExitSuccess
    , exeName        = "Happy"
  }
flgCfg = flagConfig sharedConfig
trainFiles = ["Bio.y", "ErlParser.ly", "HaskellParser.y", "TestInput.y"]
trainOutput = output sharedConfig ++ 
              [(OutputFile "TestInput.hs", Diff "TestInput.hs.expected")]


mkInstance Test = sharedConfig {
      flagConfig = flgCfg {runFlags = runFlags flgCfg ++ ["CmmParse.y"]}
    , output     = (output sharedConfig) ++
                   [(OutputFile "CmmParse.hs",Diff "CmmParse.hs.expected")]
    }
mkInstance Train = sharedConfig {
      flagConfig = flgCfg {runFlags = runFlags flgCfg ++ trainFiles}
    , output     = trainOutput    
    }
mkInstance Ref = sharedConfig {
      flagConfig = flgCfg {runFlags = ["-r", "180"] ++ runFlags flgCfg ++ trainFiles}
    , output     = trainOutput    
    }
