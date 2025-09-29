import Data.Char (isDigit)

-- cabeca:cauda
-- head:tail
-- umElemento:umaLista

-- na biblioteca existe a função sum
sumList :: [Int] -> Int
sumList [] = 0
sumList (a:as) = a + sumList as

copy :: [t] -> [t]
copy [] = []
copy (a:as) = a : copy as

double :: [Int] -> [Int]
double [] = []
double (a:as) = a*2 : double as

{-
double [1,2]
=
1*2 : double [2]
=
1*2 : 2*2 : double []
=
1*2 : 2*2 : []
=
[2,4]
-}

-- na biblioteca existe a função elem
member :: Int -> [Int] -> Bool
member x [] = False
member x (a:as) | (x == a) = True
                | otherwise = member x as

-- na biblioteca existe a função maximum
maiorLista :: [ Int ] -> Int 
maiorLista [] = minBound :: Int
--maiorLista [x] = x
maiorLista (x:xs) | (x > maiorLista xs) = x
                  | otherwise = maiorLista xs


{-
maiorLista [1,3,2]
=
| 1 > maiorLista [3,2] = 1
| otherwise = maiorLista [3,2]

maiorLista [3,2]
=
| 3 > maiorLista [2] = 3
| otherwise = maiorLista [2]

maiorLista [2]
=
2

maiorLista [3,2]
=
| 3 > 2 = 3
| otherwise = 2
=
3

maiorLista [1,3,2]
=
| 1 > 3 = 1
| otherwise = 3
=
3

-}

{-
replicateChar :: Int -> Char -> String
replicateChar 0 ch = []
replicateChar n ch = ch : (replicateChar (n−1) ch)
-}

ehDigito :: Char -> Bool
ehDigito ch = ('0' <= ch) && (ch <= '9')
 
digits :: [Char] -> [Char]
digits [] = []
digits (a:as) | (ehDigito a) = a : digits as
              | otherwise = digits as  

removeFirst :: [t] -> [t]
removeFirst [] = []
removeFirst (a:as) = as

-- remove todas as ocorrências do elemento
remove :: Int -> [Int] -> [Int]
remove x [] = []
remove x (a:as) | x == a = remove x as
                | otherwise = a : remove x as

meuLast :: [Int] -> Int
meuLast [a] = a
meuLast (a:as) = meuLast as

sumPairs2 :: [(Int,Int)] -> [Int]
sumPairs2 [] = []
sumPairs2 ((x,y):as) = (x+y):sumPairs2 as

-- (x:xs) ++ y = x : (xs ++ y)

-- [1..4]
-- [1,2,3,4]
-- [1,2] ++ [3,4] 
-- (1 : [2]) ++ [3,4]
-- 1 : [2] ++ [3,4]

rev [] = []
rev (a:as) = rev as ++ [a]

{-
rev [1,2,3] =
rev [2,3] ++ [1] =
rev [3] ++ [2] ++ [1] =
rev [] ++ [3] ++ [2] ++ [1] =
[] ++ [3] ++ [2] ++ [1] =
[3,2,1]
-}

-------------------------------------------------------------------------------

doubleList xs = [2*a | a <- xs] 

doubleIfEven xs = [2*a | a <- xs, even a]

sumPairs :: [(Int,Int)] -> [Int] 
sumPairs lp = [a+b | (a,b) <- lp]

digits2 :: String -> String
digits2 st = [ch | ch <- st, isDigit ch]

type Lista = [(String,Int)]
 
exemplo :: Lista
exemplo = [("a",2),("b",4),("c",5)]

-------------------------------------------------------------------------------
-- admite que o primeiro argumento é sempre >= 0
meuTake :: Int -> [t] -> [t] 
meuTake 0 s = []
meuTake _ [] = []
meuTake n (a:as) = a : meuTake (n-1) as

-- admite que o primeiro argumento é sempre >= 0
meuDrop :: Int -> [t] -> [t] 
meuDrop 0 s = s
meuDrop _ [] = []
meuDrop n (a:as) = meuDrop (n-1) as

-------------------------------------------------------------------------------

-- Faça uma função que diz se existe um par (s,i)

existe :: String -> Int -> Lista -> Bool
existe s i [] = False
existe s i ((s2,i2):calda) | (s == s2) && (i == i2) = True
                           | otherwise = existe s i calda

-- existe "a" 2 exemplo
-- True

-- existe "c" 5 exemplo
-- True

-- existe "c" 4 exemplo
-- False


-- muda o segundo elemento de uma tupla (s,i1) para i2
substitui :: String -> Int -> Int -> Lista -> Lista
substitui _ _ _ [] = []
substitui s i1 i2 ((s2,i3):calda) | (s == s2) && (i1 == i3) = ((s,i2):calda)                
                                  | otherwise = (s2,i3):(substitui s i1 i2 calda)

-- substitui "a" 2 6 [... ("a",2) ...]
-- =
-- [... ("a",6) ...]

{-
substitui s i1 i2 lista = if existe s i1 lista 
                          then (s,i2) : (remove s i1 lista)
                          else lista
-}


-- retorna uma lista apenas com pares na forma (s,_)
-- retorna elementos onde o primeiro é s

{-
segundoEhPar :: (String,Int) -> Bool
segundoEhPar (s,i) = even i

primeiro (a,b) = a
primeiroQuandoPar l = map primeiro (filter segundoEhPar)
-}

-------------------------------------------------------------------------------

main = do
  putStrLn ""
