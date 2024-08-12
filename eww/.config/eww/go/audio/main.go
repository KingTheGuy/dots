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

	var device string
	if args[0] == "sink" {
		device = "@DEFAULT_AUDIO_SINK@"
	} else if args[0] == "source" {
		device = "@DEFAULT_AUDIO_SOURCE@"
	}
	output, err := exec.Command("wpctl", "get-volume", device).Output()
	if err != nil {
		fmt.Print(err)
		return
	}
	field := strings.Fields(string(output))
	what, _ := strconv.ParseFloat(field[1], 64)
	volume := int(what * 100)
	fmt.Printf("Volume level: %v\n", volume)
	// fmt.Println(what)
	// if volume >= 100 {
	// 	volume = 99
	// }
	if args[0] == "sink" {
		device = "volume_level"
	} else if args[0] == "source" {
		device = "mic_level"
	}
	exec.Command("eww", "update", fmt.Sprintf("%s=%v", device, volume)).Run()
}

func setVolume(args []string) {
	amount := "2%"
	if len(args) > 0 {
		if args[0] == "sink" {
			if len(args) > 1 {
				if args[1] == "up" {
					amount = amount + "+"
				} else if args[1] == "down" {
					amount = amount + "-"
				} else if args[1] == "mute" {
					exec.Command("wpctl", "set-mute", "@DEFAULT_AUDIO_SINK@", "toggle").Run()
					return
				}
				exec.Command("wpctl", "set-volume", "@DEFAULT_AUDIO_SINK@", amount).Run()
			}
		} else if args[0] == "source" {
			if len(args) > 1 {
				if args[1] == "up" {
					amount = amount + "+"
				} else if args[1] == "down" {
					amount = amount + "-"
				} else if args[1] == "mute" {
					exec.Command("wpctl", "set-mute", "@DEFAULT_AUDIO_SOURCE@", "toggle").Run()
					return
				}
				exec.Command("wpctl", "set-volume", "@DEFAULT_AUDIO_SOURCE@", amount).Run()
			}
		}
	}
}

func writeToFile() {

}
