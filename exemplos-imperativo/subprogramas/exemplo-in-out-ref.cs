//https://onecompiler.com/csharp

using System;

class Program {
  static void ValorIn(int Param){
	  Param = 100;
  }
  static void ValorOut(out int Param){
	  Param = 200;
  }
  static void ValorRef(ref int Param){
	  Param = 300;
  }
  public static void Main (string[] args) {
    int valor = 5;
    ValorIn(valor);
	  Console.WriteLine("Valor no Main    = "+valor);//5
    ValorOut(out valor);
	  Console.WriteLine("Valor no Main    = "+valor);//200
    ValorRef(ref valor);
	  Console.WriteLine("Valor no Main    = "+valor);//300
  }
}
