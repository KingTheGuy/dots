package main

import (
	"fmt"
	"os"
	"strings"
)

func main() {
	data, err := os.ReadFile("/home/olrak/llama_output.json")
	if err != nil {
		fmt.Println(err)
		return
	}
	fields := strings.Fields(string(data))
	var json string
	for x, item := range fields {
		if x == 0 {
			json = fmt.Sprintf("%s", item)
			// } else if x == (len(fields) -1) {
			// 	json = fmt.Sprintf("%s,%s", json, item)
		} else {
			json = fmt.Sprintf("%s,%s", json, item)
		}
		// fmt.Printf("line: %s,\n", item)
	}

	fmt.Println(fmt.Sprintf("[%s]", json))

}
