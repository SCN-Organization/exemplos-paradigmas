package cooperacaoSemaforo;

public class ThreadEsvaziar extends Thread {

    private final BufferSemaforo buf;

    public ThreadEsvaziar(BufferSemaforo buf) {
        this.buf = buf;
    }

    @Override
    public void run() {
        String result;
        for (int i = 0; i < 10; i++) {

            result = buf.esvaziar();
            System.out.println("\n\nImpressao # " + (i + 1) + ":\n Buffer = "
                    + result + " -> Tamanho: " + result.length());
        }
        System.out.println("ThreadEsvaziar terminou");
    }
}
