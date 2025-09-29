import Data.Char (isDigit, isAlpha)

inverteSinal :: Int -> Int
inverteSinal x = x * (-1)

rev [] = []
rev (a : as) = rev as ++ [a]

duplica :: Int -> Int
duplica x = x+x

vendas :: Int -> Int
vendas 0 = 100
vendas 1 = 50
vendas 2 = 0
vendas n = n * 2

maxi :: Int -> Int -> Int
maxi n m
  | n >= m = n
  | otherwise = m

sqr :: Int -> Int
sqr x = x * x

------------------------------
applyTwice :: (a -> a) -> a -> a
applyTwice f x = f (f x)

-- erro de tipo se 
--applyTwice sqr ([1]) 
--applyTwice :: (Int -> Int) -> [Int] -> Int

total :: (Int -> Int) -> Int -> Int
total f 0 = f 0
total f n =  f n + total f (n -1)

totalVendas n = total vendas n

sumSquares :: Int -> Int
sumSquares n = total sqr n

isCrescent :: (Int -> Int) -> Int -> Bool
isCrescent f 0 = True
isCrescent f n = f (n) > f (n-1) && isCrescent f (n -1)

maxFun :: (Int -> Int) -> Int -> Int
maxFun f 0 = f 0
maxFun f n = maxi (maxFun f (n -1)) (f n)

zeroInRange :: (Int -> Int) -> Int -> Bool
zeroInRange f 0 = (f 0 == 0)
zeroInRange f n = zeroInRange f (n -1) || (f n == 0)

times2 :: Int -> Int 
times2 n = 2 * n

{-
map :: (t -> u) -> [t] -> [u] 
map f [] = []
map f (a:as) = f a : map f as

snd :: (t,u) -> u
snd (a,b) = b
-}

double :: [Int] -> [Int]
double [] = []
double (a:ax) = (2*a) : double ax 

-- no slide esta função se chama double
doubleList xs = map times2 xs 

sqrList xs = map sqr xs

-- usando notação lambda
doubleList2 xs = map (\x -> 2 * x) xs
sqrList2 xs = map (\x -> x * x) xs

--snds :: [(t,u)] -> [u] 
snds xs = map snd xs

-- retornando apenas livros
-- map snd [("fulano","livro1"),("cicrano", "livro2")] 

-- retornando apenas pessoas
-- map fst [("fulano","livro1"),("cicrano", "livro2")] 

{-
-- definição de map como compreensão de listas
map f l = [f a | a <− l]
-}

-- retorna a soma dos inteiros em uma lista
sumList :: [Int] -> Int 
sumList [] = 0
sumList (a:as) = a + sumList as

-- parametros:
-- 1o: função que recebe dois valores do tipo t e retorna valor do tipo t
-- 2o: lista do tipo t
-- 3o: elemento do tipo t 
fold :: (t -> t -> t) -> [t] -> t 
fold f [a] = a
fold f (a:as) = f a (fold f as)

sumList2 l = fold (+) l

sumList3 l = fold (\a b -> a + b) l

soma a b = a + b
sumList4 l = fold soma l

{-
-- Funções já definidas no Prelude

-- retorna a conjunção dos valores na lista
and :: [Bool] −> Bool
and xs = fold (&&) xs

-- concatena as listas
concat :: [[t]] −> [t]
concat xs = fold (++) xs

-- retorna o elemento máximo da lista
maximum :: [Int] −> Int 
maximum xs = fold maxi xs

filter :: (t -> Bool) -> [t] -> [t] 
filter p [] = []
filter p (a:as) | p a = a : filter p as
                | otherwise = filter p as
-}
digits :: String -> String
digits st = filter isDigit st

evens xs = filter isEven xs 
  where isEven n = (n `mod` 2 == 0)

{-

letters :: String -> String
letters st = filter isLetter st

-}

naosei l = foldr (++) [] (map sing l )
  where sing a = [a]

f :: Int -> Int
f n = foldr1 (+) (map (\x -> x * x) (filter odd [0..n]))

f2 :: [String] -> (Int, Int)
f2 l = (a,b)  where 
  notDigit c = not (isDigit c)
  onlyLetters = map (\s -> filter notDigit s) l
  sizes = map length (onlyLetters)  
  a = foldr1 min sizes 
  b = foldr1 max sizes 

main = do
  putStrLn ""
