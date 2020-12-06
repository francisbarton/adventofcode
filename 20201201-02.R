# Day 1, Puzzle 2

input <- sort(as.numeric(readLines("day1_input")))


library(dplyr)


#' I'm not very happy about this: it feels like I'm brute-forcing it
#' But trying clever functions with mapply wasn't getting me the answer
#' so this will have to do.

tibble("value1" = input, "value2" = input) %>%
  tidyr::expand(value1, value2) %>%


  # you don't need this bit, just trying to make it a less huge set of combs.
  rowwise() %>%
  mutate(total = sum(c_across(everything()))) %>%
  ungroup() %>%
  dplyr::filter(total < 2020) %>%
  dplyr::select(-total) %>%


  tidyr::expand(value1, value2, input) %>%
  rowwise() %>%
  mutate(total = sum(c_across(everything()))) %>%
  ungroup() %>%
  dplyr::filter(total == 2020) %>%
  dplyr::select(1:3) %>%
  slice(1) %>%
  unlist() %>%
  cat() %>%
  cumprod() %>%
  last()




