package main

import (
	"fmt"
	"math/rand"
	"time"
)

const (
	numProducers = 2
	numConsumers = 3
	bufferSize = 5
)

func producer(id int, buf chan<- int) {
	for {
		value := rand.Intn(100)//produces a value
		fmt.Printf("Producer %d: producing %d\n", id, value)
		buf <- value
		time.Sleep(time.Millisecond * time.Duration(rand.Intn(500)))
	}
}

func consumer(id int, buf <-chan int) {
	for {
		value, ok := <-buf
		if !ok { //if channel is closed
			fmt.Printf("Consumer %d: no more items to consume\n", id)
			return
		}
		fmt.Printf("Consumer %d: consuming %d\n", id, value)
		time.Sleep(time.Millisecond * time.Duration(rand.Intn(800)))
	}
}

func main() {
	buf := make(chan int, bufferSize)

	for i := 0; i < numProducers; i++ {
		go producer(i, buf)
	}

	for i := 0; i < numConsumers; i++ {
		go consumer(i, buf)
	}

	// Allow some time for producers and consumers to run
	time.Sleep(time.Second * 5)

	close(buf)

	fmt.Println("All producers and consumers are done.")
}

