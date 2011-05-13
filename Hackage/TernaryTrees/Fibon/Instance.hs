{-# OPTIONS_GHC -fno-warn-missing-signatures #-}
module Fibon.Benchmarks.Hackage.TernaryTrees.Fibon.Instance (
  mkInstance
)
where
import Fibon.BenchmarkInstance

sharedConfig = BenchmarkInstance {
    flagConfig = FlagConfig {
        configureFlags = []
      , buildFlags     = []
      , runFlags       = []
      }
    , stdinInput     = Nothing
    , output         = [(Stdout, Diff "tdict.stdout.expected")]
    , expectedExit   = ExitSuccess
    , exeName        = "TernaryTrees"
  }
flgCfg = flagConfig sharedConfig

mkInstance Test = sharedConfig {
        flagConfig = flgCfg {runFlags = ["words", "theend.txt"]}
    }
mkInstance Train = sharedConfig {
        flagConfig = flgCfg {runFlags = ["words", "olivertwist.txt"]}
    }
mkInstance Ref  = sharedConfig {
        flagConfig = flgCfg {runFlags = ["-r", "300", "words", "olivertwist.txt"]}
    }



