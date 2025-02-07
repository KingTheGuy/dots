package main

import (
	"fmt"
	"io/ioutil"
	"log"
	"os"
	"os/exec"

	// "os/exec"
	"strings"
)

// get all widgets
// output then and have them return a string when clicked
// the string will be the name of the widget, whicih will then
// be set as widget in the selected empty space

var found_widgets []string
var found_yucks []string

func main() {
	home, err := os.UserHomeDir()
	if err != nil {
		log.Fatal(err)
	}

	files, err := ioutil.ReadDir(home + "/.config/eww/")
	if err != nil {
		log.Fatal(err)
	}

	//GOT the files
	for _, file := range files {
		// fmt.Println(file.Name(), file.IsDir())
		if file.IsDir() == false {
			// if strings.Contains(file.Name(), ".yuck") {
			if strings.HasSuffix(file.Name(), ".yuck") {
				found_yucks = append(found_yucks, file.Name())

			}
		}
	}
	//get widgets from files
	for _, file := range found_yucks {
		this, err := ioutil.ReadFile(home + "/.config/eww/" + file)
		if err != nil {
			log.Fatal(err)
		}
		splits := strings.Split(string(this), "\n")
		for _, line := range splits {
			if strings.Contains(line, "defwidget") {
				if strings.HasPrefix(line, ";") {
					continue
				}
				new_split := strings.Split(line, "(defwidget")
				another_split := strings.Split(new_split[1], "[")
				// fmt.Println(new_split[1])
				clean := strings.TrimSpace(strings.Replace(another_split[0], "[]", "", -1))
				found_widgets = append(found_widgets, clean)
				// fmt.Println(clean)
			}
		}

		// fmt.Println(string(this))
		// widget := strings.Replace(file.Name(), ".yuck", "", -1)
		// found_widgets = append(found_widgets, widget)
	}

	var formatted_widgets string
	slot_id, _ := exec.Command("eww", "get", "slot_id").Output()
	for i, v := range found_widgets {
		formatted_widgets = fmt.Sprintf(`%s(eventbox :class "canvas" :onclick "eww update %s='(%s)'" (box :space-evenly false :orientation "v" "%s" (%s)))`, slot_id, formatted_widgets, v, v, v)
		if i == 20 {
			break
		}
	}

	widget_container, _ := exec.Command("eww", "get", "style_widgets").Output()
	to_set := strings.Replace(string(widget_container), "HERE", strings.TrimSpace(formatted_widgets), -1)
	exec.Command("eww", "update", fmt.Sprintf("loaded_widgets='%s'", strings.TrimSpace(to_set))).Run()
	// exec.Command("eww", "update", fmt.Sprintf("loaded_widgets='%s'", strings.TrimSpace(formatted_widgets))).Run()
	// fmt.Print(strings.TrimSpace(formatted_widgets))
	fmt.Print(to_set)
	// widget_container

	//guess it would have to be all files ending with .yuck

	// os.OpenFile("%HOME/.confg/eww/eww.yuck")
}
