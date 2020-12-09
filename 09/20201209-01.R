# Day 9, Puzzle 1

input <- c(35L, 20L, 15L, 25L, 47L, 40L, 62L, 55L, 65L, 95L, 102L, 117L, 150L, 182L, 127L, 219L, 299L, 277L, 309L, 576L)
preamble_length <- 5

input <- readLines("09/day9_input") %>% as.numeric
preamble_length <- 25


get_previous <- function(vec, n, pre) {
  vec[(n - pre):(n - 1)]
}

get_combinations <- function(vec) {
  dplyr::tibble(a = vec, b = vec) %>%
    tidyr::expand(a, b) %>%
    dplyr::filter(a < b) %>%
    dplyr::rowwise() %>%
    dplyr::mutate(added = sum(a, b)) %>%
    dplyr::pull(added)
}

check_n <- function(vec, n, pre) {
  `%in%`(vec[n],
         get_previous(vec, n, pre) %>%
           get_combinations())
}

check_along <- function(vec, pre) {
  seq(vec) %>%
    tail(-pre) %>%
      purrr::map_lgl( ~ check_n(vec, ., pre))
}



input %>%
  tail(-preamble_length) %>%
  `[`(which(
    !check_along(input, preamble_length)))
