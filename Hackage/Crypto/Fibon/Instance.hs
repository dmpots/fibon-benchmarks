{-# OPTIONS_GHC -fno-warn-missing-signatures #-}
module Fibon.Benchmarks.Hackage.Crypto.Fibon.Instance(
  mkInstance
)
where
import Fibon.BenchmarkInstance

sharedConfig = BenchmarkInstance {
    flagConfig = FlagConfig {
        configureFlags = []
      , buildFlags     = []
      , runFlags       = ["plain.txt"]
      }
    , stdinInput     = Nothing
    , output         = [(Stdout, Diff "crypto.stdout.expected")]
    , expectedExit   = ExitSuccess
    , exeName        = "Crypto"
  }
flgCfg = flagConfig sharedConfig

mkInstance Test = sharedConfig {
        flagConfig = flgCfg
    }
mkInstance Train = sharedConfig {
        flagConfig = flgCfg
    }
mkInstance Ref  = sharedConfig {
        flagConfig = flgCfg {runFlags = words "-r 15 plain.txt"}
    }

