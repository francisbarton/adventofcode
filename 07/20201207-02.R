# Day 7, Puzzle 2

library(dplyr)
library(stringr)
library(purrr)

input <- readLines("day7_input")
# input <- readLines("day7_test_input")
# input <- readLines("day7_test_input2")

find_contained <- function(x) {
  # not sure if this whole if/else check is needed here in Part 2
  if (length(x) > 0) {
    n <- as.numeric(str_extract(x, "^[0-9]+"))
    # n <- ifelse(n == 0, 1, n)
    if (n == 0) n <- 1

    x <- str_extract(x, "[a-z]+[:blank:]+[a-z]+$")

    bags <- str_subset(input, paste0("^", x)) %>%
      str_extract("(?<=contain[:blank:]{1}).*(?=\\.$)") %>%
      str_split(",[:blank:]+") %>%
      pluck(1) %>%
      str_remove_all("[:blank:]+bags?$")

    bags_n <- as.numeric(str_extract(bags, "^[0-9]+")) * n
    bags_x <- str_extract(bags, "[a-z]+[:blank:]+[a-z]+$")

    paste(bags_n, bags_x) %>%
      `[`(which(!is.na(bags_n)))
  } else {
    NULL
  }
}

map_find_contained <- function(x) {
  out <- x %>%
    last() %>%
    map(find_contained) %>%
    unlist() %>%
    list(x, .)

  if (length(last(out)) == 0) {
    first(out, -1)
  } else {
    map_find_contained(out)
  }
}

"0 shiny gold" %>%
  map_find_contained() %>%
  unlist() %>%
  str_extract("^[0-9]+") %>%
  as.numeric() %>%
  sum()
