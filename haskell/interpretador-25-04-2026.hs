
import Data.Map (Map)
import qualified Data.Map as Map

-- Map é usado para armazenar os identificadores do programa
-- Funcões utilizadas: Map.empty, Map.insert e Map.lookup

-- ============================================================
-- Tipos da arvore sintatica 
-- ============================================================

data Type = TInt | TBool | TVoid
  deriving (Show, Eq)

data BinOp
  = Add | Sub | Mul | Div | Mod
  | Eq  | Neq | Lt  | Gt  | Le | Ge
  | And | Or
  deriving (Show, Eq)

data Expr
  = Lit    Int
  | BLit   Bool
  | Var    String
  | BinE   BinOp Expr Expr
  | Not    Expr
  | Call   String [Expr]
  deriving (Show, Eq)

data Stmt
  = Decl    Type String Expr    -- int x = 10; 
  | Assign  String Expr         -- x = 20 + 10
  | If      Expr Stmt Stmt
  | While   Expr Stmt
  | Block   [Stmt]
  | Return  Expr                -- return x + y
  | Print   Expr                -- printf (10)
  | Skip                        
  deriving (Show, Eq)

data FunDecl = FunDecl
  { funName   :: String
  , funParams :: [(Type, String)]-- [(TInt, "x"), (TInt,"y")]
  , funBody   :: Stmt
  } deriving (Show, Eq)

-- ============================================================
-- Valores e estado do programa (ambiente)
-- ============================================================

-- programas lidam com inteiros e booleanos
data Value
  = VInt  Int
  | VBool Bool
  | VVoid
  deriving (Show, Eq)

-- variaveis no escopo do programa
type Env    = Map String Value   -- variáveis no escopo

-- funções no escopo do programa
type FunEnv = Map String FunDecl -- funções declaradas


-- ============================================================
-- Avaliação de expressão (Expr)
-- ============================================================

-- Expressões não modificam o ambiente

evalExpr :: FunEnv -> Env -> Expr -> Value
evalExpr fenv env expr = case expr of

  Lit  n -> VInt n

  BLit b -> VBool b

  Var x  -> case Map.lookup x env of -- recupera a variável
               Nothing -> error ("Variavel nao declarada: " ++ x)
               Just v  -> v

  Not e  -> case evalExpr fenv env e of
               VBool b -> VBool (not b)
               _       -> error "Not usado em valor nao-booleano"

  BinE op l r ->
    let vl = evalExpr fenv env l
        vr = evalExpr fenv env r
    in  evalBinOp op vl vr

  Call fname args -> error "TODO: Call nao implementado"

-- Completar os casos que faltam

evalBinOp :: BinOp -> Value -> Value -> Value
evalBinOp Add (VInt  a) (VInt  b) = VInt  (a + b)
evalBinOp Sub (VInt  a) (VInt  b) = VInt  (a - b)
evalBinOp Eq  va        vb        = VBool (va == vb)
evalBinOp Lt  (VInt  a) (VInt  b) = VBool (a < b)
evalBinOp And (VBool a) (VBool b) = VBool (a && b)
evalBinOp Or  (VBool a) (VBool b) = VBool (a || b)
evalBinOp op  va         vb         =
  error ("Operacao invalida ou tipos incompativeis: " ++
          show op ++ " " ++ show va ++ " " ++ show vb)

{-

Implemente a função auxiliar a seguir para executar o corpo da função

evalCall :: FunEnv -> Env -> FunDecl -> [Expr] -> Value

-}

-- ============================================================
-- Execução de comando (Stmt)
-- ============================================================

-- resultado da execução de um Stmt

data StmtResult
  = Next     Env          -- novo valor para o ambiente
  | Returned Value Env    -- return 
  deriving (Show)


-- transforma um valor em uma string

showValue :: Value -> String
showValue (VInt  n) = show n
showValue (VBool b) = if b then "True" else "False"
showValue VVoid     = "()"

-- Stmt pode modificar o ambiente

