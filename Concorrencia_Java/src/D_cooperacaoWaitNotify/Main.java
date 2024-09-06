package D_cooperacaoWaitNotify;

public class Main {

    public static void main(String[] args) {
        
        BufferWaitNotify buffer = new BufferWaitNotify();
        
        ThreadInsere her1 = new ThreadInsere(buffer, '1');
        ThreadInsere her2 = new ThreadInsere(buffer, '2');
        ThreadInsere her3 = new ThreadInsere(buffer, '3');
        
        her1.start();
        her2.start();
        her3.start();
        
        String resultado;
        
        for (int i = 0; i < 10; i++) {//tenta esvaziar 10 vezes
            
            resultado = buffer.esvaziar();//espera até encher
            
            System.out.println("\n\nImpressao # " + (i + 1) + ":\n Buffer = "
                    + resultado + " -> Tamanho: " + resultado.length());
        }
        System.out.println("Main terminou.");

    }
}
