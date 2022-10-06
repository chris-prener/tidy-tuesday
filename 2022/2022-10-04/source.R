# 2022-10-04 exercise ####

# === === === === === === === === === === === === === === === === === ===

## load dependencies ####
library(dplyr)
library(readr)
library(stringr)

# === === === === === === === === === === === === === === === === === ===

## load data ####
df <- read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2022/2022-10-04/product_hunt.csv")

# === === === === === === === === === === === === === === === === === ===

## tidy data ####
df %>%
  select(id, upvotes, release_date, category_tags) %>%
  rename(
    date = release_date,
    tags = category_tags
  ) %>%
  # the next line of code uses stringr::str_detect() to look for the presence
  # of particular words in the tags string related to Apple products
  mutate(apple = str_detect(tags, pattern = "IPHONE|IPAD|MAC")) %>%
  filter(apple == TRUE) %>%
  select(-apple) -> df

# === === === === === === === === === === === === === === === === === ===
