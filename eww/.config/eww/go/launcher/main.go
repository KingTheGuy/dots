package main

import (
	"fmt"
	"os"
	"os/exec"
	"strings"
)

const style = "(eventbox :class 'container' :onclick 'eww close launcher && exec nohup $item &' (box :class 'launcher_item' '$item'))"
const container = `
(box
:orientation 'v'
:space-evenly false
:spacing {spacing_sub/2}
:class 'main'
$$
)
`

func main() {
	args := os.Args

	paths := os.Getenv("PATH")
	path_field := strings.SplitN(paths, ":", -1)

	var apps []string
	for _, path := range path_field {
		ls, _ := exec.Command("ls", path).Output()
		fields := strings.SplitN(strings.TrimSpace(string(ls)), "\n", -1)
		for _, app := range fields {
			apps = append(apps, app)
		}

	}

	if len(args) >= 2 {
		if args[1] == ":h" {
			fmt.Println("so now we show help")

		}
	}

	var formated_apps string
	formated_apps = fmt.Sprintf("(box %s)", context([]string{"commands", "files", "discord", "noti"}))
	max_entries := 10
	for _, app := range apps {
		if max_entries <= 0 {
			break
		}
		//NOTE: this is after :r
		if len(args) >= 3 {
			if strings.Contains(app, args[2]) {
				formated_apps = fmt.Sprintf("%s%s", formated_apps, strings.Replace(style, "$item", app, -1))
				max_entries--
			}
		} else {
			formated_apps = fmt.Sprintf("%s%s", formated_apps, strings.Replace(style, "$item", app, -1))
			max_entries--
		}
	}

	formated := strings.Replace(container, "$$", formated_apps, 1)
	exec.Command("eww", "update", fmt.Sprintf("content=%s", formated)).Run()
}

func context(items []string) string {

	var all_items string
	for _, item := range items {
		formated := fmt.Sprintf("(box :class 'base' '%s')", item)
		all_items = fmt.Sprintf("%s%s", all_items, formated)
	}
	return all_items

}

func formatItems() {

}
