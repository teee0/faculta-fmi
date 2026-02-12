import Data.List (nub)
import Data.Maybe (fromJust)

import Data.Char (isAlpha)

type Nume = String
data Prop
  = Var Nume
  | F
  | T
  | Not Prop
  | Prop :|: Prop
  | Prop :&: Prop
  deriving (Eq, Read)
infixr 2 :|:
infixr 3 :&:

pa :: Prop
pa = (Var "P" :|: Var "Q") :&: (Var "P" :&: Var "Q")

pb :: Prop
pb = (Var "P" :|: Var "Q") :&: (Not (Var "P") :&: Not (Var "Q"))

pc :: Prop
pc = (Var "P" :&: (Var "Q":|: Var "R")) :&: ((Not (Var "P") :|: Not (Var "Q")) :&: (Not (Var "P") :|: Not (Var "R")) )

instance Show Prop where
  show (Var s) = s
  show T = "T"
  show F = "F"
  show (Not p) = "(~" ++ show p ++ ")"
  show (p :|: q) = "("++(show p) ++ "|" ++ (show q)++")" 
  show (p :&: q) = "("++(show p) ++ "&" ++ (show q)++")"
 
test_ShowProp :: Bool
test_ShowProp =
    show (Not (Var "P") :&: Var "Q") == "((~P)&Q)"

type Env = [(Nume, Bool)]

impureLookup :: Eq a => a -> [(a,b)] -> b
impureLookup a = fromJust . lookup a

eval :: Prop -> Env -> Bool
eval (Var s) e = impureLookup s e
eval T e = True
eval F e = False
eval (Not p) e = not (eval p e)
eval (p :|: q) e = (eval p e) || (eval q e) 
eval (p :&: q) e = (eval p e) && (eval q e)
 
test_eval = eval  (Var "P" :|: Var "Q") [("P", True), ("Q", False)] == True

variabile :: Prop -> [Nume]
variabile x = nub [ [x] | x <- filter isAlpha (show x)]  

test_variabile =
  variabile (Not (Var "P") :&: Var "Q") == ["P", "Q"]

envs :: [Nume] -> [Env]
envs [] = [[]]
envs (n : restu ) = map ((n,False): ) (envs restu) ++ map ((n,True): ) (envs restu)

test_envs = 
    envs ["P", "Q"]
        ==
    [ [ ("P",False)
      , ("Q",False)
      ]
    , [ ("P",False)
      , ("Q",True)
      ]
    , [ ("P",True)
      , ("Q",False)
      ]
    , [ ("P",True)
      , ("Q",True)
      ]
    ]


satisfiabila :: Prop -> Bool
satisfiabila p = foldr (||) False ((map (eval p) (envs (variabile p))))  
 
test_satisfiabila1 = satisfiabila (Not (Var "P") :&: Var "Q") == True
test_satisfiabila2 = satisfiabila (Not (Var "P") :&: Var "P") == False

valida :: Prop -> Bool
valida p = not (satisfiabila (Not p))

test_valida1 = valida (Not (Var "P") :&: Var "Q") == False
test_valida2 = valida (Not (Var "P") :|: Var "P") == True


echivalenta :: Prop -> Prop -> Bool
echivalenta = undefined
 
test_echivalenta1 =
  True
  ==
  (Var "P" :&: Var "Q") `echivalenta` (Not (Not (Var "P") :|: Not (Var "Q")))
test_echivalenta2 =
  False
  ==
  (Var "P") `echivalenta` (Var "Q")
test_echivalenta3 =
  True
  ==
  (Var "R" :|: Not (Var "R")) `echivalenta` (Var "Q" :|: Not (Var "Q"))

