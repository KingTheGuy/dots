package main

import (
	"fmt"
	"math"
	"os"
	"os/exec"
	"strconv"
	"strings"
)

const brightness_path = "/sys/class/backlight/intel_backlight/brightness"
const max_brightness_path = "/sys/class/backlight/intel_backlight/max_brightness"

func main() {
	c_light := getValue(brightness_path)
	m_light := getValue(max_brightness_path)

	// fmt.Println(c_light)
	// fmt.Println(m_light)

	level := 10

	args := os.Args[1:]
	if len(args) > 0 {
		if args[0] == "up" {
			new_level := []byte(fmt.Sprint(c_light + level))
			err := os.WriteFile(brightness_path, new_level, 0644)
			if err != nil {
				fmt.Println(err)
			}
		}
		if args[0] == "down" {
			new_level := []byte(fmt.Sprint(c_light - level))
			err := os.WriteFile(brightness_path, new_level, 0644)
			if err != nil {
				fmt.Println(err)
			}
		}
		if args[0] == "redshift" {
			if len(args) > 1 {
				if args[1] == "dark" {
				}
			}

		}
	}
	// light_level := (m_light / 100) + c_light
	devide := float64(c_light) / float64(m_light)
	light_level := math.Round(devide * 100)
	// fmt.Printf("maths [%v]\n", light_level)
	exec.Command("eww", "update", fmt.Sprintf("light_level=%v", light_level)).Start()
	// fmt.Println(c_light)
	// fmt.Println(m_light)
}

func getValue(device string) int {
	file, _ := os.ReadFile(device)
	int_file, _ := strconv.Atoi(strings.TrimSpace(string(file)))
	return int_file
}

// func redshift() {
// 	err := os.WriteFile("/tmp/redshift").Error()
// 	fmt.Println(err)

// }
