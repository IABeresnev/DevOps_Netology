package main

import (
	"testing"

	"github.com/stretchr/testify/assert"
)

func TestFindDel(t *testing.T) {
	assert := assert.New(t)
	r := []int{3, 6, 9, 12, 15, 18, 21, 24, 27, 30, 33, 36, 39, 42, 45, 48, 51, 54, 57, 60, 63, 66, 69, 72, 75, 78, 81, 84, 87, 90, 93, 96, 99}
	assert.Equal(findDel(1, 100, 3), r)
	r = []int{15, 30, 45, 60, 75, 90}
	assert.Equal(findDel(1, 100, 15), r)
}
