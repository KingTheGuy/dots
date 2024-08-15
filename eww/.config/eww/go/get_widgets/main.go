package main

import (
	"fmt"
	"io/ioutil"
	"strings"
)

func main() {
	// output, err := exec.Command("cat", "$HOME/.config/eww/eww.yuck").Output()
	file, err := ioutil.ReadFile("/home/surv/.config/eww/eww.yuck")
	if err != nil {
		fmt.Println(err)
	}
	fields := strings.Split(string(file), "\n")
	for _, v := range fields {
		if strings.Contains(v, ";") {
			continue
		}
		if strings.Contains(v, "defwidget") {
			huh := strings.Replace(v, "(defwidget ", "", 0)
			fmt.Println(huh)

		}

	}
	fmt.Println("yes")
	// fmt.Println(string(file))

}
