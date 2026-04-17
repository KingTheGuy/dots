package main

import (
	"fmt"
	"os/exec"
	"strconv"
	"strings"
)

func main() {
	cur_val, _ := exec.Command("eww", "get", "pro").Output()
	new_val, err := strconv.Atoi(strings.TrimSpace(string(cur_val)))
	// fmt.Println(new_val)
	if err != nil {
		fmt.Println(err)
		return
	}
	the_float := float64(new_val) / 100
	if new_val == 0 {
		fmt.Println("zero")
		cur_vol, _ := exec.Command("wpctl", "get-volume", "@DEFAULT_AUDIO_SINK@").Output()
		split := strings.Split(string(cur_vol), ":")
		value, err := strconv.ParseFloat(strings.TrimSpace(split[1]), 64)
		if err != nil {
			fmt.Println(err)
		}
		exec.Command("eww", "update", fmt.Sprintf("pro=%v", value*100)).Run()
		the_float = value
	}
	// fmt.Println(the_float)

	exec.Command("wpctl", "set-volume", "@DEFAULT_AUDIO_SINK@", fmt.Sprint(the_float)).Run()
	fmt.Println(fmt.Sprint(the_float))
}
