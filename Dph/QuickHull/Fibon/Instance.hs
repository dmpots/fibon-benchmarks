{-# OPTIONS_GHC -fno-warn-missing-signatures #-}
module Fibon.Benchmarks.Dph.QuickHull.Fibon.Instance(
  mkInstance
)
where
import Fibon.BenchmarkInstance

sharedConfig = BenchmarkInstance {
    flagConfig = FlagConfig {
        configureFlags = ["--ghc-option=-fdph-par"]
      , buildFlags     = []
      , runFlags       = []
      }
    , stdinInput     = Nothing
    , output         = [(Stdout, Diff "quickhull.stdout.expected")]
    , expectedExit   = ExitSuccess
    , exeName        = "QuickHull"
  }
flgCfg = flagConfig sharedConfig

mkInstance Test = sharedConfig {
        flagConfig = flgCfg {runFlags = ["100"]}
    }
mkInstance Train = sharedConfig {
        flagConfig = flgCfg {runFlags = ["1000000"]}
    }
mkInstance Ref  = sharedConfig {
        flagConfig = flgCfg {runFlags = words "1000000 -r 400"}
    }

