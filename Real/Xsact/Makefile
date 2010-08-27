# $Id: Makefile 645 2004-04-07 10:31:43Z ketil $
# need this on our Solaris box
LFLAGS = -L/usr/local/lib

HC = ghc # -package util -package lang -package data
FLAGS =  -fglasgow-exts $(LFLAGS) -fno-warn-unused-matches -fno-warn-unused-binds -W
PFLAGS = $(FLAGS) -O2 -prof -auto-all -hisuf p.hi -osuf p.o 
OFLAGS = $(FLAGS) -O2 -funbox-strict-fields

SRC =  Suffix.lhs EST.lhs Indexed.lhs Fasta.lhs Gene.hs Util.hs hooks.o
DVI = Xsact.dvi Cluster.dvi Suffix.dvi EST.dvi Indexed.dvi Pairs.dvi \
      Fasta.dvi Clix.dvi Xplit.dvi Xtract.dvi WordMap.dvi SpliceGraph.dvi

XSACTSRC = Xsact.lhs Cluster.lhs ANSI.lhs Clix.lhs Pairs.lhs Stats.hs
XPLITSRC = Xplit.lhs
XTRACTSRC = Xtract.lhs WordMap.lhs SpliceGraph.lhs 
XCERPTSRC = Xcerpt.lhs Util.hs

PRT 	= slp6

all: xsact xplit xcerpt # xsactp xtract dvi

# Links statically with libc, useful for compiling on the bleeding edge
static: xsact-static xplit-static xcerpt-static # xtract-static

test: quicktest bigtest

quicktest: quicktest-xsact  # quicktest-xtract 

quicktest-xtract: xtract
	sh test-xtract/test.sh

quicktest-xsact: xsact
	sh test-xsact/test.sh

bigtest: xsact
	sh test-xsact/bigtest.sh

time: xsact
	sh test-xsact/time.sh

xsact: $(XSACTSRC) $(SRC) 
	$(HC) $(OFLAGS) --make Xsact.lhs hooks.o -o xsact

xsactp: $(XSACTSRC) $(SRC)
	$(HC) $(PFLAGS) --make Xsact.lhs hooks.o -o xsactp

xsact-static: $(XSACTSRC) $(SRC)
	$(HC) $(OFLAGS) -optl-static --make Xsact.lhs hooks.o -o xsact-static


xplit: $(XPLITSRC)
	$(HC) $(OFLAGS) --make Xplit.lhs -o xplit

xplit-static: $(XPLITSRC)
	$(HC) $(OFLAGS) -optl-static --make Xplit.lhs -o xplit-static


xcerpt: $(XCERPTSRC)
	$(HC) $(OFLAGS) --make Xcerpt.lhs -o xcerpt

xtract-warn:
	@echo "Warning: xtract is deprecated"

xtract: $(XTRACTSRC) $(SRC) xtract-warn
	$(HC) $(OFLAGS) --make Xtract.lhs hooks.o -o xtract

xtractp: $(XTRACTSRC) $(SRC) xtract-warn
	$(HC) $(PFLAGS) --make Xtract.lhs hooks.o -o xtractp

xtract-static: $(XTRACTSRC) $(SRC) xtract-warn
	$(HC) $(OFLAGS) -optl-static --make Xtract.lhs hooks.o -o xtract-static

hooks.o: hooks.c
	ghc -c hooks.c

dvi: $(DVI)

print: $(DVI)
	for a in $(DVI); do dvips -P$(PRT) $$a; done

$(DVI): %.dvi: %.lhs
	latex $<

clean: 
	rm -f *.o *.hi *.aux *.dvi *.log *~ 
