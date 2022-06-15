package main

import (
	"fmt"
)

func main() {
	fmt.Print("Input foot number without whitespaces: ")
	var input float64
	fmt.Scanf("%f", &input)
	output, err := convert(input)

	if err == nil {
		fmt.Printf("%f  in meters\n", output)
	} else {
		fmt.Println(err)
	}

}

func convert(foot float64) (met float64, err error) {
	if foot > 0 {
		met = foot * 0.3048
		return met, nil
	} else {
		err = fmt.Errorf("foot must be greater than 0 and a number")
		return 0, err
	}
}
