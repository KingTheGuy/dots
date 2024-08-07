// TODO: if the device is mutted have it it cross the name
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
	cmd, err := exec.Command("wpctl", "status", "-nk").Output()
	if err != nil {
		fmt.Println("welp, we hit a wall")
	}
	fields := strings.Split(string(cmd), "\n")
	//need "Audio"
	//then need "Sinks"
	sec_audio := false
	sec_sinks := false

	var need_parse []string
	for _, new_line := range fields {
		line := strings.TrimSpace(strings.Replace(new_line, "│", "", -1))
		// fmt.Println(line)
		if sec_audio == false {
			if strings.Contains(line, "Audio") {
				sec_audio = true
			}
		}
		if sec_sinks == false {
			if sec_audio == true {
				if strings.Contains(strings.ToUpper(line), look_for) {
					sec_sinks = true
					continue
				}
			}
		}

		if sec_audio == true && sec_sinks == true {
			if line == "" {
				break
			}
			need_parse = append(need_parse, line)
			// fmt.Println(line)
		} else {
			continue
		}
	}
	//need_parse find first number then "["
	//get all chars between
	//now we have the id and name
	//then map those two value and ALL DONE
	var active_device string
	for _, to_parse := range need_parse {
		// fmt.Println(to_parse)
		// TODO: get the index of vol, remove it and parse the rest WAIT!
		// FIXME: i can use this to get if its muted or not..
		is_active := false
		start := false
		var device string
		for x := 0; x < len(to_parse); x++ {
			_, ok := strconv.Atoi(string(to_parse[x]))
			if strings.Contains(string(to_parse[x]), "[") {
				start = false
				if is_active == true {
					is_active = false
					active_device = device
				}
				break
			}
			if string(to_parse[x]) == "*" {
				// fmt.Print("* \t")
				is_active = true
			}
			if ok == nil {
				start = true
			}
			if start == true {
				device = fmt.Sprintf("%s%s", device, string(to_parse[x]))
			}
			// fmt.Printf("char: %v", string(to_parse[x]))
		}
		// fmt.Printf("this device: %s\n", device)
		// fmt.Println(device)
		found_device := strings.Split(device, ".")
		device_id, _ := strconv.Atoi(found_device[0])
		sinks[device_id] = strings.TrimSpace(found_device[1])
	}

	// to_sort := make([]int, 0, len(sinks))

	// for k := range sinks {
	// 	to_sort = append(to_sort, k)
	// }
	// sort.Ints(to_sort)
	// for _, k := range to_sort {

	// }

	var to_print string

	device_type := strings.ToLower(look_for)
	style, _ := exec.Command("eww", "get", fmt.Sprintf("%s_style", device_type)).Output()
	for id, device := range sinks {
		// fmt.Printf("device: %v %s\n", id, device)
		// to_print = fmt.Sprintf(`%s (eventbox :onclick "wpctl set-default %v" :class "audio_sink" "%s" )`, to_print, id, device)
		new_id := strconv.Itoa(id)
		formatted_style := strings.Replace(string(style), "%v", new_id, 1)
		formatted_style = strings.Replace(formatted_style, "%s", device, 1)
		if strings.Contains(active_device, device) {
			// formatted_style = strings.Replace(formatted_style, "audio_sink", "audio_sink_active", 1)
			formatted_style = strings.Replace(formatted_style, fmt.Sprintf("audio_%s", device_type), fmt.Sprintf("audio_%s_active", device_type), 1)
			to_print = fmt.Sprintf(`%s%s`, strings.TrimSpace(formatted_style), to_print)
			continue
		}
		to_print = fmt.Sprintf(`%s%s`, to_print, strings.TrimSpace(formatted_style))
	}
	style_container, _ := exec.Command("eww", "get", fmt.Sprintf("%s_style_container", device_type)).Output()

	//TODO: check if the sink is active
	//if not then remove the class

	// style_container = strings.Replace(string(style_container),"audio_sink","audio_sink_active",1)
	fmt.Println(strings.TrimSpace(strings.Replace(string(style_container), "%s", to_print, 1)))

	// reload, _ := exec.Command("./$HOME/.config/eww/go/sink/main").Output()
	// exec.Command("eww", "update", fmt.Sprintf("loaded_sinks='%s'", string(reload))).Run()
	// fmt.Println(string(reload))
	// fmt.Printf("(box :orientation 'v' %s)", to_print)
	// fmt.Printf("thse are the devies: %s", dumpArray(need_parse))
}

func dumpArray(array []string) string {
	var to_dump string
	for _, value := range array {
		to_dump = fmt.Sprintf("%s\n->> %s", to_dump, value)
	}
	return to_dump
}
