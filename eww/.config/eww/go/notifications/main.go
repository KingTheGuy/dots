package main

import (
	"bufio"
	"fmt"
	"os/exec"
)

func main() {
	cmd := exec.Command("dbus-monitor", "destination=org.freedesktop.Notifications")
	stdout, err := cmd.StderrPipe()
	if err != nil {
		fmt.Println(err)
	}
	if err := cmd.Start(); err != nil {
		fmt.Println("err", err)
		return
	}
	scanner := bufio.NewScanner(stdout)
	for scanner.Scan() {
		fmt.Println(scanner.Text())
	}

	if err := scanner.Err(); err != nil {
		fmt.Println("Error reading from stdout pipe:", err)
		return
	}

	// Wait for the command to finish
	if err := cmd.Wait(); err != nil {
		fmt.Println("Error waiting for command:", err)
		return
	}
}
