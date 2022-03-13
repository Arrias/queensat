module Main where

import QueenSat
import Util 
import System.Environment (getArgs)
import Picosat

main :: IO ()
main = do 
    args <- getArgs 
    let n = read $ head args :: Int 
    a <- queenSat n
    let formatSolution a = case a of 
            (Solution ar) -> let v = splitOn (\x -> x `mod` n == 0) ar 
                             in foldr (\x y -> x ++ "\n" ++ y) "" $ fmap (\x -> 
                                 concat $ fmap (\y -> if y < 0 then "." else "Q") x) v    
            _ -> "There is no solution"
    putStrLn $ formatSolution a

