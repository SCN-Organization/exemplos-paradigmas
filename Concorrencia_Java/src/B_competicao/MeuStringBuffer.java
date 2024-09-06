package B_competicao;

public class MeuStringBuffer {//implementação thread safe

    private final StringBuilder buffer;

    public MeuStringBuffer() {
        buffer = new StringBuilder();
    }

    public synchronized void append(String novo) {
        for (int i = 0; i < novo.length(); i++) {
            buffer.append(novo.charAt(i));
        }
    }
    
    public synchronized String toString(){
        return new String(buffer.toString());
    }

}
