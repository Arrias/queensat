
import Test.Tasty.HUnit
import Test.Tasty
import Picosat
import QueenSat
import Util
import GHC.IO (unsafePerformIO)

main :: IO ()
main = defaultMain tests 

tests :: TestTree 
tests = testGroup "Tests" [testQueenSat, testGetNum, testGetCell, testQueenBeat]

checkQueens n ar = do 
                    i <- ar
                    True <- [i > 0]
                    j <- ar
                    True <- [j > 0]
                    return $ i == j || (not $ queenBeat n i j)

checkify n sol = case sol of 
        (Solution ar) -> (length (filter (>0) ar) == n) && (and $ checkQueens n ar)
        _ -> False 

queensatTest n = checkify n $ unsafePerformIO (queenSat n)

testGetNum :: TestTree 
testGetNum = testGroup "testGetNum"
    [
        testCase "n = 2, i = 1, j = 1" $ getNum 2 1 1 @?= 1,
        testCase "n = 2, i = 1, j = 2" $ getNum 2 1 2 @?= 2,
        testCase "n = 2, i = 2, j = 1" $ getNum 2 2 1 @?= 3,
        testCase "n = 2, i = 2, j = 2" $ getNum 2 2 2 @?= 4
    ]

testGetCell :: TestTree 
testGetCell = testGroup "testGetCell"
    [
        testCase "1" $ (uncurry (getNum 15)) (getCell 15 13) @?= 13,
        testCase "2" $ (uncurry (getNum 100)) (getCell 100 228) @?= 228,
        testCase "3" $ (uncurry (getNum 19)) (getCell 19 19) @?= 19,
        testCase "4" $ (uncurry (getNum 8)) (getCell 8 64) @?= 64,
        testCase "5" $ (uncurry (getNum 117)) (getCell 117 239) @?= 239
    ]

testQueenBeat :: TestTree
testQueenBeat = testGroup "testQueenBeat"
    [
        testCase "row" $ (queenBeat 2 1 2) @?= True,
        testCase "col" $ (queenBeat 2 1 3) @?= True,
        testCase "diag" $ (queenBeat 2 1 4) @?= True,
        testCase "myself" $ (queenBeat 2 1 1) @?= True,
        testCase "nope1" $ (queenBeat 3 1 6) @?= False,
        testCase "nope2" $ (queenBeat 3 1 8) @?= False,
        testCase "nope3" $ (queenBeat 3 8 3) @?= False 
    ]

testQueenSat :: TestTree
testQueenSat = testGroup "testSat"
    [
        testCase "n = 2" $ queensatTest 2 @?= False, 
        testCase "n = 1" $ queensatTest 1 @?= True,
        testCase "n = 3" $ queensatTest 3 @?= False,
        testCase "n = 4" $ queensatTest 4 @?= True,
        testCase "n = 5" $ queensatTest 5 @?= True,
        testCase "n = 6" $ queensatTest 6 @?= True,
        testCase "n = 7" $ queensatTest 7 @?= True,
        testCase "n = 8" $ queensatTest 8 @?= True,
        testCase "n = 15" $ queensatTest 15 @?= True
    ]
