package main

import (
	"fmt"
	"time"
)

// número de corotinas produtor
const N = 3

var reinicia[] chan int = make([]chan int, N)
var faz chan int = make(chan int, 0)

func produtor(id int) {
	for{
		time.Sleep(200 * time.Millisecond)
		fmt.Printf("faz.%v,\n", id)
		faz <- id
		<- reinicia[id]
	}
}

func produtores(n int){
	for i := 0 ; i < n; i++ {
		go produtor(i)
	}	
}

// corotina montador:
// quando o canal faz está cheio a fabricacao foi concluída
// após a montador comunica para avisar que fabricação está liberada
func montador(n int) {
	contador := 0
	for{
		if(contador == n){
			fmt.Println("monta,")
			for i := 0 ; i < N; i++ {
   				reinicia[i] <- 0
			}
			fmt.Println("reinicia,")
			contador = 0
		}else{
			<- faz
			contador++
		}
	}
}

func main(){

	for i := 0 ; i < N; i++ {
   		reinicia[i] = make(chan int, 0)
	}
	
	go produtores(N)
	go montador(N)

	time.Sleep(3000 * time.Millisecond)
}