execStmt :: FunEnv -> Env -> Stmt -> IO StmtResult
execStmt fenv env stmt = case stmt of

  Skip ->
    return (Next env)

  Return e -> do
    let v = evalExpr fenv env e
    return (Returned v env)

  Print e -> do
    let v = evalExpr fenv env e
    putStrLn (showValue v)
    return (Next env)

  Decl _ x e -> do
    let v    = evalExpr fenv env e
    let env' = Map.insert x v env
    return (Next env')

  Assign x e ->
    case Map.lookup x env of
      Nothing -> error ("Variavel " ++ x ++ " nao declarada")
      Just _  -> do
        let v    = evalExpr fenv env e
        let env' = Map.insert x v env
        return (Next env')

  If cond t f ->
    case evalExpr fenv env cond of
      VBool True  -> execStmt fenv env t
      VBool False -> execStmt fenv env f
      _           -> error "Condicao do If nao eh booleana"

  While cond body ->
    error "TODO: implementar While"

  Block stmts ->
    execBlock fenv env stmts

    
-- execucao de um bloco de comandos

execBlock :: FunEnv -> Env -> [Stmt] -> IO StmtResult
execBlock fenv env []     = return (Next env)
execBlock fenv env (s:ss) = do
  r <- execStmt fenv env s
  case r of
    Returned v env' -> return (Returned v env')
    Next       env' -> execBlock fenv env' ss


-- ============================================================
-- Funções auxiliares para testes (evita dependência com HUnit)
-- ============================================================

data TestResult = Passed | Failed String
  deriving (Show,Eq)

-- entrada do teste: Nome, programa e valor esperado 
-- saída do teste: Passed ou Failed

runTest :: String -> Stmt -> Value -> IO TestResult
runTest name prog expected = do
  result <- execStmt Map.empty Map.empty prog
  case result of
    Returned v _ ->
      if v == expected
        then do putStrLn ("[PASSOU] " ++ name)
                return Passed
        else do putStrLn ("[FALHOU] " ++ name ++
                          "\n  esperado: " ++ showValue expected ++
                          "\n  obtido:   " ++ showValue v)
                return (Failed name)
    Next _ -> do
      putStrLn ("[FALHOU] " ++ name ++ " — programa nao retornou valor")
      return (Failed name)

-- executa uma lista de testes

runAllTests :: [(String, Stmt, Value)] -> IO ()
runAllTests tests = do
  results <- mapM (\(n, p, e) -> runTest n p e) tests
  let total  = length results
      passed = length [ r | r <- results, r == Passed ]
  putStrLn ("---")
  putStrLn (show passed ++ "/" ++ show total ++ " testes passaram")

-- ============================================================
-- Programas de teste (podem ser apagados, use os seus próprios)
-- ============================================================

-- int x = 10; int y = 3; retorna x + y;
prog1 :: Stmt
prog1 = Block
  [ Decl TInt "x" (Lit 10)
  , Decl TInt "y" (Lit 3)
  , Return (BinE Add (Var "x") (Var "y"))
  ]

-- int n = 7;
-- se (n > 5) retorna True senao retorna False
prog2 :: Stmt
prog2 = Block
  [ Decl TInt "n" (Lit 7)
  , If (BinE Gt (Var "n") (Lit 5))
       (Return (BLit True))
       (Return (BLit False))
  ]

-- int i = 0; enquanto (i < 3) { i = i + 1; } retorna i;
prog3 :: Stmt
prog3 = Block
  [ Decl TInt "i" (Lit 0)
  , While (BinE Lt (Var "i") (Lit 3))
      (Assign "i" (BinE Add (Var "i") (Lit 1)))
  , Return (Var "i")
  ]

-- int x = 10; int y = 3; imprime(x + y);
prog4 :: Stmt
prog4 = Block
  [ Decl TInt "x" (Lit 10)
  , Decl TInt "y" (Lit 3)
  , Print (BinE Add (Var "x") (Var "y"))
  ]

-- int n = 7;
-- se (n == 5) imprime(True) senao imprime(False)
prog5 :: Stmt
prog5 = Block
  [ Decl TInt "n" (Lit 7)
  , If (BinE Eq (Var "n") (Lit 5))
       (Print (BLit True))
       (Print (BLit False))
  ]

-- função: int dobro(int x) { retorna x * 2; }
funDobro :: FunDecl
funDobro = FunDecl
  { funName   = "dobro"
  , funParams = [(TInt, "x")]
  , funBody   = Return (BinE Mul (Var "x") (Lit 2))
  }

-- função: int soma(int a, int b) { retorna a + b; }
funSoma :: FunDecl
funSoma = FunDecl
  { funName   = "soma"
  , funParams = [(TInt, "a"), (TInt, "b")]
  , funBody   = Return (BinE Add (Var "a") (Var "b"))
  }

fenvExemplo :: FunEnv
fenvExemplo = Map.fromList
  [ ("dobro", funDobro)
  , ("soma",  funSoma)
  ]

-- int x = 4; retorna soma(x, 3);
prog6 :: Stmt
prog6 = Block
  [ Decl TInt "x" (Lit 4)
  , Return (Call "soma"  [Var "x", Lit 3])
  ]

-- int x = 4; retorna dobro(x);
prog7 :: Stmt
prog7 = Block
  [ Decl TInt "x" (Lit 4)
  , Return (Call "dobro" [Var "x"])
  ]

suite :: [(String, Stmt, Value)]
suite =
  [("soma dois valores",        prog1, VInt 13)]
-- ++ [("condicional retorna false", prog2, VBool True)] 
-- ++  [("while conta ate 3",   prog3, VInt 3)] -- se descomentar dá erro pois não está implementado
-- ++  [("chamando soma",   prog6, VInt 7)] -- se descomentar dá erro pois não está implementado
-- ++  [("chamando dobro",   prog7, VInt 8)] -- se descomentar dá erro pois não está implementado


main :: IO ()
main = do 
  runAllTests suite -- roda os teste na suite
  putStrLn "=== Visualizar os prints de Prog4 ==="
  _ <- execStmt Map.empty Map.empty prog4
  putStrLn "=== Visualizar os prints de Prog5  ==="
  _ <- execStmt Map.empty Map.empty prog5
  return ()
