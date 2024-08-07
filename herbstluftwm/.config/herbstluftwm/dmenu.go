package main

import (
	"fmt"
	"os"
	"os/exec"
	"time"
)

//the point of this program is to open dmenu or rofi
//dmenu will be the app launcher while rofi will be a
//window and opened program selector
//if dmenu_run is run, kill that and run rofi.. else vise versa

func main() {
	// fmt.Println("yo")
	cmd := exec.Command("dmenu_run")
	cmd.Start()
	id, _ := os.FindProcess(cmd.Process.Pid)
	// dmenu, _ := exec.Command("pgrep", "dmenu").Output()
	// fmt.Println(string(dmenu))
	fmt.Printf("this is its id: %v\n", id.Pid)
	time.Sleep(time.Second * 2)
	cmd.Process.Kill()
	fmt.Println("fuck")
	// if dmenu != nil {
	// 	fmt.Println("nothing")
	// 	fmt.Println(string(dmenu))
	// }

	// rofi, _ := exec.Command("pgrep", "rofi").Output()
	// fmt.Println(string(rofi))

}

// echo $(pgrep dmenu >/dev/null)
// dmenu_run
// sleep 1
// DMENU=$(pgrep dmenu)
// if [["$DMENU" == "0"]]; then
//   echo yes
// fi
