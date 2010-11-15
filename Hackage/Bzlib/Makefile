TOP = ../../..
include $(TOP)/mk/boilerplate.mk
SRCS = dist/build/hsbzip/hsbzip-tmp/Codec/Compression/BZip/Stream.hs \
       Codec/Compression/BZip/Internal.hs \
       Codec/Compression/BZip.hs \
       Main.hs
PROG_ARGS += mito.aa.bz2
HC_OPTS += -i. -package base -package bytestring
include $(TOP)/mk/target.mk
