{-# OPTIONS_GHC -fno-warn-missing-signatures #-}
module Fibon.Benchmarks.Real.HaLeX.Fibon.Instance (
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
    , output         = [(Stdout, Diff "halex.stdout.expected")]
    , localPath      = "Hackage/HaLeX"
    , exeName        = "halex"
  }
flgCfg = flagConfig sharedConfig

mkInstance :: InputSize -> BenchmarkInstance
mkInstance Test = sharedConfig {flagConfig = flgCfg {runFlags = ["vowles"]}}
mkInstance Ref  = sharedConfig {flagConfig = flgCfg {runFlags = ["real"]}}

