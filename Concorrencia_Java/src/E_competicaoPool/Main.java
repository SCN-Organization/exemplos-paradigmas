/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package E_competicaoPool;

/**
 *
 * @author sidneynogueira
 */
public class Main {

    public static void main(String[] args) throws InterruptedException {
        
        int NUM_RECURSOS = 3;
        int NUM_THREADS = 8;
        
        Pool pool = new Pool(NUM_RECURSOS);

        Thread[] threads = new Thread[NUM_THREADS];

        for (int i = 0; i < threads.length; i++) {
            threads[i] = new ThreadHeranca(pool,""+i);
            threads[i].start();
        }
        
        for (Thread thread : threads) {
            thread.join();
        }

    }
}
