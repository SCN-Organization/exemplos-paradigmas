/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package competicaoPool;

import java.util.concurrent.Semaphore;

/**
 *
 * @author sidneynogueira
 */
public class Pool {
        
   private final int maxAvailable;//quantidade de itens disponíveis
   private final Object[] items;//itens disponíveis
   private final boolean[] used;//marcar itens utilizados/disponíveis
   private final Semaphore available;
   
   public Pool(int maxAvailable){
       this.maxAvailable = maxAvailable;
       available = new Semaphore(maxAvailable, true);
       items = new Object[maxAvailable];
       for (int i = 0; i < maxAvailable; i++) {
           items[i] = ""+i;
       }
       used = new boolean[maxAvailable];//todos os elementos são false
   }

   public Object getItem() throws InterruptedException {
     available.acquire();
     return getNextAvailableItem();
   }

   public void putItem(Object item) {
     if (markAsUnused(item))
       available.release();
   }

   private synchronized Object getNextAvailableItem() {
     for (int i = 0; i < maxAvailable; ++i) {
       if (!used[i]) {
          used[i] = true;
          return items[i];
       }
     }
     return null; // not reached
   }

   private synchronized boolean markAsUnused(Object item) {
     for (int i = 0; i < maxAvailable; ++i) {
       if (item == items[i]) {
          if (used[i]) {
            used[i] = false;
            return true;
          } else
            return false;
       }
     }
     return false;
   }
 }
