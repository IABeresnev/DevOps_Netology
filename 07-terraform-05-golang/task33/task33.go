package main

import (
	"fmt"
	//	"strconv"
)

func main() {
	showMe := findDel(1, 100, 3)
	fmt.Println(showMe)
}

func findDel(start int, end int, del int) (rez []int) {
	for i := start; i <= end; i++ {
		if i%del == 0 {
			rez = append(rez, i)
		}
	}
	return rez
}
