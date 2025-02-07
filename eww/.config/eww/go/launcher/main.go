package main

import (
	"encoding/json"
	"fmt"
	"os"
	"os/exec"
	"strings"
)

var style string

func main() {
	sty, _ := exec.Command("eww", "get", "launcher_item_style").Output()
	style = string(sty)

	if len(os.Args) >= 1 {
		// if len(os.Args) == 1 {
		if len(os.Args) == 1 {
			fmt.Println("start screen")
			// styled_apps := fmt.Sprintf(`(box :class "sinks_section" :spacing 3 :orientation "v" (box "menu stuff"))`)
			// exec.Command("eww", "update", fmt.Sprintf("gaps=%s", styled_apps)).Run()
			this := []string{":r (run app)", ":p (power menu)"}
			show_these(this)
			// fmt.Println(styled_apps)
			// exec.Command("notify-send", "this ran..").Run()
			return
		}
		// if string(os.Args[1][0]) != ":" {
		// 	fmt.Printf("starts with: '%s'\n", string(os.Args[1][0]))
		// }
		if os.Args[1] == ":r" || string(os.Args[1][0]) != ":" {
			path := os.Getenv("PATH")
			all_paths := strings.Split(string(path), ":")
			var all_apps []string

			// too_many := 0
			for _, v := range all_paths {
				all_programs, _ := exec.Command("ls", v).Output()
				apps := strings.Fields(string(all_programs))

				for _, a := range apps {
					// too_many++
					// if too_many > 100 {
					// 	break
					// }
					all_apps = append(all_apps, a)
				}
			}
			// fmt.Printf("what we got: %s", all_paths[0])
			// cmd, _ := exec.Command("ls", "/bin/", "$HOME/.local/bin/").Output()

			show_these(all_apps)
			// fmt.Println("run a program")
			return
		} else if os.Args[1] == ":p" {
			fmt.Println("looks like we want to perform some type of power thing")
			this := []string{"poweroff now", "restart"}
			show_these(this)
			return
		}
	} else {
		return
	}

}

func show_these(fields []string) {
	// var searched_apps_styled string
	// var searched_apps_raw string
	found := 0
	// first := false
	//TODO: before applying the style, first sort depending on the index of word to query
	// var query string
	// if len(os.Args) < 2 {
	// 	query = os.Args[2]
	// } else {
	// 	query = os.Args[1]
	// }
	// var item_contains []string
	// var storted_items []string

	//add items that contain the word into list

	// for _, v := range fields {
	// 	if strings.Contains(v, query) {
	// 		item_contains = append(item_contains, v)
	// 	}
	// }
	//sort through the items
	// for _, v := range item_contains {
	// 	//sort by the len of the string

	// 	//sort by the index of the query
	// 	strings.Index(v, query)
	// }
	//
	var to_show []string

	for _, v := range fields {
		if len(os.Args) > 1 {
			// if strings.Contains(v, os.Args[2]) {
			look_at := 1
			if len(os.Args) > 2 {
				look_at = 2

			}
			if strings.Contains(v, os.Args[look_at]) {
				// searched_apps_raw = fmt.Sprintf("%s%s\n", searched_apps_raw, v)
				to_show = append(to_show, v)
				found++
				// this_style := style
				// to_print := strings.Replace(string(this_style), "item_name", v, 1)
				// to_print = strings.Replace(to_print, "eww close launcher", fmt.Sprintf("bash/run_app.sh %s", v), 1)
				// if first == false {
				// 	to_print = strings.Replace(to_print, "launcher_item_style", "launcher_item_style_active", 1)
				// 	first = true
				// }
				// else {
				// 	to_print = strings.Replace(to_print, "launcher_item_style", "launcher_item_style", 1)
				// }
				// searched_apps_styled = fmt.Sprintf("%s%s", searched_apps_styled, to_print)
			} else {
				continue
			}
		}
		if found >= 10 {
			break
		}
	}
	// styled_apps := fmt.Sprintf(`(box :class "sinks_section" :spacing 3 :orientation "v" %s)`, searched_apps_styled)
	// fmt.Println(styled_apps)

	jsonData, err := json.Marshal(to_show)
	if err != nil {
		//do nothing
	}

	fmt.Println(string(jsonData)) // Output: [1,2,3,4,5]

	exec.Command("eww", "update", fmt.Sprintf("apps=%s", string(jsonData))).Run()

	// exec.Command("eww", "update", fmt.Sprintf("apps=%s", searched_apps_raw)).Run()
	// exec.Command("eww", "update", fmt.Sprintf("%s=%s", var_to_update, styled_apps)).Run()
	// exec.Command("eww", "update", "update_query='true'").Run()

}
