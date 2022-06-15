package main

import (
	"github.com/stretchr/testify/assert"
	"testing"
)

func TestFindMin(t *testing.T) {
	assert := assert.New(t)
	t1 := []int{48, 96, 86, 68, 57, 82, 63, 70, 37, 34, 83, 27, 19, 97, 9, 17}
	t2 := []int{48, 96, 86, 68, 57, 2, 63, 70, 37, 34, 83, 27, 19, 97, 9, 17}
	t3 := []int{48, 96, 6, 68, 57, 82, 63, 70, 37, 34, 83, 27, 19, 97, 9, 17}
	assert.Equal(findMin(t1), 9)
	assert.Equal(findMin(t2), 4)
	assert.Equal(findMin(t3), 6)
}
