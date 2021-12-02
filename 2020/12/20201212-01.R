# Day 12, Puzzle 1

library(dplyr)
library(purrr)
library(stringr)


input <- c("F10",
           "N3",
           "F7",
           "R90",
           "F11")


east <- 0 # x coordinate
north <- 0 # y coordinate
position <- c(east, north)
facing_x <- 1  # 1 when facing east, 0 when facing N/S, -1 when facing west
facing_y <- 0  # 1 when facing north, 0 when facing E/W, -1 when facing south
facing <- c(facing_x, facing_y)

move_forward <- function(position, facing, amount) {

  position[1] <- position[1] + (amount * facing[1])
  position[2] <- position[2] + (amount * facing[2])
  position
}


move_y <- function(position, amount) {

  position[2] <- position[2] + amount
  position

}
move_x <- function(position, amount) {

  position[1] <- position[1] + amount
  position

}

rotate <- function(facing, amount) {

  amount <- amount/90




}


process_instr <- function(position, facing, x) {

  type <- str_extract(x, "^[A-Z]+")
  amount <- str_extract(x, "[0-9]+$") %>% as.numeric()

  case_when(

    type == "F" ~ move_forward(position, facing, amount),
    type == "E" ~ move_x(position, amount),
    type == "W" ~ move_x(position, (amount * -1)),
    type == "N" ~ move_y(position, amount),
    type == "S" ~ move_y(position, (amount * -1)),
    type == "L" ~ rotate(facing, amount),
    type == "R" ~ rotate(facing, amount * -1)

  )




}
