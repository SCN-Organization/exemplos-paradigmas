
writefoo :: IO ()
writefoo = putStrLn "foo"

--main = do writefoo

--------------------------------------------------

getNput :: IO ()
getNput = do
  line <- getLine
  putStr line

--main = do getNput

--------------------------------------------------

{-

main = do putStr "Digite seu nome:"
          st <- getLine
          putStr ("O inverso de " ++ st ++ " ´e ")
          putStr (reverse st)
          putStr "\n"

-}

--------------------------------------------------

put4times :: String -> IO ()
put4times str = do
  putStr str
  putStr str
  putStr str
  putStr str

--main = put4times "A"

--------------------------------------------------
--{-
putNtimes :: Int -> String -> IO ()
putNtimes n str =
  if n <= 1
    then putStr str
  else do
    putStr str
    putNtimes (n-1) str
---}
{-
putNtimes :: Int -> String -> IO ()
putNtimes 1 str = putStr str
putNtimes n str = do 
                    putStr str
                    putNtimes (n-1) str

-}

--main = putNtimes 14 "A"

--------------------------------------------------

putList :: [Int] -> IO ()
putList [] = putStr ""
putList (a : as) = do putStr (show (a) ++ " ")
                      putList (as)

--main = do putList [1,2,3]

--------------------------------------------------

listaStrings :: [String] -> IO()
listaStrings [] = putStrLn "---FIM---"
listaStrings (h:t) = do 
                          putStrLn h  
                          listaStrings t

adicionar :: [String] -> String -> [String]
adicionar existente novo = existente ++ [novo]

remover :: [String] -> String -> [String]
remover [] _ = []
remover (a:as) s | a == s = as
                 | otherwise = a : (remover as s)

escreveArquivo :: FilePath -> [String] -> IO ()
escreveArquivo file strs = writeFile file (show strs)

leArquivo :: FilePath -> IO [String]
leArquivo file = do 
    conteudo <- readFile file
    return (read conteudo::[String])

--{-
menu :: [String] -> IO ()
menu strings = do
  putStrLn "Selecione uma opção:"
  putStrLn "1 - Adicionar string"
  putStrLn "2 - Listar strings"
  putStrLn "3 - Remove uma string"
  putStrLn "0 - Sair"

  opcao <- getLine

  case opcao of
    "1" -> do
      putStrLn "Digite uma string para adicionar"
      line <- getLine
      menu (adicionar strings line)
    "2" -> do
      putStrLn "Strings atuais:"
      listaStrings strings
      menu strings
    "3" -> do
      putStrLn "Digite a string que deseja remover"
      line <- getLine
      menu (remover strings line)

    "0" -> do
      putStrLn "Saindo..."
      escreveArquivo nomeArquivo strings
    
    _ -> do
      putStrLn "Opção inválida. Tente novamente."
      menu strings
---}

strs0 = ["abc","def"]

--main = menu strs0

nomeArquivo = "a.txt"

{-
main = do
    conteudo <- leArquivo nomeArquivo
    menu conteudo
-}
--------------------------------------------------

manipulaArquivo = do
  putStrLn "Escrevendo no arquivo"
  writeFile "a.txt" "Ola\nMundo"
  appendFile "a.txt" "\nde\nHaskell"
  putStrLn "Lendo o arquivo"
  x <- readFile "a.txt"
  putStrLn x

--main = manipulaArquivo

--------------------------------------------------

type Par = (Int, Int)

-- Escreve uma lista de pares em um arquivo
writePairsToFile :: FilePath -> [Par] -> IO ()
writePairsToFile filename pairs = writeFile filename (show pairs)

-- Lê uma lista de pares de um arquivo
readPairsFromFile :: FilePath -> IO [Par]
readPairsFromFile filename = do 
  contents <- readFile filename
  return (read contents::[Par])

-- read "[(1,2),(3,4)]"::[(Int,Int)]

escreveLePares = do
  -- Exemplo de uso:
  let pairs = [(1, 2), (3, 4), (5, 6)]
  writePairsToFile "pairs.txt" pairs
  pairsFromFile <- readPairsFromFile "pairs.txt"
  print pairsFromFile

--main = escreveLePares
