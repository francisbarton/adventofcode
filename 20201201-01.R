# Day 1, Puzzle 1

input <- as.numeric(readLines("day1_input"))

a <- `-`(2020, input)
b <- intersect(a, input)

sum(b) # check 2020
prod(b) # answer = 988771


