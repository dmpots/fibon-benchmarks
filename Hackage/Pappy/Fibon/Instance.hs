{-# OPTIONS_GHC -fno-warn-missing-signatures #-}
module Fibon.Benchmarks.Hackage.Pappy.Fibon.Instance(
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
    , output         = [(Stdout, Diff "java-parser.stdout.expected")]
    , expectedExit   = ExitSuccess
    , exeName        = "Pappy"
  }
flgCfg = flagConfig sharedConfig
trainFiles = [ "Scar.java", "SPEED.java", "Blowfish.java", "CAST5.java",
               "DES.java", "TestRijndael.java" ]


mkInstance Test = sharedConfig {
        flagConfig = flgCfg {runFlags = ["HexDump.java"]}
    }
mkInstance Train = sharedConfig {
        flagConfig = flgCfg {runFlags = trainFiles}
    }
mkInstance Ref  = sharedConfig {
        flagConfig = flgCfg {runFlags = ["-r", "250"] ++ trainFiles}
    }

