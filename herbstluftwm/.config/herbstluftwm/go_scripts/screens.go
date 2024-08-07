package main

import (
	"fmt"
	"os/exec"
	"strings"
)

func main() {
	// fmt.Println("SCREEN")
	cmd, err := exec.Command("xrandr").Output()
	if err != nil {
		fmt.Println("CUNT! install xrandr.")
	}
	split_lines := strings.Split(string(cmd), "\n")
	var displays = []string{}
	for _, line := range split_lines {
		if !strings.Contains(line, " connected ") {
			//if it aint connected i dont wanna see it
			continue
		}
		split := strings.Fields(line)
		displays = append(displays, split[0])
	}
	// fmt.Println(displays)
	hdmi_only := false
	var external string
	var internal string
	for _, v := range displays {
		if strings.Contains(strings.ToUpper(v), "HDMI") {
			hdmi_only = true
			external = v
		}
		if strings.Contains(strings.ToUpper(v), "EDP") {
			internal = v
		}
	}
	if hdmi_only == true {
		// fmt.Println(external)
		// fmt.Println(internal)
		command := exec.Command("xrandr", "--output", internal, "--off", "--output", external, "--mode", "2560x1080", "--auto")
		// command := exec.Command("xrandr", "--output", external)

		output, err := command.Output()
		if err != nil {
			fmt.Printf("err is: %s\n", err)
			return
		}
		fmt.Printf("String:%v", string(output))

		//xrandr set hdmi only

	} else {
		//xrandr set internal

	}
}
