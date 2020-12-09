# Day 8, Puzzle 1

input <- c("nop +0",
           "acc +1",
           "jmp +4",
           "acc +3",
           "jmp -3",
           "acc -99",
           "acc +1",
           "jmp -4",
           "acc +6")

input <- readLines("08/day8_input")



find_fault <- function(line, visited, acc) {

  if (!line %in% visited) {

    visited <- c(visited, line)
    instr <- `[`(input, line) %>% substr(1, 3)
    chg <- `[`(input, line) %>%
      substr(5, nchar(.)) %>%
      as.numeric()

    if (instr == "nop") {
      find_fault(line + 1, visited, acc)
    } else if (instr == "acc") {
      acc <- acc + chg
      find_fault(line + 1, visited, acc)
    } else if (instr == "jmp") {
      find_fault(line + chg, visited, acc)
    }
  } else acc
}

find_fault(1, NULL, 0)
