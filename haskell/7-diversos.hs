
-- define um nome para cada campo de cliente. Os nomes são funções que servem 
-- como chaves que não podem ser repetidas em outro tipo
data Cliente = Cliente {getIdC :: Int, getNome :: String, getTelefone :: String, getEndereco :: String, getCpf :: String} deriving (Read, Show)

-- criando um cliente. A ordem dos campos pode variar, não precisar ser a mesma da definição
clienteExemplo = Cliente {getIdC = 1, getNome = "João", getTelefone = "1234-5678", getEndereco = "Rua A, 123", getCpf = "111.222.333-44"}
clienteExemplo2 = Cliente {getNome = "Mario", getIdC = 2, getTelefone = "5678-1234", getEndereco = "Rua B, 456", getCpf = "444.555.666-77"}

-- outra forma de criar um Cliente. Nesta forma, a ordem importa. 
clienteExemplo3 = Cliente 1 "João" "1234-5678" "Rua A, 123" "111.222.333-44"

-- chave também permite acessar apenas um dos campos
nome = getNome clienteExemplo2

-- chave permite modificar apenas um dos campos
clienteExemplo4 = clienteExemplo2 {getNome = "Mario Pratice", getTelefone = "5678-1235"}


-- Exibindo o cliente
main :: IO ()
main = do 
  print ""
  