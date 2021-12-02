# Day 10, Puzzle 1


input <- c(28L, 33L, 18L, 42L, 31L, 14L, 46L, 20L, 48L, 47L, 24L, 23L, 49L, 45L, 19L, 38L, 39L, 11L, 1L, 32L, 25L, 35L, 8L, 17L, 7L, 9L, 4L, 2L, 34L, 10L, 3L)

input <- readLines("10/day10_input") %>%  as.numeric


chain <- c(0, sort(input), (max(input) + 3))

gaps <- seq(chain) %>%
  tail(-1) %>%
  purrr::map_dbl( ~ `-`(chain[.], chain[.-1]))

s1 <- sum(gaps == 1)
s2 <- sum(gaps == 3)

s1 * s2
