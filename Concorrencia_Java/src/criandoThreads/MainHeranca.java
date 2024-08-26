/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package criandoThreads;

/**
 *
 * @author sidneynogueira
 */
public class MainHeranca {

    public static void main(String[] args) {
        
        //StringBuilder buffer = new StringBuilder();//não é thread safe
        StringBuffer buffer = new StringBuffer();//é thread safe
        
        ThreadHeranca her1 = new ThreadHeranca(buffer, "thread 1\n");
        ThreadHeranca her2 = new ThreadHeranca(buffer, "thread 2\n");
        ThreadHeranca her3 = new ThreadHeranca(buffer, "thread 3\n");
        
        her1.start();
        her2.start();
        her3.start();
        
        for (int i = 0; i < 30; i++) {
            System.out.println(i + ": " + buffer.toString());
        }

    }

}
