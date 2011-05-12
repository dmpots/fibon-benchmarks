{-# OPTIONS_GHC -fno-warn-missing-signatures #-}
module Fibon.Benchmarks.Hackage.Gf.Fibon.Instance(
  mkInstance
)
where
import Fibon.BenchmarkInstance

sharedConfig = BenchmarkInstance {
    flagConfig = FlagConfig {
        configureFlags = []
      , buildFlags     = []
      , runFlags       = ["--quiet", "--src", "--make", "-f", "haskell"]
      }
    , output         = []
    , expectedExit   = ExitSuccess
    , stdinInput     = Nothing
    , exeName        = "Gf"
  }
flgCfg = flagConfig sharedConfig
trainFiles = ["Eng.gf", "EngReal.gf",  "FreDescr.gf",
              "EngDescr.gf", "Fre.gf", "FreReal.gf"]

mkInstance Test = sharedConfig {
        output         = [(OutputFile "RDF.hs", Diff "RDF.hs.expected")]
      , flagConfig = flgCfg {runFlags = (runFlags flgCfg) ++ ["RDF.gf"]}
    }
mkInstance Train = sharedConfig {
        output         = [(OutputFile "Fre.hs", Diff "Fre.hs.expected")]
      , flagConfig = flgCfg {
          runFlags = (runFlags flgCfg) ++ trainFiles
        }
    }
mkInstance Ref  = sharedConfig {
        output         = [(OutputFile "Fre.hs", Diff "Fre.hs.expected")]
      , flagConfig = flgCfg {
          runFlags = ["-r", "150"] ++ (runFlags flgCfg) ++ trainFiles
        }
    }

