import System.CPUTime

fib :: Int -> Int
fib 0 = 0  -- Base case: fib(0) = 0
fib 1 = 1  -- Base case: fib(1) = 1
fib n = fib (n - 1) + fib (n - 2)  -- Recursive case: fib(n) = fib(n - 1) + fib(n - 2)

-- gera um número pseudo aleatório de 0 até n-1
-- código depende da velocidade da CPU, funciona no replit.com (Nov-23)
-- ajustes são necessários nas linhas 14 e 17
-- para ajustar os valores, observar o valor de reduction
pseudoRandom :: Int -> IO (Int)
pseudoRandom n = do 
  t1 <- System.CPUTime.getCPUTime
  let result = fib 5 -- Esta linha consome algum tempo da CPU
  t2 <- System.CPUTime.getCPUTime
  let dif = fromInteger(t2) - fromInteger(t1)
  let reduction = div dif 1000
  print reduction
  return ( mod reduction n )


main :: IO ()
main = do
  i <- pseudoRandom 20
  print i