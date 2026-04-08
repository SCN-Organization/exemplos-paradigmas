main :: IO ()
main = putStr $ show (fib(3))

fat :: Int -> Int
fat 0 = 1
fat n = n * fat (n - 1)

fib :: Int -> Int
fib 0 = 0
fib 1 = 1
fib n = fib (n-1) + fib (n-2)

all3Equal :: Int -> Int -> Int -> Bool
all3Equal n m p = (n == m) && (m == p)


all4Equal :: Int -> Int -> Int -> Int -> Bool
all4Equal a b c d = (all3Equal a b c) && (d == a)

