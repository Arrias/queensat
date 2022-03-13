module Lib where

import Picosat
import Control.Monad

splitOn :: (a->Bool) -> [a] -> [[a]]
splitOn pr ar = case ar of 
                [] -> []
                (x:xs) -> let p = splitOn pr xs in 
                    if pr x then 
                        [[x]] ++ (splitOn pr xs)
                    else 
                        case p of 
                            [] -> [[x]]
                            (y:ys) -> (([x] ++ y) : ys)

getNum :: Int -> Int -> Int -> Int 
getNum n a b = n * (a - 1) + b

genAtLeastOneInRow n = (++) $ splitOn (\x -> x `mod` n == 0) [1..(n*n)]

genRowsColsBeatClauses n = (++) $ do 
            i <- [1..n]
            j <- [1..n]
            k <- [1..n]
            True <- [j /= k]
            let revI = n - i + 1
            let revJ = n - j + 1
            let revK = n - k + 1
            [[-getNum n i j, -getNum n i k], 
                      [-getNum n revJ revI, -getNum n revK revI]]

genDiagBeatClauses :: Int -> [[Int]] -> [[Int]]
genDiagBeatClauses n = (++) $ do 
            i <- [1..n]
            j <- [1..n]
            k <- [1..n]
            True <- [i /= k]
            t <- [j-(i-k), j+(i-k)]
            True <- [1 <= t && t <= n]
            [[-getNum n i j, -getNum n k t]]

genSat n = (genAtLeastOneInRow n) . 
           (genRowsColsBeatClauses n) . 
           (genDiagBeatClauses n) $ 
           [] 

fromSolToAr :: Solution -> [Int]
fromSolToAr (Solution ar) = ar 

someFunc = do 
            let st = genSat 8 
            --putStrLn $ show (length st)
            --putStrLn $ show st 
            a <- solve st
            --putStrLn $ show a 
            let kek = splitOn (\x -> x `mod` 8 == 0) (fromSolToAr a)
            forM kek (\x -> do
                             putStr "|"
                             forM x (\y -> if y < 0 then putStr "." else putStr "Q")
                             putStrLn "|") 