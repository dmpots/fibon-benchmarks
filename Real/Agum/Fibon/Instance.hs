{-# OPTIONS_GHC -fno-warn-missing-signatures #-}
module Fibon.Benchmarks.Real.Agum.Fibon.Instance(
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
    , stdinInput     = Just "eqn.txt"
    , output         = [(Stdout, Diff "agum.stdout.expected")]
    , localPath      = "Hackage/Agum"
    , exeName        = "agum"
  }
flgCfg = flagConfig sharedConfig

mkInstance Test = sharedConfig {
        flagConfig = flgCfg
    }
mkInstance Ref  = sharedConfig {
        flagConfig = flgCfg
    }

