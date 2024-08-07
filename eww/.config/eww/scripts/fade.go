package main

import (
	"fmt"
	"os"
	"os/exec"
	"time"
)

const eww = "/home/boots/STUFF/eww/target/release/eww"

func main() {
	if os.Args[1] == "true" {
		exec.Command(eww, "update", "reveal_var=false").Start()
		time.Sleep(200)
		exec.Command(eww, "update", "toggle_date_time=false").Start()
		exec.Command(eww, "update", "reveal_var=true").Start()
	} else if os.Args[1] == "false" {
		exec.Command(eww, "update", "reveal_var=false").Start()
		time.Sleep(400)
		exec.Command(eww, "update", "toggle_date_time=true").Start()
		exec.Command(eww, "update", "reveal_var=true").Start()
	}
	fmt.Println("fade ran")
}
