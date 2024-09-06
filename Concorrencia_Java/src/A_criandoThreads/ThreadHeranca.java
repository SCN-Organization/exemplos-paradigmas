package A_criandoThreads;

import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;

public class ThreadHeranca extends Thread {

    Appendable bufffer;
    private final String texto;

    public ThreadHeranca(Appendable buf, String texto) {
        this.bufffer = buf;
        this.texto = texto;
    }

    @Override
    public void run() {
        for (int i = 0; i < 5; i++) {
            try {
                bufffer.append(texto);
            } catch (IOException ex) {
                Logger.getLogger(ThreadHeranca.class.getName()).log(Level.SEVERE, null, ex);
            }
            try {
                sleep((long) Math.random());
            } catch (InterruptedException ie) {//se chegar mensagem para interromper sono
            }
        }
    }

   
}
