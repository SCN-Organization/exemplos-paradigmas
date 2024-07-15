import Data.Char

answer :: Int
answer = 42

greater :: Bool
greater = (answer > 71)

yes :: Bool
yes = True

square :: Int -> Int
square x = x * x

allEqual :: Int -> Int -> Int -> Bool
allEqual n m p = (n == m) && (m == p)

maxi :: Int -> Int -> Int
maxi n m | n >= m    = n
         | otherwise = m

maior :: Int -> Int -> Int -> Int
maior a b c = maxi a (maxi b c)

mini :: Int -> Int -> Int
mini n m | n <= m    = n
         | otherwise = m
         
menor :: Int -> Int -> Int -> Int
menor a b c = mini a (mini b c)

vendas :: Int -> Int
vendas 0 = 20
vendas 1 = 50
vendas 2 = 30
vendas 3 = 50 
vendas n = n*2

acimaMedia :: Int -> Int
acimaMedia n = let 
                  media = div (totalVendas n) (n+1)
                  contaMedia -1 = 0
                  contaMedia n | (n > media) = 1 + contaMedia (n-1)
                               | otherwise = 0 + contaMedia (n-1)
               in 
                  contaMedia n

vendasIguais :: Int -> Int -> Int
vendasIguais v (-1)  = 0
vendasIguais v n  | (vendas n == v) = 1 + vendasIguais v (n-1)
                  | otherwise = vendasIguais v (n-1)

totalVendas :: Int -> Int
totalVendas n | n == 0    = vendas 0
              | otherwise = totalVendas (n-1) + vendas n

f :: Int -> Int
f n | n == 0    = 10
    | n == 1    = 20
    | otherwise = n


maxVendas :: Int -> Int
maxVendas n
  | n == 0    = vendas 0
  | otherwise = maxi (maxVendas (n-1)) (vendas n)


maxVendas2 :: Int -> Int
maxVendas2 0 = vendas 0
maxVendas2 n = maxi (maxVendas2 (n-1)) (vendas n)

totalVendas2 :: Int -> Int 
totalVendas2 0 = vendas 0
totalVendas2 n = totalVendas2 (n-1) + vendas n

myNot :: Bool -> Bool
myNot True  = False
myNot False = True

myOr :: Bool -> Bool -> Bool
myOr True  _ = True
myOr False x = x

myAnd :: Bool -> Bool -> Bool
myAnd False _ = False
myAnd True  x = x

sumSquares :: Int -> Int -> Int
sumSquares x y = sqX + sqY
  where sqX = x * x
        sqY = y * y

sumSquares2 x y = sq x + sq y
  where sq z = z * z

sumSquares3 x y = let 
                    sqX = x * x 
                    sqY = y * y
                 in sqX + sqY

eXor :: Bool -> Bool -> Bool
eXor x y = (x || y) && not ( x && y )

--outra forma
eXor2 :: Bool -> Bool -> Bool
eXor2 True x = not x
eXor2 False x = x

vendasNulas :: Int -> Bool
vendasNulas n = (vendas n == 0)

vendasNulas2 :: Int -> Bool
vendasNulas2 n | vendas n == 0 = True
               | otherwise = False

--import Data.Char

offset = fromEnum 'A' - fromEnum 'a'

maiuscula :: Char -> Char
maiuscula ch = toEnum (fromEnum ch + offset)

ehDigito :: Char -> Bool
ehDigito ch = ('0' <= ch) && (ch <= '9')

-- 
addEspacos :: Int -> String
addEspacos 0 = []
addEspacos n = " " ++ addEspacos (n-1)

-- paraDireita 3 "Haskell" retorna "   Haskell"
paraDireita :: Int -> String -> String
paraDireita n s = addEspacos n ++ s

intP :: (Int, Int)
intP = (33,43)

-- (True, 'x') :: (Bool, Char)
-- (34, 22, 'b') :: (Int, Int, Char)

addPair :: (Int,Int) -> Int
addPair (x,y) = x+y

shift :: ((Int,Int),Int) -> (Int,(Int,Int))
shift ((x,y),z) = (x,(y,z))

oneRoot :: Float -> Float -> Float -> Float
oneRoot a b c = -b/(2.0*a)

twoRoots :: Float -> Float -> Float ->  (Float, Float)
twoRoots a b c = (d-e, d+e)
  where
  d = -b/(2.0*a)
  e = sqrt(b^2-4.0*a*c)/(2.0*a)

roots :: Float -> Float -> Float -> String
roots a b c 
  | b^2 == 4.0*a*c = show (oneRoot a b c)
  | b^2 > 4.0*a*c = show f ++ "  " ++ show s
  | otherwise = "no roots"
    where (f,s) = twoRoots a b c

-- retorna a quantidade de semanas de 0 até n em que as vendas foram
-- superiores ao valor v fornecido
maiores :: Int -> Int -> Int
maiores 0 v | (vendas 0 > v) = 1
            | otherwise = 0
maiores n v | (vendas n > v) = 1 + maiores (n-1) v
            | otherwise = 0 + maiores (n-1) v

fib :: Int -> Int 
fib 1 = 1
fib 2 = 1
fib n = fib (n-1) + fib  (n-2)

type Name = String
type Age = Int
type Phone = Int
type Person = (Name, Age, Phone)

agenda = [("Fulano",18,976948594),("Beltrano", 22, 987894095)]

name :: Person -> Name 
name (n,a,p) = n

main = do
  putStrLn ""