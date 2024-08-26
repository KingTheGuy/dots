package main

import (
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
			show_these(this, "exec", "default")
			// fmt.Println(styled_apps)
			// exec.Command("notify-send", "this ran..").Run()
			return
		}
		if os.Args[1] == ":p" {
			fmt.Println("looks like we want to perform some type of power thing")
			this := []string{"poweroff now", "restart"}
			show_these(this, "exec", "gaps")
			return
		} else if os.Args[1] == ":r" {
			cmd, _ := exec.Command("ls", "/bin/", "$HOME/.local/bin/").Output()
			// cmd, _ := exec.Command("ls", "$PATH").Output()
			// fmt.Println(len(os.Args))
			// fmt.Println(string(cmd))
			// return
			// fields := []string{"ok", "no"}
			// fmt.Println(string(cmd))
			fields := strings.Fields(string(cmd))

			show_these(fields, "exec", "gaps")
			fmt.Println("run a program")
			return
		}
	} else {
		return
	}

}

func show_these(fields []string, cmd_type string, var_to_update string) {
	var searched_apps_styled string
	var searched_apps_raw string
	found := 0
	first := false
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

	for _, v := range fields {
		if len(os.Args) > 2 {
			// if strings.Contains(v, os.Args[2]) {
			if strings.Contains(v, os.Args[2]) {
				searched_apps_raw = fmt.Sprintf("%s%s\n", searched_apps_raw, v)
				found++
				this_style := style
				to_print := strings.Replace(string(this_style), "item_name", v, 1)
				// to_print = strings.Replace(to_print, "eww close launcher", fmt.Sprintf("eww close launcher && exec %s", v), 1)
				to_print = strings.Replace(to_print, "eww close launcher", fmt.Sprintf("bash/run_app.sh %s", v), 1)
				if first == false {
					to_print = strings.Replace(to_print, "launcher_item_style", "launcher_item_style_active", 1)
					first = true
				}
				// else {
				// 	to_print = strings.Replace(to_print, "launcher_item_style", "launcher_item_style", 1)
				// }
				searched_apps_styled = fmt.Sprintf("%s%s", searched_apps_styled, to_print)
			} else {
				continue
			}
		} else {
			searched_apps_raw = fmt.Sprintf("%s%s", searched_apps_raw, v)
			found++
			this_style := style
			to_print := strings.Replace(string(this_style), "item_name", v, 1)
			to_print = strings.Replace(to_print, "eww close launcher", fmt.Sprintf("bash/run_app.sh %s", v), 1)
			to_print = strings.Replace(to_print, "class_name", "audio_sinks", 1)
			searched_apps_styled = fmt.Sprintf("%s%s\n", searched_apps_styled, to_print)
		}
		if found >= 10 {
			break
		}
	}
	styled_apps := fmt.Sprintf(`(box :class "sinks_section" :spacing 3 :orientation "v" %s)`, searched_apps_styled)
	fmt.Println(styled_apps)
	exec.Command("eww", "update", fmt.Sprintf("apps=%s", searched_apps_raw)).Run()
	exec.Command("eww", "update", fmt.Sprintf("%s=%s", var_to_update, styled_apps)).Run()
	// exec.Command("eww", "update", "update_query='true'").Run()

}
