module Fibon.Benchmarks.Hackage.HaLeX (
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

}

mkInstance :: InputSize -> BenchmarkInstance
mkInstance Test = sharedConfig {flagConfig = flgCfg {runFlags = "vowles"}}
mkInstance Ref  = sharedConfig {flagConfig = flgCfg {runFlags = "real"}}
  where flgCfg = flagConfig sharedConfig

