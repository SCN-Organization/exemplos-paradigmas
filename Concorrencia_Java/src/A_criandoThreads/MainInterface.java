/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package A_criandoThreads;

/**
 *
 * @author sidneynogueira
 */
public class MainInterface {

    public static void main(String[] args) {
        
        StringBuilder buffer = new StringBuilder();//não é thread safe
        //StringBuffer buffer = new StringBuffer();//é thread safe
        
        Thread inter1 = new Thread(new ThreadInterface(buffer, "thread 1\n"));
        Thread inter2 = new Thread(new ThreadInterface(buffer, "thread 2\n"));
        Thread inter3 = new Thread(new ThreadInterface(buffer, "thread 3\n"));

        inter1.start();
        inter2.start();
        inter3.start();

        for (int i = 0; i < 10; i++) {
            System.out.println(i + ": " + buffer.toString());
        }

    }

}
