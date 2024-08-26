package competicao;

public class Main {

    public static void main(String[] args) throws InterruptedException {
        
        MeuStringBuffer buffer = new MeuStringBuffer();
        
        int NUM = 3;
        Thread[] threads = new Thread[NUM];
        
        for (int i = 0; i < threads.length; i++) {
            threads[i] = new ThreadHeranca(buffer, "Thread "+(i+1)+"\n");
            threads[i].start();
        }
        
        for (int i = 0; i < 10; i++) {
            System.out.println(i + ": " + buffer.toString());
        }
        
    }
}
