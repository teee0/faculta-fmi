import Data.List

myInt = 31415926535897932384626433832795028841971693993751058209749445923

double :: Integer -> Integer
double x = x+x

--maxim :: Integer -> Integer -> Integer
maxim x y = if (x > y)
               then x
               else y

max3 x y z = let
                u = maxim x y
             in 
                maxim u z
maxim3 x y z =  let 
                    u = if (x > y) 
                            then x
                            else y
                in 
                    if u > z
                        then u
                        else z

maxim4 a b c d = let 
                    temp1 = maxim a b
                    temp2 = maxim c d
                 in
                    maxim temp1 temp2

test_max a b c d = let 
                       temp = maxim4 a b c d 
                   in
                       temp >= a && temp >= b 
                       && temp >= c && temp >= d

suma_pat a b = a**2 + b**2

paritate :: Integer -> String
paritate a 
    | even a = "par"
    | otherwise = "impar"

fact 0 = 1
fact x = x * fact (x-1)

f1d a b = a > b*2

max_of_list (x : []) = x
max_of_list (x : restu) = max x (max_of_list restu) 


poly :: Double -> Double -> Double -> Double -> Double 
poly a b c x = a * (x**2) + b*x + c

eeny :: Integer -> String
eeny a 
    | even a = "eeny"
    | otherwise = "meeny"


fizzbuzz :: Integer -> String
fizzbuzz x 
    | (mod x 15 == 0) = "FizzBuz"
    | (mod x 3 == 0)  = "Fizz"
    | (mod x 5 == 0)  = "Buz"
    | otherwise  = ""


fibonacciCazuri :: Integer -> Integer
fibonacciCazuri n
    | n < 2     = n
    | otherwise = fibonacciCazuri (n - 1) + fibonacciCazuri (n - 2)
    
fibonacciEcuational :: Integer -> Integer
fibonacciEcuational 0 = 0
fibonacciEcuational 1 = 1
fibonacciEcuational n =
    fibonacciEcuational (n - 1) + fibonacciEcuational (n - 2)
    
tribonacci :: Integer -> Integer
tribonacci n 
        | n <= 2 = 1
        | n == 3 = 2
        | otherwise = tribonacci (n-1) + tribonacci (n-2) + tribonacci (n-3) 
    
tribonacci_ec :: Integer -> Integer
tribonacci_ec 1 = 1
tribonacci_ec 2 = 1
tribonacci_ec 3 = 2
tribonacci_ec n = tribonacci (n-1) + tribonacci (n-2) + tribonacci (n-3) 

binomial :: Integer -> Integer -> Integer
binomial 0 k = 0
binomial n 0 = 1
binomial n k = binomial (n-1) k + binomial (n-1) (k-1) 
