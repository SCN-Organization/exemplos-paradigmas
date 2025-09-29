module Pessoa where

data Pessoa = Pessoa
  { nome :: String
  , idade :: Int
  } deriving (Show, Eq)

apresentar :: Pessoa -> String
apresentar p = "Olá, eu sou " ++ nome p ++ " e tenho " ++ show (idade p) ++ " anos."