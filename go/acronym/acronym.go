// Package acronym should have a package comment that summarizes what it's about.
// https://golang.org/doc/effective_go.html#commentary
package acronym

import (
	"regexp"
	"strings"
)

var splitPattern = regexp.MustCompile("[ _-]+")

// Abbreviate should convert a phrase to its acronym.
func Abbreviate(s string) (acronym string) {
	words := splitPattern.Split(s, -1)
	for _, v := range words {
		firstLetter := string(v[0])
		acronym += strings.ToUpper(firstLetter)
	}
	return acronym
}
