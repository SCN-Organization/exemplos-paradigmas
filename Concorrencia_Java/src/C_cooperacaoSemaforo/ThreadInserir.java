package C_cooperacaoSemaforo;

public class ThreadInserir extends Thread {

    private final BufferSemaforo buffer;
    private final char id;

    public ThreadInserir(BufferSemaforo buf, char c) {
        this.buffer = buf;
        this.id = c;
    }

    @Override
    public void run() {
        for (int i = 0; i < 5000; i++) {
            buffer.inserir(id);
            try {
                sleep((long) 10);
            } catch (InterruptedException ie) {
            }
        }
        System.out.println("Thread " + id + " terminou");
    }
}
