package D_cooperacaoWaitNotify;


public class BufferWaitNotify {

    private final char[] buffer;//array que guarda elementos do buffer
    private int proximo;
    private final int CAPACIDADE = 100;
    
    public BufferWaitNotify() {
        buffer = new char[CAPACIDADE];
        proximo = 0;
    }

    /**
     * Insere se tem espaço. 
     * Se está cheio, não altera o buffer e notifica quem espera.
     * 
     * @param c Caractere para inserir.
     */
    public synchronized void inserir(char c) {
        if (proximo < CAPACIDADE) {
            buffer[proximo++] = c;
        } else {
            notifyAll();//notifica se houver alguma thread no wait 
        }
    }

    /**
     * Espera até ficar cheio.
     * Quando cheio, esvazia e retorna o buffer. 
     * Se não estiver cheio, espera encher.
     * 
     * @return Conteúdo do buffer.
     */
    public synchronized String esvaziar() {
        while (proximo < CAPACIDADE)
            try {
                wait();//espera pela notificação de quando estiver cheio
            } catch (InterruptedException ie) {
            }
        proximo = 0;
        return new String(buffer);
    }

}
