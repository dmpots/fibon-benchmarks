{-# OPTIONS_GHC -fno-warn-missing-signatures #-}
module Fibon.Benchmarks.Hackage.HaLeX.Fibon.Instance (
  mkInstance
)
where
import Fibon.BenchmarkInstance

sharedConfig = BenchmarkInstance {
    flagConfig = FlagConfig {
        configureFlags = []
      , buildFlags     = []
      , runFlags       = ["-o","dfa.hs"]
      }
    , stdinInput     = Nothing
    , output         = [(OutputFile "dfa.hs", Diff "dfa.hs.expected")]
    , expectedExit   = ExitSuccess
    , exeName        = "HaLex"
  }
flgCfg = flagConfig sharedConfig

mkInstance :: InputSize -> BenchmarkInstance
mkInstance Test = sharedConfig {
    flagConfig = flgCfg {runFlags = (runFlags flgCfg) ++ ["vowles"]}
  }
mkInstance Train = sharedConfig {
    flagConfig = flgCfg {runFlags = (runFlags flgCfg) ++ ["real"]}
  }
mkInstance Ref  = sharedConfig {
    flagConfig = flgCfg {runFlags = (runFlags flgCfg) ++ ["-r", "200", "real"]}
  }


