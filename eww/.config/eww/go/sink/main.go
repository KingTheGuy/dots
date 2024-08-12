// see output of 'wpctl status -nk' to have a better understanding of what is happeining

package main

import (
	"fmt"
	"os"
	"os/exec"
	"strconv"
	"strings"
)

var look_for = strings.ToUpper(os.Args[1])

func main() {
	sinks := make(map[int]string)
	output, err := exec.Command("wpctl", "status", "-nk").Output()
	if err != nil {
		fmt.Println("welp, we hit a wall")
	}
	fields := strings.Split(string(output), "\n")
	//need "Audio"
	//then need "Sinks"
	section_audio := false
	section_sinks := false

	var need_parse []string
	for _, new_line := range fields {
		line := strings.TrimSpace(strings.Replace(new_line, "│", "", -1))

		// find the audio section
		if section_audio == false {
			if strings.Contains(line, "Audio") {
				section_audio = true
			}
		}
		// find sub_section sinks
		if section_sinks == false {
			if section_audio == true {
				if strings.Contains(strings.ToUpper(line), look_for) {
					section_sinks = true
					continue
				}
			}
		}

		// now within audio and sinks section
		if section_audio == true && section_sinks == true {
			if line == "" { //end of section
				break
			}
			need_parse = append(need_parse, line)
		} else {
			continue //why do i have this continue here? idk
		}
	}

	var active_device string //keep track of the active device

	// do some clean up
	for _, parsing := range need_parse {
		// fmt.Println(to_parse)
		// TODO: get the index of vol, remove it and parse the rest WAIT!
		// FIXME: i can use this to get if its muted or not..
		is_active := false
		start := false
		var device string
		for x := 0; x < len(parsing); x++ {
			_, ok := strconv.Atoi(string(parsing[x]))
			if strings.Contains(string(parsing[x]), "[") {
				start = false
				if is_active == true {
					is_active = false
					active_device = device
				}
				break
			}
			if string(parsing[x]) == "*" {
				is_active = true
			}
			if ok == nil {
				start = true
			}
			if start == true {
				device = fmt.Sprintf("%s%s", device, string(parsing[x]))
			}
		}

		found_device := strings.Split(device, ".")
		device_id, _ := strconv.Atoi(found_device[0])
		sinks[device_id] = strings.TrimSpace(found_device[1])
	}

	var to_print string

	device_type := strings.ToLower(look_for)
	style, _ := exec.Command("eww", "get", fmt.Sprintf("%s_style", device_type)).Output()

	// format for use in eww
	for id, device := range sinks {
		new_id := strconv.Itoa(id)
		formatted_style := strings.Replace(string(style), "%v", new_id, 1)
		formatted_style = strings.Replace(formatted_style, "%s", device, 1)
		if strings.Contains(active_device, device) {
			formatted_style = strings.Replace(formatted_style, fmt.Sprintf("audio_%s", device_type), fmt.Sprintf("audio_%s_active", device_type), 1)
			to_print = fmt.Sprintf(`%s%s`, strings.TrimSpace(formatted_style), to_print)
			continue
		}
		to_print = fmt.Sprintf(`%s%s`, to_print, strings.TrimSpace(formatted_style))
	}
	style_container, _ := exec.Command("eww", "get", fmt.Sprintf("%s_style_container", device_type)).Output()

	fmt.Println(strings.TrimSpace(strings.Replace(string(style_container), "%s", to_print, 1)))

}

func dumpArray(array []string) string {
	var to_dump string
	for _, value := range array {
		to_dump = fmt.Sprintf("%s\n->> %s", to_dump, value)
	}
	return to_dump
}
