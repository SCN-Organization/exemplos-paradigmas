package main

import (
    "fmt"
    "math/rand"
    "time"
)

var counter int = 0
var c chan int
var counter2 int = 0

func delayTime(limit int) int {
    return rand.Intn(limit)
}

func thread1() {
    c <- 0 //corresponde ao mutex lock
    x := counter
    //fmt.Printf("x = %d\n", x)
    time.Sleep(time.Duration(delayTime(200)) * time.Millisecond) //200ms de delay
    counter = x + 1
    <-c //corresponde ao mutex unlock
    counter2++
}

func main() {

    c = make(chan int, 1)

    go thread1()
    go thread1()
    go thread1()
    go thread1()

    for counter2 < 4 {
        time.Sleep(100 * time.Millisecond)
    }

    fmt.Printf("counter = %d", counter)
}
