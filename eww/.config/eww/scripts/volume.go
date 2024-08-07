package main

import (
	"fmt"
	"os"
	"os/exec"
	"strconv"
	"strings"
)

func main() {
	user_args := os.Args[1:]
	if len(user_args) > 0 {
		if user_args[0] == "up" {
			// "+0.3%"
			// exec.Command("pactl", "set-sink-volume", "@DEFAULT_SINK@", "+3%").Run()
			exec.Command("wpctl", "set-volume", "@DEFAULT_AUDIO_SINK@", "2%+").Run()

		}
		if user_args[0] == "down" {
			// exec.Command("pactl", "set-sink-volume", "@DEFAULT_SINK@", "-3%").Run()
			exec.Command("wpctl", "set-volume", "@DEFAULT_AUDIO_SINK@", "2%-").Run()
		}
		if user_args[0] == "mute" {
			// exec.Command("pactl", "set-sink-mute", "@DEFAULT_SINK@", "toggle").Run()
			exec.Command("wpctl", "set-mute", "@DEFAULT_AUDIO_SINK@", "toggle").Run()
			isMute()
		}
		if user_args[0] == "update" {
			isMute()
		}
		update()
	}
}

func update() {
	// cmd, _ := exec.Command("pactl", "get-sink-volume", "@DEFAULT_SINK@").Output()
	cmd, _ := exec.Command("wpctl", "get-volume", "@DEFAULT_AUDIO_SINK@").Output()

	// field := strings.Fields(string(cmd))
	field := strings.Split(string(cmd), " ")
	// string_value := strings.ReplaceAll(field[4], "%", "")
	value, err := strconv.ParseFloat(strings.Replace(field[1], "\n", "", -1), 16)
	if err != nil {
		fmt.Println(err)
	}

	fmt.Println(value * 100)
	exec.Command("eww", "update", fmt.Sprintf("volume_level=%v", (value*100))).Run()
}

func isMute() {
	// cmd_mute, _ := exec.Command("pactl", "get-sink-mute", "@DEFAULT_SINK@").Output()
	cmd_mute, _ := exec.Command("wpctl", "get-volume", "@DEFAULT_AUDIO_SINK@").Output()
	// string := strings.Fields(string(cmd_mute))[1]
	string := strings.Contains(string(cmd_mute), "MUTED")
	if string == false {
		// icon := "󰕾"
		icon := ""
		// icon := "󰓃"
		// icon := os.Args[1]
		exec.Command("eww", "update", fmt.Sprintf("volume_icon=%v", icon)).Run()
	} else {
		// icon := "󰖁"
		icon := ""
		// icon := "󰓄"
		// icon := os.Args[1]
		exec.Command("eww", "update", fmt.Sprintf("volume_icon=%v", icon)).Run()
	}
}
