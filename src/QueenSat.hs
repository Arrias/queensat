module QueenSat (queenSat) where

import Util 
import Picosat

type Clause = [Int]
type CNF = [Clause]

genAtLeastOneInRowClauses :: Int -> CNF -> CNF 
genAtLeastOneInRowClauses n = (++) $ splitOn (\x -> x `mod` n == 0) [1..(n*n)]

-- j /= k 
genBeatClauses n i j k  =  let revI = n - i + 1
                               revJ = n - j + 1
                               revK = n - k + 1
                               t1   = i - (j - k)
                               t2   = i + (j - k)
                           in consIf True [-getNum n revJ revI, -getNum n revK revI] 
                            . consIf (1 <= t1 && t1 <= n) [-getNum n j i, -getNum n k t1]
                            . consIf (1 <= t2 && t2 <= n) [-getNum n j i, -getNum n k t2] 
                            $ [[-getNum n i j, -getNum n i k]]

-- O(n^3) gen beat conditions
genRowsColsDiagBeatClauses :: Int -> CNF -> CNF 
genRowsColsDiagBeatClauses n = (++) $ do 
            i <- [1..n]
            j <- [1..n]
            k <- [1..n]
            True <- [j /= k]
            genBeatClauses n i j k 

genSat n = (genAtLeastOneInRowClauses n) 
         . (genRowsColsDiagBeatClauses n)
         $ [] 

queenSat n = solve $ genSat n