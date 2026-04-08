
-- Demonstração de testes baseados em propriedades com QuickCheck

import Test.QuickCheck
import Data.List


------------------------------------------------------------
-- Propriedade aritmética básica
------------------------------------------------------------

-- Propriedade: Somar 1 a qualquer inteiro o torna maior
prop_addOneIncreases :: Int -> Bool
prop_addOneIncreases x = x + 1 > x


------------------------------------------------------------
-- Comutatividade
------------------------------------------------------------

-- Propriedade: A adição é comutativa
prop_addCommutative :: Int -> Int -> Bool
prop_addCommutative x y = x + y == y + x

-- Propriedade: A multiplicação é comutativa
prop_mulCommutative :: Int -> Int -> Bool
prop_mulCommutative x y = x * y == y * x


------------------------------------------------------------
-- Associatividade
------------------------------------------------------------

-- Propriedade: A adição é associativa
prop_addAssociative :: Int -> Int -> Int -> Bool
prop_addAssociative x y z = (x + y) + z == x + (y + z)


------------------------------------------------------------
-- Inversão de listas
------------------------------------------------------------

-- Propriedade: Inverter uma lista duas vezes retorna a lista original
prop_reverseTwice :: [Int] -> Bool
prop_reverseTwice xs = reverse (reverse xs) == xs

-- Propriedade: O tamanho da lista não muda ao inverter
prop_reverseLength :: [Int] -> Bool
prop_reverseLength xs = length xs == length (reverse xs)


------------------------------------------------------------
-- Propriedades de ordenação
------------------------------------------------------------

-- Propriedade: Ordenar duas vezes é igual a ordenar uma vez
prop_sortIdempotent :: [Int] -> Bool
prop_sortIdempotent xs = sort (sort xs) == sort xs

-- Propriedade: Lista ordenada é não decrescente
prop_sortOrdered :: [Int] -> Bool
prop_sortOrdered xs = and $ zipWith (<=) ys (drop 1 ys)
  where ys = sort xs


------------------------------------------------------------
-- Exemplo de função personalizada
------------------------------------------------------------

-- Uma função simples para testar: dobrar um número
double :: Int -> Int
double x = 2 * x

-- Propriedade: dobrar é o mesmo que somar o número a si mesmo
prop_double :: Int -> Bool
prop_double x = double x == x + x

-- Verifica se o elemento aparece exatamente uma vez na lista
exactOne :: Int -> [Int] -> Bool
exactOne x xs = length (filter (== x) xs) == 1

-- Propriedade: se x aparece exatamente uma vez,
-- então após deletar x, ele não estará mais na lista
prop_delete :: Int -> [Int] -> Property
prop_delete x xs = exactOne x xs ==> not (elem x (delete x xs))


------------------------------------------------------------
-- Executar todos os testes
------------------------------------------------------------

-- main é opcional no GHCi, mas útil se você quiser executar `runTests` de uma vez.
runTests :: IO ()
runTests = do
  putStrLn "\n=== Exemplos de QuickCheck ==="
  quickCheck prop_addOneIncreases
  quickCheck prop_addCommutative
  quickCheck prop_mulCommutative
  quickCheck prop_addAssociative
  quickCheck prop_reverseTwice
  quickCheck prop_reverseLength
  quickCheck prop_sortIdempotent
  quickCheck prop_sortOrdered
  quickCheck prop_double
  quickCheck prop_delete