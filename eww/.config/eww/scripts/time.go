package main

import (
	"fmt"
	"os"
	"strconv"
	"time"
)

var given_time = 0

// simple timer, returns the time and time left
func main() {
	args := os.Args[1:]
	if len(args) == 0 {
		fmt.Println("specify timer length..")
	}
	time, err := strconv.Atoi(args[0])
	given_time = time

	if err != nil {
		fmt.Println("please specify a number..")
		return
	}

	fmt.Printf("time remaining: %v\n", given_time)
	tick_down()
}

func tick_down() {
	for range time.Tick(time.Second) {
		given_time--
		fmt.Println(given_time)
		if given_time == 0 {
			fmt.Println("DONE")
			return
		}
	}
}
