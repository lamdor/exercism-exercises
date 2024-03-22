package letter

import (
	"sync"
)

// FreqMap records the frequency of each rune in a given text.
type FreqMap map[rune]int

// Frequency counts the frequency of each rune in a given text and returns this
// data as a FreqMap.
func Frequency(text string) FreqMap {
	frequencies := FreqMap{}
	for _, r := range text {
		frequencies[r]++
	}
	return frequencies
}

func (frequencies FreqMap) keys() (result []rune) {
	for k := range frequencies {
		result = append(result, k)
	}
	return result
}

func (fm1 FreqMap) merge(fm2 FreqMap) (result FreqMap) {
	result = FreqMap{}
	allKeys := append(fm1.keys(), fm2.keys()...)
	for _, r := range allKeys {

		val1 := 0
		if val, ok := fm1[r]; ok {
			val1 = val
		}

		val2 := 0
		if val, ok := fm2[r]; ok {
			val2 = val
		}

		result[r] = val1 + val2
	}
	return result
}

// ConcurrentFrequency counts the frequency of each rune in the given strings,
// by making use of concurrency.
func ConcurrentFrequencyWaitGroup(texts []string) (result FreqMap) {
	var wg sync.WaitGroup
	var results = make([]FreqMap, len(texts))
	for i, text := range texts {
		wg.Add(1)
		go func(i int, text string) {
			results[i] = Frequency(text)
			wg.Done()
		}(i, text)
	}
	wg.Wait()
	for _, r := range results {
		result = result.merge(r)
	}
	return result
}

func ConcurrentFrequencyChannel(texts []string) FreqMap {
	freqs := make(chan FreqMap, len(texts))
	results := FreqMap{}

	// map
	for _, t := range texts {
		go func(t string) { freqs <- Frequency(t) }(t)
	}

	// reduce
	for range texts {
		for r, c := range <-freqs {
			results[r] += c
		}
	}

	return results
}

func ConcurrentFrequency(texts []string) FreqMap {
	return ConcurrentFrequencyChannel(texts)
}
