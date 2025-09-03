package main

import (
	"fmt"
	"os"
	"strings"
)

func main() {
	fmt.Println("this works")
	file, _ := os.ReadFile("../../test.md")
	// print(string(file))
	// find the 2nd ":" then add 2 to it and split it there
	splits := strings.Split(string(file), "\n")
	var line string
	split_index := 0
	index := 0
	for i, s := range splits[0] {
		if string(s) == ":" {
			index++
		}
		if index == 2 {
			split_index = i

		}
	}
	// FUCK i just do not want to think right now, i do not like what am going to do later.

	println(line)

}
