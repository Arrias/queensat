
import Test.Tasty.HUnit
import Test.Tasty
import Picosat
import QueenSat
import GHC.IO (unsafePerformIO)

main :: IO ()
main = defaultMain tests 

tests :: TestTree 
tests = testGroup "Tests" [testQueenSat]

testQueenSat :: TestTree
testQueenSat = testGroup "testSat"
    [
        testCase "n = 2" $ unsafePerformIO (queenSat 2) @?= Unsatisfiable 
    ]
