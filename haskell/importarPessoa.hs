module Main where

import Pessoa 

main :: IO ()
main = do
  let p1 = Pessoa { nome = "João", idade = 30 }
  putStrLn (apresentar p1)
