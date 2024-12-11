-- :t True
-- True :: Bool

data Estacao = Inverno 
        | Verao 
        | Outono 
        | Primavera deriving (Show)

-- :t Inverno
-- Inverno :: Estacao

data Temp = Frio | Quente deriving (Show)

-- :t Frio
-- Frio :: Temp


clima :: Estacao -> Temp
clima Inverno = Frio
clima _ = Quente

--------------------------------------

type Nome = String
type Idade = Int
data Pessoas = Pessoa Nome Idade deriving (Show)

-- :t Pessoa
-- Pessoa :: Nome -> Idade -> Pessoas

showPerson :: Pessoas -> String
--showPerson (Pessoa n a) = n ++ " -- " ++ show a
showPerson (Pessoa n i) = n ++ " -- " ++ show i

-- showPerson (Pessoa "Jose" 22)
-- showPerson (Pessoa "Maria" 22 )

isEqual :: Pessoas -> Pessoas -> Bool
isEqual (Pessoa n1  i1) (Pessoa n2 i2) | (n1 == n2 && i1 == i2) = True
                                       | otherwise = False
-- isEqual (Pessoa "Jose" 22) (Pessoa "Jose" 22)
-- isEqual (Pessoa "Jose" 22) (Pessoa "Jose" 56)
----------------------------------------

data Shape = Circle Float 
        | Rectangle Float Float

instance Eq Shape where
    (Circle r1) == (Circle r2) = r1 == r2
    (Rectangle l1 l2) == (Rectangle l3 l4) = l1 == l3 && l2 == l4
    _ == _ = False  -- Formas diferentes não são iguais

-- :t Circle 4.9
--Circle 4.9 :: Shape

-- :t Rectangle 4.2 2.0
--Rectangle 4.2 2.0 :: Shape

isRound :: Shape -> Bool
isRound ( Circle _) = True 
isRound (Rectangle _ _) = False

area :: Shape -> Float
area (Circle r) = pi * r * r
area (Rectangle a b) = a * b

data Expr = Lit Int 
        | Add Expr Expr 
        | Sub Expr Expr 
        | Mul Expr Expr

-- :t Lit 678
-- :t Add (Lit 10) (Lit 10)
-- :t Add (Lit 10) (Sub (Lit 20) (Lit 30))

eval :: Expr -> Int
eval (Lit n) = n
eval (Add e1 e2) = (eval e1) + (eval e2) 
eval (Sub e1 e2) = (eval e1) - (eval e2)
eval (Mul e1 e2) = (eval e1) * (eval e2)

-- eval (Add (Lit 10) (Lit 10))
-- eval (Sub (Add (Lit 10) (Lit 20)) (Lit 30))
-- eval (Mul (Lit 10) (Lit 20))

-- eval (Add (Lit 10) (Sub (Lit 20) (Lit 30)))
-- = (eval (Lit 10)) + (eval (Sub (Lit 20) (Lit 30))
-- = 10 + (eval (Lit 20)) - (eval (Lit 30))
-- = 10 + 20 - 30

data Pairs t = Pair t t

-- :t Pair 6 8
-- :t Pair True True
-- :t Pair [] [1,3]

data List t = Nil | Cons t (List t)

-- :t Nil -- ([])
-- :t (Cons 1 (Nil)) -- (1:[]) == [1]
-- :t (Cons 1 (Cons 2 Nil)) -- (1:(2:[])) = [1,2]
-- :t (Cons 1 (Cons 2 (Cons 3 Nil))) -- ([1,2,3])

-- :t (Cons [1] (Nil))
-- :t (Cons [1] (Cons [2] Nil))

toList :: List t -> [t]
toList Nil = []
toList (Cons h t) = h : toList t

-- toList (Cons 1 (Cons 2 Nil))
-- toList (Cons [1,3] (Cons [2,4] Nil))

data Tree t = NilT | Node t (Tree t) (Tree t)

-- :t NilT
-- :t Node 1 (NilT) (NilT)
-- :t Node 1 (Node 2 (NilT) (NilT)) (NilT)
-- :t Node 1 (Node 2 (NilT) (Node 3 (NilT) (NilT))) (NilT)


depth :: Tree t -> Int
depth NilT = 0
depth (Node _ l r) = 1 + max (depth l) (depth r)

-- depth (Node 1 (Node 2 (NilT) (Node 3 (NilT) (NilT))) (NilT))

maxT :: Tree Int -> Int
maxT NilT = minBound::Int
maxT (Node v l r) = max (v) ( max (maxT l) (maxT r) )

-- árvore para a imagem no link a seguir
-- https://cgi.cse.unsw.edu.au/~cs2521/20T2/tutes/week03/Pics/tree-orders.png
subtree1 = Node 3 (Node 1 (NilT) (NilT)) (Node 4 (NilT) (NilT))
subtree2 = Node 8 (Node 7 (NilT) (NilT)) (Node 9 (NilT) (NilT))
tree = Node 5 (subtree1) (subtree2)

inOrder :: Tree t -> [t]
inOrder (NilT) = []
inOrder (Node v l r) = inOrder(l) ++ [v] ++ inOrder(r)

-- inOrder (Node 1 (NilT) (NilT))
-- inOrder (NilT) ++ [1] ++ inOrder (NilT)
-- [] ++ [1] ++ []
-- [1]

-- inOrder (Node 4 (NilT) (NilT))
-- inOrder (NilT) ++ [4] ++ inOrder (NilT)
-- [] ++ [4] ++ []
-- [4]

-- inOrder Node 3 (Node 1 (NilT) (NilT)) (Node 4 (NilT) (NilT))
-- inOrder [1] ++ [3] ++ [4]
-- [1,3,4]

preOrder :: Tree t -> [t]
preOrder (NilT) = []
preOrder (Node v l r) = [v] ++ preOrder(l) ++ preOrder(r)

postOrder :: Tree t -> [t]
postOrder (NilT) = []
postOrder (Node v l r) = postOrder(l) ++ postOrder(r) ++ [v]

--

--
-- função que retorna o tipo Maybe t, onde t é o tipo do valor que talvez seja retornado
-- Maybe t possui d: Nothing se não houver resultado, ou, Maybe t
safeDivide :: Int -> Int -> Maybe Int
safeDivide _ 0 = Nothing
safeDivide x y = Just (x `div` y)

-- Uso do safeDivide
result1 :: Maybe Int
result1 = safeDivide 10 2  -- Resultado: Just 5

result2 :: Maybe Int
result2 = safeDivide 8 0  -- Resultado: Nothing

--

-- função que retorna "dois tipos" diferentes
-- tipo Either t1 t2 permite retornar até dois tipos como valor da resposta
-- os valores da resposta são do tipo Left t1 ou Right t2
divisibleBy :: Int -> Int -> Either String Bool
divisibleBy _ 0 = Left "Divisor nao pode ser zero!"
divisibleBy x y = Right (x `mod` y == 0)

-- Uso do divisibleBy
result3 :: Either String Bool
result3 = divisibleBy 10 2  -- Resultado: Right True

result4 :: Either String Bool
result4 = divisibleBy 8 0  -- Resultado: Left "Divisor não pode ser zero!"

main = do putStr ""
