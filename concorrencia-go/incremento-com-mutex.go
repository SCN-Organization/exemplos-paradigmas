package main

import (
    "fmt"
    "math/rand"
    "time"
)

var c chan int //canal usado como mutex
var counter int = 0 //variável compartilhada
var counter2 int = 0 //quantas threads concluiram

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

    N := 2

    for i:=0; i<N; i++{
        go thread1()
    }

    //laço que espera as threads concluirem
    for counter2 < N {
        time.Sleep(100 * time.Millisecond)
    }

    fmt.Printf("counter = %d", counter)
}
