package main

import (
	// "fmt"
	"fmt"
	"os"
	"os/exec"
	"strings"
)

//This was so annoying to get done, so many issues and most of it came from converting from an int to a string and vise versa
//hope this scripts does not break again

func main() {
	file := "/tmp/mic_id"
	var id string
	get_id, err := os.ReadFile(file)
	if err != nil {
		cmd, _ := exec.Command("wpctl", "status").Output()
		new_string := strings.Split(string(cmd), "\n")
		var fields []string
		for _, i := range new_string {
			// strings.ReplaceAll(i, "│", "")
			if strings.Contains(i, "Meteor condenser microphone Analog Stereo") {
				fields = append(fields, i)
			}
		}
		fmt.Println(fields[len(fields)-1])
		for _, v := range strings.Fields(fields[len(fields)-1]) {
			if strings.Contains(v, ".") {
				v = strings.Replace(v, ".", "", -1) //remove "."
				// if value, ok := strconv.Atoi(v); ok == nil { //chcek if its a number
				id = v
				break
				// }
				// fmt.Println(v)

			}
		}
		// fmt.Printf("id is: %v\n", string(id))
		err := os.WriteFile("/tmp/mic_id", []byte(string(id)), 0777)
		if err != nil {
			fmt.Println("something broke")
		}
	} else {
		// number, err := strconv.Atoi(string(get_id))
		// if err != nil {
		// 	fmt.Println("something broke")
		// 	return
		id = string(get_id)
		// }
		// fmt.Println("found id in file: %v", id)
	}
	cmd_err := exec.Command("wpctl", "set-mute", string(id), "toggle").Run()
	if cmd_err != nil {
		os.Remove(file)
	}
	// fmt.Println(id)
}
