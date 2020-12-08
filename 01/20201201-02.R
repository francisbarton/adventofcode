# Day 1, Puzzle 2

input <- as.numeric(readLines("day1_input"))


library(dplyr)


#' I'm not very happy about this: it feels like I'm brute-forcing it
#' But trying clever functions with mapply wasn't getting me the answer
#' so this will have to do.

tibble("value1" = input, "value2" = input, "value3" = input) %>%

  # create all combinations of the values
  tidyr::expand(value1, value2, value3) %>%

  # good idea here from dbradnum to reduce down the list to
  # leave only unique combinations
  # https://github.com/dbradnum/adventOfCode2020/blob/master/code/day1.R

  filter(value1 < value2, value2 < value3) %>%

  rowwise() %>%
  mutate(total = sum(c_across(everything()))) %>%
  ungroup() %>%
  dplyr::filter(total == 2020) %>%
  dplyr::select(-total) %>%
  unlist() %>%
  prod()




