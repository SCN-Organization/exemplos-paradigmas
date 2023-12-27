package main

import (
	"fmt"
	"time"
)

// número de corotinas produtor
const N = 3

//array de canais que é usado pelo montador para avisar para
//os produtores que a montagem aconteceu
var reinicia[] chan int = make([]chan int, N)

//canal usado para produtor avisar para montador que já fez
//a peça
var faz chan int = make(chan int, 0)

// produz e espera o aviso que a montagem terminou para repetir
// o loop
func produtor(id int) {
	for{
		time.Sleep(200 * time.Millisecond)
		fmt.Printf("faz.%v,\n", id)
		faz <- id //avisa ao montador que fez
		<- reinicia[id] //recebe o aviso que a montagem terminou
	}
}

// corotina montador:
// quando o canal faz está cheio a fabricacao foi concluída
// após a montador comunica para avisar que fabricação está liberada
func montador() {
	contador := 0
	for{
		if(contador == N){
			fmt.Println("monta,")
			for i := 0 ; i < N; i++ {//avisa cada um dos produtores
   				reinicia[i] <- 0
			}
			fmt.Println("reinicia,")
			contador = 0
		}else{
			<- faz //espera o aviso de um produtor
			contador++
		}
	}
}

func main(){

	for i := 0 ; i < N; i++ {
   		reinicia[i] = make(chan int, 0)
	}
	
	for i := 0 ; i < N; i++ {
		go produtor(i)
	}	

	go montador()

	time.Sleep(3000 * time.Millisecond)
}
