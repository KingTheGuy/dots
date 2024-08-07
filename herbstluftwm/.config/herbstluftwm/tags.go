package main

import (
	"fmt"
	"os/exec"
	"strings"
)

const (
	LEFT       = 9
	START      = 2
	TAG_STATUS = ""
)

var ICONS = []string{"01", "02", "03", "04", "05", "06", "07", "08", "09"}

// var ICONS = []string{"I", "II", "III", "IV", "V", "VI", "VII", "VIII", "IX"}

func main() {
	tags, err := exec.Command("herbstclient", "tag_status").Output()
	if err != nil {
		fmt.Println("##")
	}
	fields := strings.Fields(string(tags))
	for i, v := range fields {
		if strings.Contains(v, "#") {
			fmt.Println(ICONS[i])
		}
	}
}
