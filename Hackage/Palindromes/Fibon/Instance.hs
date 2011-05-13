{-# OPTIONS_GHC -fno-warn-missing-signatures #-}
module Fibon.Benchmarks.Hackage.Palindromes.Fibon.Instance(
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
    , output         = [(Stdout, Diff "palindromes.stdout.expected")]
    , expectedExit   = ExitSuccess
    , exeName        = "Palindromes"
  }
flgCfg = flagConfig sharedConfig
trainFiles = ["annakarenina.txt",
              "huckfinn.txt",
              "olivertwist.txt",
              "swannsway.txt" ]

mkInstance Test = sharedConfig {
        flagConfig = flgCfg {runFlags = ["-s", "small"]}
    }
mkInstance Train = sharedConfig {
        flagConfig = flgCfg {runFlags = ["-s"] ++ trainFiles}
    }
mkInstance Ref  = sharedConfig {
        flagConfig = flgCfg {runFlags = ["-r", "120"] ++ ["-s"] ++ trainFiles}
    }
