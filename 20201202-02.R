# Day 2, Puzzle 2

library(dplyr)
library(stringr)


tibble(input = readLines("day2_input")) %>%
  mutate(pos_1 = as.numeric(str_extract(input, "^[0-9]+"))) %>%
  mutate(pos_2 = as.numeric(str_extract(input, "(?<=^[0-9]{1,2}-)[0-9]+"))) %>%
  mutate(letter = str_extract(input, "[a-z]+(?=:)")) %>%
  mutate(string = str_extract(input, "[a-z]+$")) %>%
  mutate(letters = str_extract_all(string, "[a-z]{1}")) %>%
  rowwise() %>%
  # mutate(letter_pos1 = letters[pos_1]) %>%
  filter(xor(identical(letter, letters[pos_1]), identical(letter, letters[pos_2]))) %>%
  nrow()
