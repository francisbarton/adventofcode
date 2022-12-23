post_title <- readline("Post title: ")
post_slug <- tolower(gsub("[ :]+", "_", post_title))
year <- format(Sys.Date(), "%Y")
month <- format(Sys.Date(), "%m")
file_loc <- here::here(year, paste0(post_slug, ".Rmd"))
yaml_block <- paste(
  "---",
  paste0("title: '", post_title, "'"),
  paste0("date: ", Sys.Date()),
  "output: md_document",
  "subtitle: ",
  "tags: ",
  "- advent_of_code",
  "- rstats",
  "---",
  sep = "\n"
)
writeLines(yaml_block, file_loc)
