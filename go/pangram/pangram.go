package pangram

import "unicode"

func addUnlessContained(cs []rune, c rune) []rune {
	var found bool
	for _, v := range cs {
		if v == c {
			found = true
		}
	}
	if !found {
		return append(cs, c)
	} else {
		return cs
	}
}

func IsPangram(input string) bool {
	var letters []rune
	for _, c := range input {
		if c >= 'a' && c <= 'z' {
			letters = addUnlessContained(letters, c)
		} else if c >= 'A' && c <= 'Z' {
			letters = addUnlessContained(letters, unicode.ToLower(c))
		}
	}
	return len(letters) == 26
}
