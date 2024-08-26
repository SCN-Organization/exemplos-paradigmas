package cooperacaoSemaforo;

public class Main {

    public static void main(String[] args) {
        
        BufferSemaforo buf = new BufferSemaforo();

        ThreadInserir her1 = new ThreadInserir(buf, '1');
        ThreadInserir her2 = new ThreadInserir(buf, '2');
        ThreadInserir her3 = new ThreadInserir(buf, '3');
        
        ThreadEsvaziar imp = new ThreadEsvaziar(buf);

        her1.start();
        her2.start();
        her3.start();
        imp.start();

    }

}
