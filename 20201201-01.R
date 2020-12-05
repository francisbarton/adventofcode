# Day 1, Puzzle 1

input <- as.numeric(readLines("day1_input"))

a <- `-`(2020, input)
b <- intersect(a, input)
sum(b) # check 2020
b[1]*b[2] # answer = 988771

