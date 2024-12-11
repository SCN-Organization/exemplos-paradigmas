-------------------------------------------------------------------------------


type Pessoa = String
type Livro = String
type BancoDados = [(Pessoa,Livro)]  

baseExemplo :: BancoDados
baseExemplo = [("Sergio","O Senhor dos Aneis"), ("Andre", "Duna"), ("Fernando", "Jonathan Strange & Mr. Norrell"), ( "Fernando" , "Duna" ) ]


-- retorna as pessoas que pegaram emprestado um determinado livro
--{-
emprestimos :: BancoDados -> Livro -> [Pessoa]
emprestimos [] l = [] 
emprestimos ((p,l2):as) l1 | (l2 == l1) = p : emprestimos as l1
                           | otherwise = emprestimos as l1

emprestimos2 b l1 = [p | (p,l2) <- b, l1 == l2]

emprestimos3 [] l = [] 
emprestimos3 ((p,l2):as) l1 = if (l2 == l1) then p : emprestimos as l1
                                else emprestimos as l1

---}

-- retorna todos os livros que estão na base
livros :: BancoDados -> Pessoa -> [Livro]
livros bd pessoa = [l | (p, l) <- bd, p == pessoa]

emprestado :: BancoDados -> Livro -> Bool
emprestado b l = emprestimos b l /= []

qtdEmprestimos :: BancoDados -> Pessoa -> Int
qtdEmprestimos b p = length (livros b p)

emprestar :: BancoDados -> Pessoa -> Livro -> BancoDados
emprestar b p l = (p,l):b
--emprestar b p l = b ++ [(p,l)]

devolver :: BancoDados -> Pessoa -> Livro -> BancoDados
devolver b p l = [ (p2,l2) | (p2,l2)<-b, p2/=p || l2 /=l ]
