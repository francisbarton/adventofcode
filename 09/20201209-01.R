# Day 9, Puzzle 1
# I decided to try writing this as several small, single-use,
# building-block functions, for extreme clarity. Feedback welcome.


input <- c(35L, 20L, 15L, 25L, 47L, 40L, 62L, 55L, 65L, 95L, 102L, 117L, 150L, 182L, 127L, 219L, 299L, 277L, 309L, 576L)
preamble_length <- 5

input <- readLines("09/day9_input") %>% as.numeric
preamble_length <- 25

# at any point in the vector, extract the previous pre elements
get_previous <- function(vec, n, pre) {
  vec[(n - pre):(n - 1)]
}

# given a numeric vector, find the sums of all combinations of exactly
# 2 different elements. I feel like this should take fewer steps somehow?
get_combinations <- function(vec) {
  dplyr::tibble(a = vec, b = vec) %>%
    tidyr::expand(a, b) %>%
    dplyr::filter(a < b) %>%
    dplyr::rowwise() %>%
    dplyr::mutate(added = sum(a, b)) %>%
    dplyr::pull(added)
}

# given any element in the vector, is it equal to one of the sums of all
# combinations of exactly 2 different elements from the previous 'pre' elements?
check_n <- function(vec, n, pre) {
  `%in%`(vec[n],
         get_previous(vec, n, pre) %>%
           get_combinations())
}

# map check_n along every element of the vector, starting at n = pre + 1
check_along <- function(vec, pre) {
  seq(vec) %>%
    tail(-pre) %>%
      purrr::map_lgl( ~ check_n(vec, ., pre))
}

# given a vector 'input' and excluding a preamble of a certain length, which of
# the subsequent elements does not have a match within the
# set of combinations of sums of the preceding 'pre' elements?
input %>%
  tail(-preamble_length) %>%
  `[`(which(
    !check_along(input, preamble_length)))
