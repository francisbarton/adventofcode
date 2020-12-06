# Day 3, Puzzle 1

input <- readLines("day3_input")

map_trees <- function(step_x, step_y) {

  initial_y <- 1
  initial_x <- 1

  width <- nchar(input[1])

  find_trees <- function(current_y) {

    # was getting wrong answers on Part 2#5 until I tested and realised I
    # needed to divide by step_y to get an accurate current_x!
    # current_x <- `%%`(initial_x + ((current_y - 1) * step_x), width)
    current_x <- `%%`(initial_x + (((current_y - initial_y)/step_y) * step_x), width)
    if (current_x == 0) current_x <- width
    substr(input[current_y], current_x, current_x)
  }

  purrr::map_chr(seq(initial_y, length(input), step_y), find_trees)

}

map_trees(3, 1) %>%
  `[`(. == "#") %>%
  length

# Puzzle 2
x_steps <- c(1, 3, 5, 7, 1)
y_steps <- c(1, 1, 1, 1, 2)

purrr::map2_int(x_steps, y_steps,

  ~ map_trees(.x, .y) %>%
  `[`(. == "#") %>%
  length

  ) %>%
  prod

