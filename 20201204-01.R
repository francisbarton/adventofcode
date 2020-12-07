# Day 4, Puzzle 1

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

out <- map(out, set_names) %>%
  bind_rows() %>%
  select(-cid) %>%
  tidyr::drop_na()

nrow(out)


# Puzzle 2

# keep 'out' from puzzle 1

out %>%
  select(byr, iyr, eyr, hgt, hcl, ecl, pid) %>%
  mutate(across(everything(), ~ str_remove(., "^[a-z]+:"))) %>%
  mutate(across(byr:eyr, as.numeric)) %>%
  filter(between(byr, 1920, 2002)) %>%
  filter(between(iyr, 2010, 2020)) %>%
  filter(between(eyr, 2020, 2030)) %>%
  filter(str_ends(hgt, "cm|in")) %>%
  mutate(hgt_type = str_extract(hgt, "[a-z]+$")) %>%
  mutate(hgt_num = as.numeric(str_extract(hgt, "[0-9]+"))) %>%
  filter((hgt_type == "cm" & between(hgt_num, 150, 193)) |
           (hgt_type == "in" & between(hgt_num, 59, 76))) %>%
  select(!hgt_num:hgt_type) %>%
  filter(str_detect(hcl, "^#{1}[0-9a-f]{6}$")) %>%
  filter(ecl %in% c("amb", "blu", "brn", "gry", "grn", "hzl", "oth")) %>%
  filter(str_detect(pid, "^[0-9]{9}$")) %>%
  nrow()

