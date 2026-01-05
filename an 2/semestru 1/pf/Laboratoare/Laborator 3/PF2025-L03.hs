import Data.Char
verifL :: [Int] -> Bool
verifL l = even $ length l

takefinal :: [Int] -> Int -> [Int]
takefinal l n= reverse $ take n $ reverse l

remove xs n = take n xs ++ drop (n + 1) xs

-- semiPareRec [0,2,1,7,8,56,17,18] == [0,1,4,28,9]
semiPareRec :: [Int] -> [Int]
semiPareRec [] = []
semiPareRec (h:t)
 | even h    = h `div` 2 : t'
 | otherwise = t'
 where t' = semiPareRec t

myreplicate :: Int -> Int -> [Int]
myreplicate 0 v = []
myreplicate n v = v : myreplicate (n-1) v

totalLen :: [String] -> Int
totalLen [] = 0
totalLen (șir : restu) = length șir + totalLen restu

nrv :: String -> Int
nrv [] = 0
nrv (c : restu) 
    | elem c "AEIOUaeiou" = 1 + nrv restu
    | otherwise = nrv restu

nrVocale :: [String] -> Int
nrVocale [] = 0
nrVocale (șir : restu)
    | șir == reverse șir = nrv șir + nrVocale restu
    | otherwise          = nrVocale restu 


-- nrVocale ["sos", "civic", "palton", "desen", "aerisirea"]
f extra [] = []
f extra (x : restu)
    | even x = x : extra : f extra restu
    | otherwise = x : f extra restu
-- f 3 [1,2,3,4,5,6] = [1,2,3,3,4,3,5,6,3]

semiPareComp :: [Int] -> [Int]
semiPareComp l = [ x `div` 2 | x <- l, even x ]

divizori :: Int -> [Int]
divizori n = [ x | x <- [1..n], mod n x == 0] 
-- divizori 4 == [1,2,4]

listadiv :: [Int] -> [[Int]]
listadiv l= [ divizori x | x <-l ]
-- listadiv [1,4,6,8] == [[1],[1,2,4],[1,2,3,6],[1,2,4,8]]

inInterval :: Int -> Int -> [Int] -> [Int]
inInterval i s l = [ x | x <- l, x >= i, x <= s]

inIntervalRec i s [] =  []
inIntervalRec i s (x : restu)
    | x<i || x > s = inIntervalRec i s restu
    | otherwise = x : inIntervalRec i s restu

-- inInterval 5 10 [1..15] == [5,6,7,8,9,10]
-- inInterval 5 10 [1,3,5,2,8,-1] == [5,8]

-- pozitive [0,1,-3,-2,8,-1,6] == 3

pozitive l = length [ x | x<-l, x>0]

pozitiveRec [] = 0
pozitiveRec (x : restu)
    | x > 0       = 1 + pozitiveRec restu
    | otherwise = pozitiveRec restu

-- pozitiiImpare [0,1,-3,-2,8,-1,6,1] == [1,2,5,7]

pia :: [Int] -> Int -> [Int]
pia [] i = []
pia (x : restu) i 
    | odd i = x : pia restu (i+1)
    | otherwise = pia restu (i+1)

pozitiiImpareRec l = pia l 0 

p1 [] i = []
p1 (x:restu) i
    | odd x     = i : p1 restu (i+1)
    | otherwise = p1 restu (i+1)

p l = p1 l 0


multDigitsComp l = product [ digitToInt c | c <- l, isDigit c]

multDigitsRec [] = 1
multDigitsRec (c : restu)
    | isDigit c = (digitToInt c) * multDigitsRec restu
    | otherwise = multDigitsRec restu

-- multDigits "The time is 4:25" == 40
-- multDigits "No digits here!" == 1
-- 5, 8 , 7 (impartial), 8