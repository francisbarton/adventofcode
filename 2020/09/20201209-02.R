# Day 9, Puzzle 2

# part1_answer <- 127
# input <- c(35L, 20L, 15L, 25L, 47L, 40L, 62L, 55L, 65L, 95L,
# 102L, 117L, 150L, 182L, 127L, 219L, 299L, 277L, 309L, 576L)


part1_answer <- 556543474
input <- readLines("09/day9_input") %>% as.numeric

sum_from_n <- function(input, n, a = 1) {
  if (n+a <= length(input)) {

    if (sum(input[n:(n+a)]) == part1_answer) {
      min(input[n:(n+a)]) + max(input[n:(n+a)])
    } else {
      sum_from_n(input, n, a+1)
    }

  } else NULL
}

purrr::map(seq(input), ~ sum_from_n(input, .)) %>%
  unlist()
