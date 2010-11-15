TOP = ../../..
include $(TOP)/mk/boilerplate.mk
SRCS = generated/Codec/Compression/BZip/Stream.hs \
       Codec/Compression/BZip/Internal.hs \
       Codec/Compression/BZip.hs \
       Main.hs
PROG_ARGS += mito.aa.bz2
HC_OPTS += -i. -igenerated -package base -package bytestring -lbz2
include $(TOP)/mk/target.mk
