package main

import (
	"encoding/json"
	"fmt"
	"os/exec"
	"strings"
)

// TODO: split the player widget. so that all players have their own view. (to prevent this shit show)

func main() {
	cmd, _ := exec.Command("playerctl", "-l").Output()

	players := strings.Fields(string(cmd))
	var players_json []map[string]interface{}
	for p := range players {
		player_name := players[p]

		cmd, _ := exec.Command("playerctl", "-p", players[p], "metadata", "title").Output()
		title := strings.TrimSpace(string(cmd))

		cmd, _ = exec.Command("playerctl", "-p", players[p], "metadata", "artist").Output()
		artist := strings.TrimSpace(string(cmd))

		cmd, _ = exec.Command("playerctl", "-p", players[p], "metadata", "mpris:artUrl").Output()
		album_art := strings.TrimSpace(string(cmd))

		cmd, _ = exec.Command("playerctl", "-p", players[p], "position", "--format", "{{ position }}").Output()
		play_pos := strings.TrimSpace(string(cmd))
		cmd, _ = exec.Command("playerctl", "-p", players[p], "metadata", "--format", "{{ mpris:length }}").Output()
		play_length := strings.TrimSpace(string(cmd))

		cmd, _ = exec.Command("playerctl", "-p", players[p], "metadata", "--format", "{{status}}").Output()
		player_status := strings.TrimSpace(string(cmd))

		player_meta := map[string]string{
			// "player":      player_name,
			"artist":      artist,
			"title":       title,
			"album_art":   album_art,
			"play_pos":    play_pos,
			"play_length": play_length,
			"status":      player_status,
		}
		player := map[string]interface{}{
			"name": player_name,
			"meta": player_meta,
		}

		// fmt.Println(string(json_string))
		players_json = append(players_json, player)

	}
	json_string, _ := json.Marshal(players_json)
	fmt.Println(string(json_string))
}
