import Data.List (delete, find, group, nub, sortBy)

type Nome = String

type Telefone = Int

data Pessoa = P Nome Telefone deriving (Show, Read)

instance Eq Pessoa where
  P n1 t1 == P n2 t2 = n1 == n2 && t1 == t2

type Edicao = Int

data Livro = L Nome Edicao deriving (Show, Read)

instance Eq Livro where
  L n1 e1 == L n2 e2 = n1 == n2 && e1 == e2

type Biblioteca = ([Pessoa], [Livro], [(Pessoa, Livro)])

pessoas0 :: [Pessoa]
pessoas0 = [P "Leandro" 12345678, P "Joabe" 45678910, P "Lucas" 96874343, P "Sidney" 93443234]

disponiveis0 :: [Livro]
disponiveis0 = [L "Java" 3, L "Concorrencia" 5]

emprestimos0 :: [(Pessoa, Livro)]
emprestimos0 = [(P "Leandro" 12345678, L "Java" 2), (P "Joabe" 45678910, L "CSP" 3), (P "Lucas" 96874343, L "UML" 4), (P "Lucas" 96874343, L "Haskell" 4), (P "Sidney" 93443234, L "CSP" 3)]

bancoDados0 :: Biblioteca
bancoDados0 = (pessoas0, disponiveis0, emprestimos0)

escreverBiblioteca :: Biblioteca -> IO ()
escreverBiblioteca biblioteca = do
  let conteudo = show biblioteca
  writeFile "sistema.txt" conteudo

-- removeQuotes :: String -> String
-- removeQuotes str = filter (/= '"') str

-- instance Read Pessoa where
--   readsPrec _ str =
--     let partes = words str
--         nome = removeQuotes ( partes!!1 )
--         telefone = read (partes!!2) :: Int
--     in [(P nome telefone, "")]

-- readPessoasFromFile :: FilePath -> IO [Pessoa]
-- readPessoasFromFile filePath = do
--     content <- readFile filePath
--     print content
--     let linesOfFile = lines content
--     return $ map read linesOfFile

