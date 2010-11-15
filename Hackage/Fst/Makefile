TOP = ../../..
include $(TOP)/mk/boilerplate.mk
SRCS = FST/GetOpt.hs \
       FST/Alex.hs \
       FST/Lexer.hs \
       FST/RegTypes.hs \
       FST/AutomatonTypes.hs \
       FST/StateMonad.hs \
       FST/Utils.hs \
       FST/Automaton.hs \
       FST/Complete.hs \
       FST/Deterministic.hs \
       FST/Reversal.hs \
       FST/MinimalBrzozowski.hs \
       FST/LBFA.hs \
       FST/AutomatonInterface.hs \
       FST/TransducerTypes.hs \
       FST/Transducer.hs \
       FST/RunTransducer.hs \
       FST/DeterministicT.hs \
       FST/ReversalT.hs \
       FST/MinimalTBrzozowski.hs \
       FST/EpsilonFreeT.hs \
       FST/Arguments.hs \
       FST/RRegTypes.hs \
       FST/LBFT.hs \
       FST/NReg.hs \
       FST/Parse.hs \
       FST/FileImport.hs \
       FST/TransducerInterface.hs \
       FST/Info.hs \
       FST/Main.hs
PROG_ARGS += -u soda.fst
STDIN_FILE = PLONK
HC_OPTS += -i. -package array -package base -package haskell98
include $(TOP)/mk/target.mk
