# Day 11, Puzzle 1

library(purrr)
library(stringr)

# example input
input <- c("L.LL.LL.LL",
  "LLLLLLL.LL",
  "L.L.L..L..",
  "LLLL.LL.LL",
  "L.LL.LL.LL",
  "L.LLLLL.LL",
  "..L.L.....",
  "LLLLLLLLLL",
  "L.LLLLLL.L",
  "L.LLLLL.LL")

input <- readLines("11/day11_input")

width <- nchar(input[1])

layout <- str_split(input, "") %>% unlist()

check_seats <- function(layout, n) {

  if (!layout[n] == ".") {

    normal <- c(-(width+1), -width, -(width-1), -1, 1, (width-1), width, (width+1))
    left_edge <- c(-width, -(width-1), 1, width, (width+1))
    right_edge <- c(-(width+1), -width, -1, (width-1), width)

    if (n %% width == 1) {        # left edge
      seats <- `+`(n, left_edge)
    } else if (n %% width == 0) { # right edge
      seats <- `+`(n, right_edge)
    } else {
      seats <- `+`(n, normal)
    }

    seats <- layout[intersect(seats, seq(layout))]

    if (sum(str_detect(seats, "#")) >= 4) {
      "L"
    } else if (sum(str_detect(seats, "#")) == 0) {
      "#"
    } else {
      layout[n]
    }
  } else {
    layout[n]
  }
}


seats_transform <- function(layout) {
  layout2 <- seq(layout) %>%
    map_chr(~ check_seats(layout, .))

  if (identical(layout2, layout)) {
    sum(str_detect(layout2, "#"))
  } else {
    seats_transform(layout2)
  }

}

seats_transform(layout)


