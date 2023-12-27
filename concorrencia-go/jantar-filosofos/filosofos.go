package main

import (
	"fmt"
	"time"
	"flag"
)

var N int

var pega[] chan int
var devolve[] chan int

func pausa(){
 	time.Sleep(100*time.Millisecond)	
}

func garfo(id int) {
	for{
		f := <- pega[id]
		fmt.Printf("pega.%v.%v,\n", f, id)
		pausa();

		f = <- devolve[id]
		fmt.Printf("devolve.%v.%v,\n", f, id)
		pausa();
	}
}

func garfos(){
	for i:= 0 ; i < N; i++ {
		go garfo(i)
	}
}


func filosofo1(id int) {
	for{
		fmt.Printf("senta.%v,\n", id)		
		pausa();

		pega[id] <- id
		pausa();
		
		pega[(id+1)%N] <- id
		pausa();
		
		fmt.Printf("come.%v,\n", id)
		pausa();
		
		devolve[(id+1)%N] <- id
		pausa();
		
		devolve[id] <- id
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
		fmt.Printf("senta.%v,\n", id)		
		pausa();

		pega[(id+1)%N] <- id
		pausa();

		pega[id] <- id
		pausa();		
		
		fmt.Printf("come.%v,\n", id)
		pausa();
		
		devolve[(id+1)%N] <- id
		pausa();
		
		devolve[id] <- id
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
	/*
    fmt.Println("O parâmetro -h mostra as opções de parâmetros para o programa")
    ptr_DEADLOCK := flag.Bool("deadlock", false, "true para deadlockfree e false para versão com deadlock")
    ptr_N := flag.Int("n", 3, "numero de filosofos no jantar")
    flag.Parse()
    fmt.Println("DEADLOCK=", *ptr_DEADLOCK)
    fmt.Println("N=", *ptr_N)
    */

	//quando true, o programa usa um filósofo diferente para evitar deadlock
	//quando false, todos os filósosofos do programa são iguais e acontece deadlock
    //deadlockfree := !(*ptr_DEADLOCK)
	deadlockfree = false

    //N = *ptr_N
	N = 5

    pega = make([]chan int, N)
    devolve = make([]chan int, N)

	for i:= 0 ; i < N; i++ {
   		pega[i] = make(chan int, 0)
   		devolve[i] = make(chan int, 0)
	}

	go garfos()
	
	if(deadlockfree) {
		go filosofos_()
	}else{
		go filosofos()
	}

	for{
 		pausa()	
		//fmt.Printf(".")
	}
}
