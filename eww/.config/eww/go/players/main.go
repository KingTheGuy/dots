package main

import (
	"fmt"
	"os/exec"
	"strings"
)

// TODO: split the player widget. so that all players have their own view. (to prevent this shit show)

func main() {
	cmd, _ := exec.Command("playerctl", "-l").Output()

	players := strings.Fields(string(cmd))
	for p, _ := range players {
		fmt.Println(players[p])

		cmd, _ := exec.Command("playerctl", "-p", players[p], "metadata").Output()
		fmt.Println(string(cmd))
	}
}
