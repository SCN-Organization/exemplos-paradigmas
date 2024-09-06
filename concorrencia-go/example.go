//https://go.dev/play/
package main

import (
	"fmt"
	"math/rand"
	"strconv"
	"time"
)

func envia(ch chan string) {
	for {
		//gera número entre 0 e 100
		//converte para string
		//enviar no canal ch
		ch <- strconv.Itoa(rand.Intn(100))
	}
}

func recebe(ch chan string) {
	for {
		//guarda o valor do canal ch em s
		s := <- ch
		fmt.Println("ping " + s)
	}
}

func main() {

	//canal com tamanho 0
	canal := make(chan string)

	go envia(canal) //cria uma co-rotina e inicia execução 
	go recebe(canal)

	//
	time.Sleep(1 * time.Second)
}


