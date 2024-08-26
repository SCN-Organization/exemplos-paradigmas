package cooperacaoSemaforo;

import java.util.concurrent.Semaphore;

/**
 * Similar a classe BufferWaitNotify porém usa Semáforo no lugar de wait/notify
 * @author sidneynogueira
 */
public class BufferSemaforo {

    private final char[] buf;
    private int tam;
    private final int MAX = 1000;
    private final Semaphore semaforo;

    public BufferSemaforo() {
        semaforo = new Semaphore(0);//acquire/release
        buf = new char[MAX];
        tam = 0;
    }
    
    public synchronized void inserir(char c) {
        if (tam == MAX) {
            semaforo.release();
        } else {
            buf[tam++] = c;
        }

    }

    public String esvaziar() {
        try {
            semaforo.acquire();
        } catch (InterruptedException ie) {
        }
        tam = 0;
        return new String(buf);
    }

}
