package main

import (
	"encoding/json"
	"fmt"
	"os"
	"os/exec"
	"strings"
)

//get each line, example: - [ ] blah blah
//return the line number and text

const style string = `(box (eventbox :onclick "notify-send '$'")(box '$$'))`

type data_format struct {
	data_line int
	data_text string
}

func (d data_format) toString() string {
	return fmt.Sprintf(`{"data_line":"%v","data_text":"%s"}`, d.data_line, d.data_text)
}

func main() {
	fmt.Println("This should show all my current notes/todo in eww")

	data := getContextFromFile("/home/olrak/Documents/notes/TODO.md")

	var full_notes []string
	for line, text := range strings.Split(data, "\n") {
		// format := strings.Replace(style, "$", "l", 1)
		// format = strings.Replace(format, "$$", text, 1)
		text = strings.Replace(text, "\"", "\\'", -1)
		if !strings.Contains(text, "- [") {
			continue
		}
		format := data_format{
			data_line: line,
			data_text: text,
		}

		full_notes = append(full_notes, format.toString())
	}

	json, err := json.Marshal(full_notes)
	if err != nil {

	}
	exec.Command("eww", "update", fmt.Sprintf("notes=%s", string(json))).Run()
	// fmt.Println(string(jsonData))
	// fmt.Println(json[0])

}

func getContextFromFile(file string) string {
	// data, err := exec.Command(file).Output()
	data, err := os.ReadFile(file)
	if err != nil {
		return "error"
	}
	return string(data)
}
