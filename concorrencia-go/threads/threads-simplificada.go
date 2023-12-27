package main

import (
	"fmt"
	"time"
	"math/rand"
)

//NUM threads disputam pelo uso de recursos cujo quantidade é
//igual a CAPACIDADE

var NUM int = 5//quantidade de threads

var CAPACIDADE int = 3//o máximo de threads que conseguem usar o recurso

var variavel int = 0 //contador compartilhado entre as threads
//contador é incrementado quando uma thread consegue acessar o recurso
//decrementado, quando libera o recurso
//valor de variavel sempre está entre 0 e CAPACIDADE

var lock chan int = make(chan int, 1) //funciona como um semáforo binário

func pausa(){
 	time.Sleep(100*time.Millisecond)	
}

func thread(id int) {

	for{

		//1 - tentar acessar um recurso
		//se tiver recurso incrementa variável
		for{
			lock <- 0//início da região crítica
			if(variavel < CAPACIDADE){
				fmt.Printf("entrou.%v,\n", id)					
				variavel++
				<- lock//fim da região crítica
				break	
			}else{
				<- lock	
				pausa();
			}
		}

		//2 - faz uso do recurso
		//simula o uso do recurso
		for{
			if(rand.Intn(2) == 0){
				fmt.Printf("ficou.%v,\n", id)					
			}else{
				fmt.Printf("saindo.%v,\n", id)					
				break
			}
		}

		//3 - libera o recurso
		//sinalizar que liberou o recurso
		lock <- 0//início da região crítica
		fmt.Printf("le.%v.%v,\n", id,variavel)//qual valor lido da variável								
		fmt.Printf("saiu.%v,\n", id)					
		variavel--
		<- lock//libera a região crítica
	}
}

func main(){

	for i := 0 ; i < NUM; i++ {
		go thread(i)
	}

	time.Sleep(1000*time.Millisecond)
}
