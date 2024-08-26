package competicao;

public class ThreadHeranca extends Thread {

    private final MeuStringBuffer buffer;//é thread safe
    private final String texto;

    public ThreadHeranca(MeuStringBuffer buf, String texto) {
        this.buffer = buf;
        this.texto = texto;
    }

    @Override
    public void run() {
        for (int i = 0; i < 5; i++) {
            
            try {
                sleep((long) Math.random());
            } catch (InterruptedException ie) {//se chegar mensagem para interromper sono
            }

            buffer.append(texto);
        }
    }
}
