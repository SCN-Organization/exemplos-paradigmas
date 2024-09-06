package A_criandoThreads;

import java.io.IOException;
import static java.lang.Thread.sleep;
import java.util.logging.Level;
import java.util.logging.Logger;

public class ThreadInterface implements Runnable {

    private final Appendable buffer;
    private final String texto;

    public ThreadInterface(Appendable buf, String texto) {
        this.buffer = buf;
        this.texto = texto;
    }

    @Override
    public void run() {
        for (int i = 0; i < 5; i++) {
            try {
                buffer.append(texto);
            } catch (IOException ex) {
                Logger.getLogger(ThreadInterface.class.getName()).log(Level.SEVERE, null, ex);
            }
            try {
                sleep((long) Math.random());
            } catch (InterruptedException ie) {//se chegar mensagem para interromper sono
            }
        }
    }

   

}
