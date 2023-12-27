package main

import (
	"fmt"
	"time"
	"flag"
)

//variável usada para definir os filósofos que fazem parte do jantar
//quando true, o programa usa um filósofo diferente para evitar deadlock
//quando false, todos os filósosofos do programa são iguais e acontece deadlock
var deadlockfree bool

var N int

//colocar um valor no canal representa pegar o garfo
//tirar um valor do canal representa devolver o garfo
var garfos[] chan int

func pausa(){
 	time.Sleep(100*time.Millisecond)	
}

func filosofo1(id int) {
	for{
		fmt.Printf("senta.%v,\n", id)		
		pausa();

		garfos[id] <- 0
		fmt.Printf("pega.%v.%v,\n", id, id)
		pausa();
		
		garfos[(id+1)%N] <- 0
		fmt.Printf("pega.%v.%v,\n", id, (id+1)%N)
		pausa();
		
		fmt.Printf("come.%v,\n", id)
		pausa();
		
		<- garfos[(id+1)%N]
		fmt.Printf("devolve.%v.%v,\n", id, (id+1)%N)
		pausa();
		
		<- garfos[id]
		fmt.Printf("devolve.%v.%v,\n", id, id)
		pausa();
		
		fmt.Printf("levanta.%v,\n", id)		
		pausa();
	}
}

func filosofos(){
	for i:= 0 ; i < N; i++ {
		go filosofo1(i)
	}		
}

func filosofo2(id int) {
	for{
		fmt.Printf("senta.%v\n", id)		
		pausa();

		garfos[(id+1)%N] <- 0
		fmt.Printf("pega.%v.%v,\n", id, (id+1)%N)
		pausa();
		
		garfos[id] <- 0
		fmt.Printf("pega.%v.%v,\n", id, id)
		pausa();
		
		fmt.Printf("come.%v,\n", id)
		pausa();
		
		<- garfos[id]
		fmt.Printf("devolve.%v.%v,\n", id, id)
		pausa();
		
		<- garfos[(id+1)%N]
		fmt.Printf("devolve.%v.%v,\n", id, (id+1)%N)
		pausa();
		
		fmt.Printf("levanta.%v,\n", id)		
		pausa();
	}
}

func filosofos_(){
	go filosofo2(0)
	for i:= 1 ; i < N; i++ {
		go filosofo1(i)
	}
}

//exemplo de como rodar o programa
//go run filosofos-buffered.go -deadlockfree=true

func main(){

	/* Este bloco de código faz a leitura dos parâmetros de entrada do programa */
    fmt.Println("O parâmetro -h mostra as opções de parâmetros para o programa")
    ptr_DEADLOCK := flag.Bool("deadlock", false, "true para deadlockfree e false para versão com deadlock")
    ptr_N := flag.Int("n", 3, "numero de filosofos no jantar")
    flag.Parse()
    fmt.Println("DEADLOCK=", *ptr_DEADLOCK)
    fmt.Println("N=", *ptr_N)

    deadlockfree = !(*ptr_DEADLOCK)
	deadlockfree = false
    N = *ptr_N
    garfos = make([]chan int, N)

	// inicializa o array de garfos
	for i:= 0 ; i < N; i++ {
   		garfos[i] = make(chan int, 1)
	}
	
	if(deadlockfree) {
		go filosofos_()
	}else{
		go filosofos()
	}

	for{
 		time.Sleep(100*time.Millisecond)	
		//fmt.Printf(".")
	}
}
