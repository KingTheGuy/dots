package main

import (
	"fmt"
	"os/exec"
	"strings"
)

var real_devices []deviceType

type deviceType struct {
	device_type string
	device_name string
	raw_name    string
}

func (d deviceType) newDevice() {
	d.device_name = "generic"
	d.device_type = "something"
}

func main() {
	fmt.Println("Audio Devices are:")
	listDevices()
	fmt.Printf("there are %v devices\n", len(real_devices))
	for _, v := range real_devices {
		fmt.Printf("TYPE: %v & NAME: %v == RAW: %v\n", v.device_type, v.device_name, v.raw_name)
	}

}
func listDevices() {
	value, _ := exec.Command("pactl", "list", "sinks").Output()
	raw_devices := strings.SplitN(string(value), "Sink #", -1)

	// fmt.Printf("there should be %v entries\n", len(raw_devices))

	getMaxDepthTwo := func(line string) string {
		line = strings.ReplaceAll(line, "\"", "")
		array := strings.Fields(line)[2:] //skip the first string
		if len(array) > 1 {
			return fmt.Sprintf("%s %s", array[0], array[1])
		}
		return fmt.Sprintf(array[0])
	}

	for _, v := range raw_devices {
		new_device := new(deviceType)
		new_device.newDevice()
		//FIXME: i fucked up prety hard, ive been checking if the same
		//line contains something from another line which will not be the case
		//should be checking the entire string to see if it has the what im looking for or no
		//basically should be using the index to to then get the lines that i want
		findline := func(find string) string {
			for _, l := range strings.Split(v, "\n") {
				if strings.Contains(l, find) {
					return l
				}
			}
			return ""
		}

		//deice raw name
		{
			line := findline("Name: ")
			if line == "" {
				continue
			}
			split := strings.Split(line, "Name: ")
			new_device.raw_name = split[1]
		}

		//device type
		line := findline("type: ")
		if line == "" {
			continue
		}
		split := strings.Split(line, "type: ")
		split = strings.Fields(split[1])
		cleaned := strings.ReplaceAll(split[0], ",", "")
		new_device.device_type = strings.ToUpper(cleaned)

		//device name
		if strings.Contains(v, "device.description =") {
			line := findline("device.description =")
			if strings.Contains(v, "node.nick =") {
				line := findline("node.nick =")
				if !strings.Contains(line, "Analog") {
					if !strings.Contains(line, "Mic") {
						new_device.device_name = getMaxDepthTwo(line)
						real_devices = append(real_devices, *new_device)
						continue
					}
				}
			}
			new_device.device_name = getMaxDepthTwo(line)
		}
		real_devices = append(real_devices, *new_device)
	}
}
