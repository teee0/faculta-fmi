data Tree = Empty  -- arbore vid
   | Node Int Tree Tree Tree -- arbore cu valoare de tip Int in radacina si 3 fii
      
extree :: Tree
extree = Node 4 (Node 5 Empty Empty Empty) 
                (Node 3 Empty Empty (Node 1 Empty Empty Empty)) Empty

class ArbInfo t where
  level :: t -> Int -- intoarce inaltimea arborelui; pt un arbore vid
                      -- se considera ca are inaltimea 0
  sumval :: t -> Int -- intoarce suma valorilor din arbore
  nrFrunze :: t -> Int -- intoarce nr de frunze al arborelui
-- level extree
-- 3
--sumval extree
-- 13
-- nrFrunze extree
-- 2

instance ArbInfo Tree where
  level (Node i t1 t2 t3) = max (1+level t1) (max(1+level t2) (1+level t3))
  level Empty = 0

  sumval (Node i t1 t2 t3) = i + sumval t1 + sumval t2 + sumval t3 
  sumval Empty = 0

  nrFrunze (Node i Empty Empty Empty) = 1
  nrFrunze (Node i t1 t2 t3) = nrFrunze t1 + nrFrunze t2 + nrFrunze t3 
  nrFrunze Empty = 0


class Scalar a where
  zero :: a
  one :: a
  adds :: a -> a -> a
  mult :: a -> a -> a
  negates :: a -> a
  recips :: a -> a

instance Scalar Double where
  zero = 0
  one = 1
  adds a b = a + b
  mult a b = a * b
  negates a = (-a)
  recips a = undefined

class (Scalar a) => Vector v a where
  zerov :: v a
  onev :: v a
  addv :: v a -> v a -> v a -- adunare vector
  smult :: a -> v a -> v a  -- inmultire cu scalare
  negatev :: v a -> v a -- negare vector

instance Scalar a => Vector v a where
  zerov = Vector 0 0