package main

import (
	"encoding/json"
	"fmt"
	"os"
)

type Noti struct {
	Name      string `json:"name"`
	Msg       string `json:"msg"`
	Timestamp int    `json:"timestamp"`
	Id        int    `json:"id"`
}

func main() {
	// json.RawMessage, _ := exec.Command("dunstctl", "history").Output()
	// output, _ := exec.Command(string(raw), "|", "jq", "-c", "[. | {name:.data.[].[$num].appname.data, msg:.data.[].[$num].message.data, time:.data.[].[$num].timestamp.data}]").Output()

	// style, _ := exec.Command("eww", "get", "style_notification_item").Output()

	raw := os.Args[1]

	jsonData := []byte(raw)

	var notfication []Noti

	err := json.Unmarshal(jsonData, &notfication)
	if err != nil {
		fmt.Println("Error: ", err)
	}

	for _, v := range notfication {
		fmt.Println(v.Msg)
	}

	// var all_noti string
	// for _, v := range notfication {
	// 	styled := strings.Replace(string(style), "THIS_ID")

	// }

	// fmt.Println("name:", notfication[0].Name)
	// fmt.Println("msg:", notfication[0].Msg)
	// fmt.Println("timestamp:", notfication[0].Timestamp)
	// split := strings.Split(raw, "},{")

	// for _, v := range split {
	// 	fmt.Println(v)

	// }

}
