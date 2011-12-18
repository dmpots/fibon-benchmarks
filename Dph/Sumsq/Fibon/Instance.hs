{-# OPTIONS_GHC -fno-warn-missing-signatures #-}
module Fibon.Benchmarks.Dph.Sumsq.Fibon.Instance(
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
    , output         = [(Stdout, Diff "sumsq.stdout.expected")]
    , expectedExit   = ExitSuccess
    , exeName        = "Sumsq"
  }
flgCfg = flagConfig sharedConfig

mkInstance Test = sharedConfig {
        flagConfig = flgCfg {runFlags = ["100"]}
    }
mkInstance Train = sharedConfig {
        flagConfig = flgCfg {runFlags = ["2000000000"]}
    }
mkInstance Ref  = sharedConfig {
        flagConfig = flgCfg {runFlags = words "2000000000 -r 70"}
    }

