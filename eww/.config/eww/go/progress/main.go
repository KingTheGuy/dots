package main

import (
	"fmt"
	"os"
	"strconv"
)

func main() {
	args := os.Args[1:]
	dir := args[0]
	amount, _ := strconv.Atoi(args[1])
	cur_amount, _ := strconv.Atoi(args[2])
	if dir == "down" {
		if (cur_amount - amount) <= 0 {
			cur_amount = 0
		} else {
			cur_amount -= amount
		}
	} else {
		cur_amount += amount
	}
	// fmt.Println("shit")
	fmt.Println(cur_amount)
}
