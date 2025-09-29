package E_competicaoPool;

import java.util.logging.Level;
import java.util.logging.Logger;

public class ThreadHeranca extends Thread {

    private final Pool pool;
    private final String id;

    public ThreadHeranca(Pool pool, String id) {
        this.pool = pool;
        this.id = id;
    }

    @Override
    public void run() {
        Object item = null;
        for (int i = 0; i < 5; i++) {
            
            try {
                item = pool.getItem();
                System.out.println("Thread "+id+" pegou " + item.toString());
            } catch (InterruptedException ex) {
                Logger.getLogger(ThreadHeranca.class.getName()).log(Level.SEVERE, null, ex);
            }
            

            try {
                sleep((long) 700);
                //sleep((long) Math.random());
            } catch (InterruptedException ie) {//se chegar mensagem para interromper sono
            }
            
            System.out.println("Thread "+id+" devolveu " + item.toString());
            pool.putItem(item);
        }
    }
}
