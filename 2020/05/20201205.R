
library(dplyr)
library(purrr)
library(stringr)
library(tidyr)

input <- readLines("day5_input")

out <- str_extract_all(input, "[FB]{7}|[LR]{3}") %>%
  transpose(.names = c("row", "column")) %>%
  as_tibble() %>%
  mutate(across(everything(), ~ str_replace_all(., c("F|L" = "0", "B|R" = "1")))) %>%
  mutate(across(everything(), ~ strtoi(., base = 2))) %>%
  mutate(seat_id = `+`(row * 8, column))

out %>%
  slice_max(seat_id) %>%
  pull(seat_id)


# Puzzle 2
setdiff(seq(832), out$seat_id)


