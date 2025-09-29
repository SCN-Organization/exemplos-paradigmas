package C_cooperacaoSemaforo;

import java.util.concurrent.Semaphore;

/**
 * Similar a classe BufferWaitNotify porém usa Semáforo no lugar de wait/notify
 *
 * Inserir só acontece quando existe espaço no buffer.
 * Esvaziar só acontece quando o buffer está cheio.
 * @author sidneynogueira
 */
public class BufferSemaforo {

    private final char[] buf;
    private int proximo;
    private final int MAX = 1000;
    private final Semaphore semaforo;

    public BufferSemaforo() {
        semaforo = new Semaphore(0);//wait -> acquire, release -> release
        buf = new char[MAX];
        proximo = 0;
    }
    
    public synchronized void inserir(char c) {
        if (proximo == MAX) {
            semaforo.release();
        } else {
            buf[proximo++] = c; //buf[proximo] = c; proximo++;
        }

    }

    public String esvaziar() {
        try {
            semaforo.acquire();//equivale ao wait
        } catch (InterruptedException ie) {
        }
        proximo = 0;
        return new String(buf);
    }

}
