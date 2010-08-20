{-# OPTIONS_GHC -fno-warn-missing-signatures #-}
module Fibon.Benchmarks.Hackage.Agum.Fibon.Instance(
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
    , output         = [(Stdout, Diff "agum.stdout.expected")]
    , localPath      = "Hackage/Agum"
    , exeName        = "agum"
  }
flgCfg = flagConfig sharedConfig

mkInstance Test = sharedConfig {
        stdinInput = Just "eqn.txt"
    }
mkInstance Ref  = sharedConfig {
        flagConfig = flgCfg
    }

