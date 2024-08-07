package main

import (
	"fmt"
	"os"
	"os/exec"
	"strconv"
	"strings"
	"time"
)

// TODO: this should just return the new tick..

// FIXME: need to rely less on the bar
//if it restarts some important variables change..
//should have them be read/listeined from a file
//that way if it crashes it can come back up
//and read the last state if need be

const (
	s = 1
	m = 60
	h = 3600
)

var EWW string

// var ICON = "󱤣"
var ICON = ""
var TIME int

func main() {
	the_args := os.Args[1:]
	if len(the_args) == 0 {
		fmt.Println("No time sepecified..")
		return
	}
	EWW = the_args[0]

	remove_letter := func(value string, removed string) int {
		value = strings.ReplaceAll(value, removed, "")
		new_value, _ := strconv.Atoi(value)
		return new_value
	}
	for _, v := range the_args {
		if strings.Contains(v, "h") {
			TIME = TIME + remove_letter(v, "h")*h
			break
		}
		if strings.Contains(v, "s") {
			TIME = TIME + remove_letter(v, "s")
			break
		}
		if strings.Contains(v, "m") {
			TIME = TIME + remove_letter(v, "m")*m
			break
		}
		TIME = TIME + remove_letter(v, "s")*m

	}
	// fmt.Println(timeFormat(TIME))

	fmt.Printf("time given: [%s]\n", the_args[1])
	if len(the_args) < 3 {
		//check if start was passed
		fmt.Println("end to also supply 'start'")
		return
	}
	if the_args[1] == "0" {
		fmt.Println("No time sepecified..")
		return
	}
	if TIME == 0 {
		fmt.Println("ZERO")
		return
	}
	if the_args[2] != "start" {
		// cancel := fmt.Sprintf("CA\nNC\nEL\n%s", ICON)
		// exec.Command(EWW, "update", fmt.Sprintf("clock_timer_display=%s", cancel)).Run()
		fmt.Printf("Cancel? %s\n", timeFormat(TIME))
		exec.Command("pkill", "timer").Run()
		//do not start timer
		return
	}
	// fmt.Println("is_running")
	fmt.Println("Starting Timer..")

	exec.Command(EWW, "update", "timer_running=true").Run()
	for range time.Tick(time.Second) {
		TIME--
		// exec.Command(EWW, "update", fmt.Sprintf("clock_timer_display=%s", timeFormat(TIME))).Run()
		// fmt.Println(timeFormat(TIME))
		updateTimeLeft(TIME)
		// exec.Command("/home/boots/STUFF/eww/target/release/eww", "update", fmt.Sprintf("time_left=%v", TIME)).Run()
		if len(the_args) >= 4 {
			if the_args[3] == "big" {
				cmd, _ := exec.Command("figlet", fmt.Sprint(timeFormat(TIME))).Output()
				tui(string(cmd))
			}
		}
		fmt.Println(timeFormat(TIME))
		// fmt.Println(TIME)
		if TIME <= 0 {
			fmt.Println("is this working?")
			exec.Command("pkill", "mpv").Run()
			exec.Command("playerctl", "pause").Run()
			if len(the_args) >= 4 {
				if the_args[3] == "big" {
					huh, _ := exec.Command("figlet", "TIMER DONE").Output()
					tui(string(huh))
				}
			}
			done := exec.Command("mpv", "--no-video", "--loop", "scripts/sound_picker_track_6.ogg")
			err := done.Start()
			if err != nil {
				fmt.Println(err)
			}
			exec.Command("notify-send", "-t", "600000", "-A", "TIMER", "TIMER DONE").Run()
			done.Process.Kill()
			// exec.Command(EWW, "update", "timer_running=false").Run()
			// exec.Command(EWW, "update", "clock_timer_left=0").Run()
			return
		}
	}
}

func updateTimeLeft(time int) {
	huh := []byte(fmt.Sprint(time))
	os.WriteFile("/tmp/time_left", huh, 0644)
	exec.Command(EWW, "update", fmt.Sprintf("we_time=%v", timeFormat(time))).Run()
}

func timeFormat(time_remaining int) string {
	hour := 0
	minute := 0
	second := 0
	if time_remaining >= h {
		hour = time_remaining / h
	}
	if time_remaining >= m {
		minute = (time_remaining / m) % 60
	}
	if time_remaining >= s {
		second = time_remaining % 60

	}

	// return fmt.Sprintf("%02d:%02d:%02d", hour, minute, second)
	return fmt.Sprintf("%02d\n%02d\n%02d\n", hour, minute, second)
	// return "1:50:30"

	if hour != 0 {
		return fmt.Sprintf("%0dh %0dm %0ds", hour, minute, second)

	}
	if minute != 0 {
		return fmt.Sprintf("%0dm %0ds", minute, second)

	}
	return fmt.Sprintf("%0ds", second)
}

func tui(v string) {
	cmd := exec.Command("clear")
	cmd.Stdout = os.Stdout
	cmd.Run()
	fmt.Println("TIME:")
	fmt.Println(v)
}
