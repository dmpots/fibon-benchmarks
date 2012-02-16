{-# OPTIONS_GHC -fno-warn-missing-signatures #-}
module Fibon.Benchmarks.Shootout.Pidigits.Fibon.Instance(
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
    , output         = [(Stdout, Diff "pidigits.stdout.expected")]
    , expectedExit   = ExitSuccess
    , exeName        = "Pidigits"
  }
flgCfg = flagConfig sharedConfig

mkInstance Test = sharedConfig {
        flagConfig = flgCfg {runFlags = ["10"]}
    }
mkInstance Train = sharedConfig {
        flagConfig = flgCfg {runFlags = ["350"]}
    }
mkInstance Ref  = sharedConfig {
        flagConfig = flgCfg {runFlags = ["-r", "170", "10000"]}
    }

