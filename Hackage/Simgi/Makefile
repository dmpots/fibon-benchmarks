TOP = ../../..
include $(TOP)/mk/boilerplate.mk
SRCS = parsec-2/Text/ParserCombinators/Parsec/Pos.hs \
       parsec-2/Text/ParserCombinators/Parsec/Error.hs \
       parsec-2/Text/ParserCombinators/Parsec/Prim.hs \
       parsec-2/Text/ParserCombinators/Parsec/Combinator.hs \
       parsec-2/Text/ParserCombinators/Parsec/Char.hs \
       dist/build/simgi/simgi-tmp/System/Random/Mersenne/Pure64/Base.hs \
       mersenne-random-pure64/System/Random/Mersenne/Pure64/MTBlock.hs \
       mersenne-random-pure64/System/Random/Mersenne/Pure64.hs \
       src/RpnData.hs \
       src/GenericModel.hs \
       src/RpnCalc.hs \
       src/ExtraFunctions.hs \
       parsec-2/Text/ParserCombinators/Parsec.hs \
       parsec-2/Text/ParserCombinators/Parsec/Token.hs \
       parsec-2/Text/ParserCombinators/Parsec/Language.hs \
       src/TokenParser.hs \
       src/RpnParser.hs \
       src/Messages.hs \
       src/IO.hs \
       src/InputCheck.hs \
       src/InputParser.hs \
       src/Engine.hs \
       src/CommandLine.hs \
       src/simgi.hs
PROG_ARGS += oregonator.sgl
HC_OPTS += -isrc -iparsec-2 -imersenne-random-pure64 -package base -package containers -package haskell98 -package mtl -package old-time -package random
include $(TOP)/mk/target.mk
