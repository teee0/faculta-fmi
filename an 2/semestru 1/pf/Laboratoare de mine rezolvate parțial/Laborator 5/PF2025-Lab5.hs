sum_pat l= foldr (+) 0 (filter odd l)

all_true l = foldr (&&) True l

allVerifies :: (Int -> Bool) -> [Int] -> Bool
allVerifies f l= l == filter f l

anyVerifies :: (Int -> Bool) -> [Int] -> Bool
anyVerifies f l= [] /= filter f l

mapFoldr f l = foldr f []
filterFoldr = 

listToInt :: [Integer]-> Integer
listToInt = undefined

rmChar :: Char -> String -> String
rmChar = undefined

rmCharsRec :: String -> String -> String
rmCharsRec = undefined

rmCharsFold :: String -> String -> String
rmCharsFold = undefined
    
myUnzip :: [(a, b)] -> ([a], [b])
myUnzip = undefined
