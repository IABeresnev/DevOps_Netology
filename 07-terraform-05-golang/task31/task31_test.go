package main

import (
	"testing"

	"github.com/stretchr/testify/assert"
)

func TestConvert(t *testing.T) {
	res, err := convert(5)
	assert.Equal(t, res, 1.524)
	assert.Equal(t, err, nil)
	res, err = convert(11.3)
	assert.Equal(t, res, 3.44424)
	assert.Equal(t, err, nil)
	res, err = convert(0)
	assert.Equal(t, res, 0.0)
	assert.EqualError(t, err, "foot must be greater than 0 and a number")
}
