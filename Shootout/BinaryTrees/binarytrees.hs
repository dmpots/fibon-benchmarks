--
-- The Great Computer Language Shootout
-- http://shootout.alioth.debian.org/
--
-- Contributed by Don Stewart
--

import System.Environment

import Fibon.Run.BenchmarkHelper

data Tree = Nil | Node !Int Tree Tree

minN :: Int
minN = 4

io i s n t = 
  if i == 1 then
    putStrLn $ s ++ " of depth "++show n++ "\t check: " ++ show t
  else
    s `deepseq` n `deepseq` t `deepseq` return ()

main = fibonMain oldmain

oldmain 0 = return ()
oldmain cnt = do
    n <- fmap (read . head) getArgs
    let maxN     = max (minN + 2) n
        stretchN = maxN + 1

    -- stretch memory tree
    let c = check (make 0 stretchN)
    io cnt "stretch tree" stretchN c

    -- allocate a long lived tree
    let long    = make 0 maxN

    -- allocate, walk, and deallocate many bottom-up binary trees
    let vs = depth minN maxN
    mapM_ (\((m,d,i)) -> io cnt (show m ++ "\t trees") d i) vs

    -- confirm the the long-lived binary tree still exists
    io cnt "long lived tree" maxN (check long)

    oldmain (cnt-1)

-- generate many trees
depth :: Int -> Int -> [(Int,Int,Int)]
depth d m
    | d <= m    = (2*n,d,sumT d n 0) : depth (d+2) m
    | otherwise = []
  where n = 2 ^ (m - d + minN) :: Int

-- allocate and check lots of trees
sumT :: Int -> Int -> Int -> Int
sumT  d i t | d `seq` False = undefined -- strictness hint
sumT  d 0 t = t
sumT  d i t = sumT d (i-1) (t + a + b)
  where a = check (make i    d)
        b = check (make (-i) d)

-- traverse the tree, counting up the nodes
check :: Tree -> Int
check Nil          = 0
check (Node i l r) = i + check l - check r

-- build a tree
make :: Int -> Int -> Tree
make i 0 = Node i Nil Nil
make i d = Node i (make (i2-1) d2) (make i2 d2)
  where i2 = 2*i; d2 = d-1

