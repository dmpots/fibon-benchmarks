{-# OPTIONS_GHC -fno-warn-missing-signatures #-}
module Fibon.Benchmarks.Dph.Dotp.Fibon.Instance(
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
    , output         = [(Stdout, Diff "Dotp.stdout.expected")]
    , expectedExit   = ExitSuccess
    , exeName        = "Dotp"
  }
flgCfg = flagConfig sharedConfig

mkInstance Test = sharedConfig {
        flagConfig = flgCfg {runFlags = ["100"]}
    }
mkInstance Train = sharedConfig {
        flagConfig = flgCfg {runFlags = ["50000000"]}
    }
mkInstance Ref  = sharedConfig {
        flagConfig = flgCfg {runFlags = words "50000000 -r 3000"}
    }

