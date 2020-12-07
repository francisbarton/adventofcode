
library(dplyr)
library(purrr)
library(stringr)


input <- readLines("day4_input")

input[which(input == "")] <- "EOL"


out <- input %>%
  str_c(collapse = " ") %>%
  str_split(" EOL ") %>%
  unlist() %>%
  str_split(" ")

set_names <- function(vec) {
  names(vec) <- str_extract(vec, "^[a-z]+")
  vec
}

map(out, set_names) %>%
  bind_rows()
