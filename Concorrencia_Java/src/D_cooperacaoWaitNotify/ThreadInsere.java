package D_cooperacaoWaitNotify;

public class ThreadInsere extends Thread {

    private BufferWaitNotify buffer;
    private char id;

    public ThreadInsere(BufferWaitNotify buffer, char id) {
        this.buffer = buffer;
        this.id = id;
    }

    public void run() {
        for (int i = 0; i < 500; i++) {
            buffer.inserir(id);
            try {
                sleep((long) 50);
            } catch (InterruptedException ie) {
            }
        }
        System.out.println("Thread " + id + " terminou.");
    }
}
