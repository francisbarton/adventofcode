# Day 8, Puzzle 1

library(dplyr)

reset_input <- function() {
  readLines("08/day8_input")
}



find_fault <- function(input, line, visited, acc) {

  if (line == length(input) + 1) {
    return(paste("Completed. acc is", acc))
  }

  if (line > length(input) | line < 1) {
    stop("invalid line number")
  }

  if (!line %in% visited) {

    visited <- c(visited, line)
    instr <- `[`(input, line) %>% substr(1, 3)
    chg <- `[`(input, line) %>%
      substr(5, nchar(.)) %>%
      as.numeric()

    if (instr == "nop") {
      find_fault(input, line + 1, visited, acc)
    } else if (instr == "acc") {
      acc <- acc + chg
      find_fault(input, line + 1, visited, acc)
    } else if (instr == "jmp") {
      find_fault(input, line + chg, visited, acc)
    }
    # } else acc   # part 1: return acc
  } else visited   # part 2 initial: return visited lines
}


# which nops would jump to 654 if they were jmps? (none)
input[
  which(
    substr(input, 1, 3) == "nop")] %>%
  substr(5, nchar(.)) %>%
  as.numeric() %>%
  `+`(which(
    substr(input, 1, 3) == "nop")) %>%
  sort()


# which jmps jump to 654 if we could get to them? (none)
input[
  which(
    substr(input, 1, 3) == "jmp")] %>%
  substr(5, nchar(.)) %>%
  as.numeric() %>%
  `+`(which(
    substr(input, 1, 3) == "jmp"))

# what about if any jmp becomes a nop?

switch_jmp_to_nop <- function(n) {

  input <- reset_input()

  if (substr(input[[n]], 1, 3) == "jmp") {
    input[[n]] <- "nop -4"
    find_fault(input, 1, NULL, 0)
  } else 0

}

input <- reset_input()

# amended switch function above so it checks for "jmp" itself
# and we map along the whole of input rather than subsetting.
# original call:
# jmp_to_nop <- purrr::map(which(
#   substr(input, 1, 3) == "jmp"), ~ switch_jmp_to_nop(.))
#
# new call:
jmp_to_nop <- purrr::map(seq(input), ~ switch_jmp_to_nop(.))

purrr::map_lgl(jmp_to_nop, is.character) %>%
  which() %>%
  `[`(jmp_to_nop, .)

purrr::map_lgl(jmp_to_nop, is.character) %>%
  which() %>%
  switch_jmp_to_nop()

purrr::map_lgl(jmp_to_nop, is.character) %>%
  `[`(input, .)
