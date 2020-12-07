# Day 6

# Part 1
library(purrr)
library(stringr)

input <- readLines("day6_input")

input[which(input == "")] <- "EOL"


input %>%
  str_c(collapse = "") %>%
  str_split("EOL") %>%
  unlist() %>%
  str_extract_all("[a-z]") %>%
  map(unique) %>%
  map(length) %>%
  unlist() %>%
  sum()


# Part 2

check_in_all <- function(string) {
  string_members <- str_split(string, ",") %>%
    unlist()

  string_letters <- str_extract_all(string_members, "[a-z]") %>%
    unlist() %>%
    unique()

  map_lgl(string_letters, ~ all(str_detect(string_members, .))) %>%
    sum()
}


input %>%
  str_c(collapse = ",") %>%
  str_split(",EOL,") %>%
  pluck(1) %>%
  map_int(check_in_all) %>%
  sum()
