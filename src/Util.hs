module Util where 

getNum :: Int -> Int -> Int -> Int 
getNum n a b = n * (a - 1) + b

getCell :: Int -> Int -> (Int, Int)
getCell n num = ((num - 1) `div` n + 1, (num - 1) `mod` n + 1)

queenBeat :: Int -> Int -> Int -> Bool
queenBeat n pos1 pos2 = let (x, y) = getCell n pos1 
                            (i, j) = getCell n pos2 
                        in (x == i) || (y == j) || (abs (x - i) == abs(y - j))

consIf :: Bool -> a -> [a] -> [a]
consIf p x ar = case p of 
                True -> x : ar 
                _ -> ar

splitOn :: (a -> Bool) -> [a] -> [[a]]
splitOn pr ar = case ar of 
                [] -> []
                (x:xs) -> let p = splitOn pr xs in 
                    if pr x then 
                        [[x]] ++ (splitOn pr xs)
                    else 
                        case p of 
                            [] -> [[x]]
                            (y:ys) -> (([x] ++ y) : ys)