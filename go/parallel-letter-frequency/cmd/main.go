package main

import (
	"fmt"
	"letter"
)

func main() {
	test := "abcdefabcde"

	freqs := letter.Frequency(test)
	fmt.Printf("OriginalFrequency: %d\n", freqs)

	freqs2 := letter.ConcurrentFrequency([]string{test})
	fmt.Printf("ConcurrentFrequency: %d\n", freqs2)
}
