# Day 2, Puzzle 1

library(dplyr)
library(stringr)

input <- readLines("day2_input")



tibble(input = input) %>%
  mutate(num_lower = as.numeric(str_extract(input, "^[0-9]+"))) %>%
  mutate(num_upper = as.numeric(str_extract(input, "(?<=^[0-9]{1,2}-)[0-9]+"))) %>%
  mutate(letter = str_extract(input, "[a-z]+(?=:)")) %>%
  mutate(string = str_extract(input, "[a-z]+$")) %>%
  mutate(letters = str_extract_all(string, letter)) %>%
  # mutate(letters = purrr::map_chr(letters, ~ str_c(., collapse = ""))) %>%
  rowwise() %>%
  filter(between(length(letters), num_lower, num_upper)) %>%
  nrow()
