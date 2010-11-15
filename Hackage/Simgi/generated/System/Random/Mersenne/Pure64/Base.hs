{-# LINE 1 "mersenne-random-pure64/System/Random/Mersenne/Pure64/Base.hsc" #-}
{-# LANGUAGE EmptyDataDecls, CPP, ForeignFunctionInterface #-}
{-# LINE 2 "mersenne-random-pure64/System/Random/Mersenne/Pure64/Base.hsc" #-}
--------------------------------------------------------------------
-- |
-- Module     : System.Random.Mersenne.Pure64.Base
-- Copyright  : Copyright (c) 2008, Don Stewart <dons@galois.com>
-- License    : BSD3
-- Maintainer : Don Stewart <dons@galois.com>
-- Stability  : experimental
-- Portability: CPP, FFI, EmptyDataDecls
-- Tested with: GHC 6.8.3
--
-- A purely functional binding 64 bit binding to the classic mersenne
-- twister random number generator. This is more flexible than the
-- impure 'mersenne-random' library, at the cost of being a bit slower.
-- This generator is however, many times faster than System.Random,
-- and yields high quality randoms with a long period.
--
module System.Random.Mersenne.Pure64.Base where


{-# LINE 21 "mersenne-random-pure64/System/Random/Mersenne/Pure64/Base.hsc" #-}

{-# LINE 22 "mersenne-random-pure64/System/Random/Mersenne/Pure64/Base.hsc" #-}

{-# LINE 23 "mersenne-random-pure64/System/Random/Mersenne/Pure64/Base.hsc" #-}

import Foreign.C.Types
import Foreign

data MTState

type UInt64 = CULLong

------------------------------------------------------------------------
-- pure version:

foreign import ccall unsafe "init_genrand64"
    c_init_genrand64  :: Ptr MTState -> UInt64 -> IO ()

foreign import ccall unsafe "genrand64_int64"
    c_genrand64_int64 :: Ptr MTState -> IO UInt64

foreign import ccall unsafe "genrand64_real2"
    c_genrand64_real2 :: Ptr MTState -> IO CDouble

sizeof_MTState :: Int
sizeof_MTState = (2500) -- 2504 bytes
{-# LINE 45 "mersenne-random-pure64/System/Random/Mersenne/Pure64/Base.hsc" #-}

------------------------------------------------------------------------
-- block based version:
foreign import ccall unsafe "mix_bits"
    c_mix_word64 :: Word64 -> Word64

foreign import ccall unsafe "seed_genrand64_block"
    c_seed_genrand64_block :: Ptr a -> Word64 -> IO ()

foreign import ccall unsafe "next_genrand64_block"
    c_next_genrand64_block :: Ptr a -> Ptr a -> IO ()

-- | length of an MT block
blockLen :: Int
blockLen = (312)
{-# LINE 60 "mersenne-random-pure64/System/Random/Mersenne/Pure64/Base.hsc" #-}

-- | size of an MT block, in bytes
blockSize :: Int
blockSize = (2496)
{-# LINE 64 "mersenne-random-pure64/System/Random/Mersenne/Pure64/Base.hsc" #-}

------------------------------------------------------------------------
-- model: (for testing purposes)

foreign import ccall unsafe "init_genrand64_unsafe"
    c_init_genrand64_unsafe :: UInt64 -> IO ()

foreign import ccall unsafe "genrand64_int64_unsafe"
    c_genrand64_int64_unsafe :: IO UInt64

foreign import ccall unsafe "genrand64_real2_unsafe"
    c_genrand64_real2_unsafe :: IO CDouble

foreign import ccall unsafe "string.h memcpy"
    c_memcpy :: Ptr Word8 -> Ptr Word8 -> CSize -> IO (Ptr Word8)
