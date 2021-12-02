# Day 11, Puzzle 2

library(dplyr)
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

get_visible_rt <- function(layout, n) {

    if (n %% width == 0) NA
    else {
      `:`((n + 1), (ceiling(n / width) * width)) %>%
        `[`(layout, .) %>%
        subset(!. == ".") %>%
        first()
    }
}
get_visible_lt <- function(layout, n) {

  if (n %% width == 1) NA
  else {
    `:`(((floor((n - 1)/ width) * width) + 1), (n - 1)) %>%
      `[`(layout, .) %>%
      subset(!. == ".") %>%
      last()
  }
}
get_visible_up <- function(layout, n) {

  if (n <= width) NA
  else {
    n %>%
      `/`(width) %>%
      floor() %>%
      seq() %>%
      `*`(width) %>%
      `-`(n, .) %>%
      `[`(layout, .) %>%
      subset(!. == ".") %>%
      first()
  }
}
get_visible_dn <- function(layout, n) {

  if (n + width > length(layout)) NA
  else {
    layout %>%
      length() %>%
      `-`(n) %>%
      `/`(width) %>%
      floor() %>%
      seq() %>%
      `*`(width) %>%
      `+`(n) %>%
      `[`(layout, .) %>%
      subset(!. == ".") %>%
      first()
  }
}


get_visible_se <- function(layout, n) {

  if (n + width > length(layout)) NA
  else if (n %% width == 0) NA
  else {

    d <- floor((length(layout) - n) / width)
    r <- width - (n %% width)

    sort(c(d, r)) %>%
      first %>%
      seq() %>%
      `*`((width + 1)) %>%
      `+`(n) %>%
      `[`(layout, .) %>%
      subset(!. == ".") %>%
      first()
  }
}
get_visible_sw <- function(layout, n) {

  if (n + width > length(layout)) NA
  else if (n %% width == 1) NA
  else {

    d <- floor((length(layout) - n) / width)
    l <- (n %% width) - 1

    sort(c(d, l)) %>%
      first %>%
      seq() %>%
      `*`((width - 1)) %>%
      `+`(n) %>%
      `[`(layout, .) %>%
      subset(!. == ".") %>%
      first()
  }
}
get_visible_ne <- function(layout, n) {

  if (n <= width) NA
  else if (n %% width == 0) NA
  else {

    u <- floor(n / width)
    r <- width - (n %% width)

    sort(c(u, r)) %>%
      first %>%
      seq() %>%
      `*`(width - 1) %>%
      `-`(n, .) %>%
      `[`(layout, .) %>%
      subset(!. == ".") %>%
      first()
  }
}
get_visible_nw <- function(layout, n) {

  if (n <= width) NA
  else if (n %% width == 1) NA
  else {

    u <- floor(n / width)
    l <- (n %% width) - 1

    sort(c(u, l)) %>%
      first %>%
      seq() %>%
      `*`((width + 1)) %>%
      `-`(n, .) %>%
      `[`(layout, .) %>%
      subset(!. == ".") %>%
      first()
  }
}

check_visible_seats <- function(layout, n) {

  if (!layout[n] == ".") {

    visibles <- c(
      get_visible_rt(layout, n),
      get_visible_lt(layout, n),
      get_visible_up(layout, n),
      get_visible_dn(layout, n),
      get_visible_se(layout, n),
      get_visible_sw(layout, n),
      get_visible_ne(layout, n),
      get_visible_nw(layout, n)
    )

    if (sum(str_detect(visibles, "#"), na.rm = TRUE) >= 5) {
      "L"
    } else if (sum(str_detect(visibles, "#"), na.rm = TRUE) == 0) {
      "#"
    } else {
      layout[n]
    }

  } else {
    "."
  }

}


seats_transform2 <- function(layout) {
  layout2 <- seq(layout) %>%
    map_chr(~ check_visible_seats(layout, .))

  if (identical(layout2, layout)) {
    sum(str_detect(layout2, "#"))
  } else {
    seats_transform2(layout2)
  }

}

seats_transform2(layout)


