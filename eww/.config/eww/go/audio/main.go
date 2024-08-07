package main

import (
	"fmt"
	"os"
	"os/exec"
	"strconv"
	"strings"
)

//NOTE: should have something change the volume and as it changes
//write the change to a file. and have the other programs get level from there.

//TODO: switch this to be a program that loops, instead of calling it over and over again

func main() {
	args := os.Args[1:]
	setVolume(args)

	out, err := exec.Command("wpctl", "get-volume", "@DEFAULT_AUDIO_SINK@").Output()
	if err != nil {
		fmt.Print("we error")
	}
	field := strings.Fields(string(out))
	what, _ := strconv.ParseFloat(field[1], 64)
	// fmt.Println(what)
	volume := int(what * 100)
	fmt.Printf("Volume level: %v\n", volume)
	// if volume >= 100 {
	// 	volume = 99
	// }
	exec.Command("eww", "update", fmt.Sprintf("volume_level=%v", volume)).Run()
	// for x := range args {
	// 	fmt.Println(args[x])
	// }
}

func setVolume(args []string) {
	amount := "2%"
	if len(args) > 0 {
		if args[0] == "up" {
			amount = amount + "+"
		} else if args[0] == "down" {
			amount = amount + "-"
		} else if args[0] == "mute" {
			exec.Command("wpctl", "set-mute", "@DEFAULT_AUDIO_SINK@", "toggle").Run()
			return
		}
		exec.Command("wpctl", "set-volume", "@DEFAULT_AUDIO_SINK@", amount).Run()
	}
}

func writeToFile() {

}
