import Data.Char

type Stack = [Int]
type Machine = (String, Stack)

solve :: String -> Int
solve exprs = pick $ readExprs $ initMachine exprs where
    pick (_, [num]) = num
    initMachine = flip (,) []

isOperand :: Char -> Bool
isOperand '+' = True
isOperand '-' = True
isOperand '*' = True
isOperand _ = False

toOperand :: Num a => Char -> (a -> a -> a)
toOperand '+' = (+)
toOperand '-' = (-)
toOperand '*' = (*)

idElemFor :: Char -> Int
idElemFor '+' = 0
idElemFor '-' = 0
idElemFor '*' = 1

readOne :: Machine -> Machine
readOne (c:cs, stack)
    | isOperand c = (cs, [foldr (toOperand c) (idElemFor c) stack])
    | isDigit c = (cs, (read [c] :: Int):stack)
    | isSpace c = (cs, stack)

readExprs :: Machine -> Machine
readExprs ([], stack) = ([], stack)
readExprs machine = readExprs $ readOne machine
