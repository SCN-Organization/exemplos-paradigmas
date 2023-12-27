//https://go.dev/play/
package main

import (
	"fmt"
	"math/rand"
	"strconv"
	"time"
)

func main() {

	canal := make(chan string)

	go envia(canal)
	go recebe(canal)

	time.Sleep(1 * time.Second)
}

func envia(ch chan string) {
	for {
		ch <- strconv.Itoa(rand.Intn(100))
	}
}

func recebe(ch chan string) {
	for {
		s := <- ch
		fmt.Println("ping " + s)
	}
}

