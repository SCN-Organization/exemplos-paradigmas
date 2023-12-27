package main

import (
	"fmt"
	"time"
//	"flag"
	"math/rand"
	"os"
)

//variavel utilizada para definir se o código usa exclusão mútua ou não
var mutex bool //se true usa controle de concorrência

var CAPACIDADE int//o máximo de threads que conseguem usar o recurso

var NUM int//quantidade de threads

var variavel int = 0 //contador compartilhado entre as threads
//contador é incrementado quando uma thread consegue acessar o recurso
//decrementado, quando libera o recurso

var lock = make(chan int, 1) //funciona como um semáfor binário
var atualizou = make(chan int, 1)
var testou = make(chan int, 1)

func pausa(){
 	time.Sleep(100*time.Millisecond)	
}

//versão das threads sem control de concorrência
func thread(id int) {
	var valor int
	for{

		for{
			valor = variavel
			fmt.Printf("le.%v.%v,\n", id,valor)								

			if(valor < CAPACIDADE){
				fmt.Printf("entrou.%v,\n", id)					
				variavel = valor+1
				fmt.Printf("escreve.%v.%v,\n", id,valor+1)								
				atualizou <- variavel
				<- testou
				break	
			}else{
				pausa()
			}
		}

		for{
			pausa()
			if(rand.Intn(2) == 0){
				fmt.Printf("ficou.%v,\n", id)					
			}else{
				fmt.Printf("saindo.%v,\n", id)					
				break
			}
		}

		valor = variavel
		fmt.Printf("le.%v.%v,\n", id,valor)								

		if(valor > 0){
			fmt.Printf("saiu.%v,\n", id)					
			variavel = valor-1
			fmt.Printf("escreve.%v.%v,\n", id,valor-1)								
			atualizou <- variavel
			<- testou
		}else{
			fmt.Printf("foraLimite,\n")								
			return
		}
	}
}

//versão das threads com controle de concorrência
func thread_(id int) {
	var valor int
	for{

		//se tiver recurso incrementa variável
		for{
			lock <- 0//início da região crítica
			valor = variavel
			fmt.Printf("le.%v.%v,\n", id,valor)								

			if(valor < CAPACIDADE){
				fmt.Printf("entrou.%v,\n", id)					
				variavel = valor+1
				fmt.Printf("escreve.%v.%v,\n", id,valor+1)								
				atualizou <- variavel//avisar ao monitor o valor que está sendo escrito
				<- testou//espera o monitor avisar que concluiu o teste
				<- lock//fim da região crítica
				break	
			}else{
				<- lock	
				pausa();
			}
		}

		//simula o uso do recurso
		for{
			if(rand.Intn(2) == 0){
				fmt.Printf("ficou.%v,\n", id)					
			}else{
				fmt.Printf("saindo.%v,\n", id)					
				break
			}
		}

		//sinalizar que liberou o recurso
		lock <- 0//início da região crítica
		valor = variavel
		fmt.Printf("le.%v.%v,\n", id,valor)//qual valor lido da variável								

		if(valor > 0){
			fmt.Printf("saiu.%v,\n", id)					
			variavel = valor-1
			fmt.Printf("escreve.%v.%v,\n", id,valor-1)//sinaliza o valor que foi atualizado								
			atualizou <- variavel//avisa o monitor que atualizou
			<- testou//espera aviso que monitor fez o teste
			<- lock//libera a região crítica
		}else{
			<- lock
			fmt.Printf("foraLimite,\n")								
			return
		}
	}
}

// monitora o valor da variável compartilhada para ver se recebe um valor
// inconsistente
func monitor(){
	anterior := 0
	atualizacoes := 0
	var v int
	for{		
		v = <- atualizou //recebe o valor escrito na variável compartilhada
		atualizacoes++
		if(v > CAPACIDADE) {//valor extrapolou limite
        	fmt.Printf("erro.0 em %d atualizacoes\n",atualizacoes)
        	os.Exit(0)	
    	} else if (v == anterior) {//atualiza para o valor anterior
        	fmt.Printf("erro.1 em %d atualizacoes\n",atualizacoes)
        	os.Exit(1)	
    	} else if (v < anterior-1) {//decrementou mais de uma unidade
        	fmt.Printf("erro.2 em %d atualizacoes\n",atualizacoes)
        	os.Exit(2)	
    	} else if (v > anterior+1) {//incrementou mais de uma unidade
        	fmt.Printf("erro.3 em %d atualizacoes\n",atualizacoes)
        	os.Exit(3)	
        }
        testou <- 0//avisa para a corotina que concluiu o teste
        anterior = v
	}
}

func main(){

	/*
	// Este bloco de código faz a leitura dos parâmetros de entrada do programa
    fmt.Println("O parâmetro -h mostra as opções de parâmetros para o programa")
    ptr_MUTEX := flag.Bool("mutex", true, "true para habilitar uso de mutex")
    ptr_CAPACIDADE := flag.Int("capacidade", 2, "valor maximo de threads na regiao critica")
    ptr_NUM := flag.Int("num", 3, "numero de threads")
    flag.Parse()
    fmt.Println("MUTEX=", *ptr_MUTEX)
    fmt.Println("CAPACIDADE=", *ptr_CAPACIDADE)
    fmt.Println("NUM=", *ptr_NUM)

    mutex = *ptr_MUTEX
    CAPACIDADE = *ptr_CAPACIDADE
    NUM = *ptr_NUM
    */

    mutex = false //usa mutex?
    CAPACIDADE = 3 //quantidade de recurso
    NUM = 5 //quantidade de threads
	
    go monitor()

	if(mutex) {
		for i:= 0 ; i < NUM; i++ {
			go thread_(i)
		}
	}else{
		for i:= 0 ; i < NUM; i++ {
			go thread(i)
		}		
	}

	time.Sleep(1000*time.Millisecond)	

	/*
	for{
 		time.Sleep(100*time.Millisecond)	
		//fmt.Printf(".")
	}
	*/
}
