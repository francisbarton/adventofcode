# Day 7, Puzzle 1

library(dplyr)
library(stringr)
library(purrr)

input <- readLines("day7_input")
# input <- readLines("day7_test_input")

find_containers <- function(x) {

  if (length(x) > 0) {
    str_subset(input, paste0("contain.*", x)) %>%
    str_extract("^[a-z]+\\s[a-z]+")
  } else NULL

}


map_find_containers <- function(vec) {

  map(vec, ~ find_containers(.)) %>%
    unlist() %>%
    unique()

}


accumulate_list <- function(base_lst, last_vec = dplyr::last(base_lst)) {

  out <- list(unlist(base_lst), map_find_containers(last_vec))

  if (length(last(out)) == 0) first(out)
  else accumulate_list(out)

}


accumulate_list("shiny gold") %>% unique()
