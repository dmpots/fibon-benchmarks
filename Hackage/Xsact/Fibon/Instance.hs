{-# OPTIONS_GHC -fno-warn-missing-signatures #-}
module Fibon.Benchmarks.Hackage.Xsact.Fibon.Instance(
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
    , output         = [(Stdout, Diff "xsact.stdout.expected")]
    , expectedExit   = ExitSuccess
    , exeName        = "Xsact"
  }
flgCfg = flagConfig sharedConfig

mkInstance Test = sharedConfig {
        flagConfig = flgCfg {runFlags = ["-i", "alu.n"]}
    }
mkInstance Train = sharedConfig {
        flagConfig = flgCfg {runFlags = ["-i", "pdbnt"]}
    }
mkInstance Ref  = sharedConfig {
        flagConfig = flgCfg {runFlags = ["-r", "90", "-i", "pdbnt"]}
    }

