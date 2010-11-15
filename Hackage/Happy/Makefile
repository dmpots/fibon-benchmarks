TOP = ../../..
include $(TOP)/mk/boilerplate.mk
SRCS = src/NameSet.hs \
       src/Target.lhs \
       src/AbsSyn.lhs \
       src/ParamRules.hs \
       src/GenUtils.lhs \
       src/ParseMonad.lhs \
       src/Lexer.lhs \
       dist/build/happy/happy-tmp/Parser.hs \
       src/AttrGrammar.lhs \
       dist/build/happy/happy-tmp/AttrGrammarParser.hs \
       src/Grammar.lhs \
       src/First.lhs \
       src/LALR.lhs \
       dist/build/autogen/Paths_happy.hs \
       src/ProduceCode.lhs \
       src/ProduceGLRCode.lhs \
       src/Info.lhs \
       src/Main.lhs
PROG_ARGS += -t . Bio.y ErlParser.ly HaskellParser.y TestInput.y
HC_OPTS += -isrc -package array -package base -package containers -package mtl
include $(TOP)/mk/target.mk
