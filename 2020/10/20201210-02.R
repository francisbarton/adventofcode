# Day 10, PUzzle 2

library(purrr)

input <- c(16L, 10L, 15L, 5L, 1L, 11L, 7L, 19L, 6L, 12L, 4L) %>% sort()
input <- c(28L, 33L, 18L, 42L, 31L, 14L, 46L, 20L, 48L, 47L, 24L, 23L, 49L, 45L, 19L, 38L, 39L, 11L, 1L, 32L, 25L, 35L, 8L, 17L, 7L, 9L, 4L, 2L, 34L, 10L, 3L) %>% sort


input <- readLines("10/day10_input") %>% as.numeric %>% sort

input <- input %>%
  c(0, ., last(.)+3)


test_for_three_jump <- function(input) {
  seq(input) %>%
    head(-1) %>%
    map_lgl(~ (input[.+1] - input[.] == 3))
}

breaks <- c(which(test_for_three_jump(input)), length(input))
breaks <- rev(breaks)
factors <- rev(seq(breaks))
split_factors <- seq(breaks)

create_factors <- function(vec, n) {
  if (n <= length(breaks)) {
    vec[1:breaks[[n]]] <- factors[[n]]
    create_factors(vec, n+1)
  } else {
    vec
  }
}


split_factors <- create_factors(split_factors, 1)
input_split <- split(input, split_factors)


# just helping to check the number of routes through
return_all_combs <- function(x, lim = 3) {

  y <- x %>%
    head(-1) %>%
    tail(-1)

  out <- seq(y) %>%
    map(~ combn(y, m = ., simplify = FALSE)) %>%
    flatten()
  out <- subset(out, map_lgl(out, ~ max(.) >= (max(x) - lim)))
  subset(out, map_lgl(out, ~ min(.) <= (min(x) + lim)))

}

## routes through groups of certain lengths ("Tribonacci"! apparently)
# if length = 1 then routes = 1
# if length = 2 then routes = 1
# if length = 3 then routes = 2
# if length = 4 then routes = 4
# if length = 5 then routes = 7
# if length = 6 then routes = 13


trib_function <- function(x) {
  if (x %in% 1:2) 1
  else if (x == 3) 2
  else {
    trib_function(x-1) + trib_function(x-2) + trib_function(x-3)
  }
}


map_dbl(input_split, length) %>%
  map_dbl(trib_function) %>%
  unname() %>%
  prod() %>%
  format(scientific = FALSE)






### all the below was fine except for the fact that
### (according the reddit threads) it would have taken about 8 months
### for the recursive process to complete! (without memoisation) using
### the full input of length 111



find_next_items <- function(input, n) {

  if (n = max(input)) {
    n
  } else if (n %in% three_jumps) {
    n + 3
  } else {
    input[between(input, n+1, n+2)]
  }
}


scrape_end_values <- function(lst) {
  lst %>%
    map_dbl(last) %>%
    map( ~ find_next_items(input, .))
}


append_to_existing <- function(vecx, vecy) {
  map(vecy, ~ c(vecx, .)) %>%
    map(unique)
}

create_new_list <- function(lst) {
  lst2 <- scrape_end_values(lst)
  map2(lst, lst2, append_to_existing) %>%
    flatten()
}


map_create_list <- function(lst) {

  out <- create_new_list(lst)

  ends <- map_dbl(out, last)

  if (all(ends == max(input))) {
    out
  } else {
    map_create_list(out)
  }

}

out <- map_create_list(0)

length(out)
