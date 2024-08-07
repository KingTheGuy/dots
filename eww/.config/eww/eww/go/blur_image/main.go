package main

import (
	"fmt"
	"os/exec"
	"strings"
	"time"
)

var current_image string
var blur_image_name = "1.jpeg"

func main() {
	for range time.Tick(time.Second * 1) {
		// fmt.Println("ran")
		output, err := exec.Command("playerctl", "metadata", "mpris:artUrl").Output()
		if err != nil {
			// fmt.Println("he have and error")
		}
		if current_image != strings.Fields(string(output))[0] {
			current_image = strings.Fields(string(output))[0]
			// fmt.Println(current_image)
			image_to_blur := strings.Fields(strings.Replace(current_image, "file://", "", -1))[0]
			// fmt.Println(image_to_blur)
			// fmt.Println("new image")
			if blur_image_name == "0.jpeg" {
				blur_image_name = "1.jpeg"

			} else if blur_image_name == "1.jpeg" {
				blur_image_name = "0.jpeg"
			}
			_, err := exec.Command("convert", image_to_blur, "-filter", "Gaussian", "-blur", "0x8", blur_image_name).Output()
			if err != nil {
				// fmt.Println("error:", err)
			}

			fmt.Printf("go/blur_image/%s\n", blur_image_name)
			img_dir := fmt.Sprintf("player_blured_image='go/blur_image/%s'", blur_image_name)
			exec.Command("eww", "update", img_dir).Run()
			// exec.Command("eww", "reload").Run()

		}
	}
}
