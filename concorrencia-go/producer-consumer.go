package main

import (
	"fmt"
	"math/rand"
	"time"
)

const (
	numProducers = 2
	numConsumers = 3
	maxQueueSize = 5
)

func main() {
	queue := make(chan int, maxQueueSize)

	for i := 0; i < numProducers; i++ {
		go producer(i, queue)
	}

	for i := 0; i < numConsumers; i++ {
		go consumer(i, queue)
	}

	// Allow some time for producers and consumers to run
	time.Sleep(time.Second * 5)

	close(queue)
	fmt.Println("All producers and consumers are done.")
}

func producer(id int, queue chan<- int) {
	for {
		value := rand.Intn(100)
		fmt.Printf("Producer %d: producing %d\n", id, value)
		queue <- value
		time.Sleep(time.Millisecond * time.Duration(rand.Intn(500)))
	}
}

func consumer(id int, queue <-chan int) {
	for {
		value, ok := <-queue
		if !ok {
			fmt.Printf("Consumer %d: no more items to consume\n", id)
			return
		}
		fmt.Printf("Consumer %d: consuming %d\n", id, value)
		time.Sleep(time.Millisecond * time.Duration(rand.Intn(800)))
	}
}
