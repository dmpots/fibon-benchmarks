TOP = ../../..
include $(TOP)/mk/boilerplate.mk
SRCS = Data/Set/TernarySet/Internal.hs \
       Data/Set/TernarySet.hs \
       Main.hs
PROG_ARGS += olivertwist.txt
STDIN_FILE = words
HC_OPTS += -i. -package base -package binary
include $(TOP)/mk/target.mk
