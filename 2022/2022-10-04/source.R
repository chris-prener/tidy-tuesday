# 2022-10-04 exercise ####

# === === === === === === === === === === === === === === === === === ===

## load dependencies ####
library(dplyr)
library(lubridate)
library(readr)
library(stringr)

# === === === === === === === === === === === === === === === === === ===

## load data ####
products <- read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2022/2022-10-04/product_hunt.csv")

# === === === === === === === === === === === === === === === === === ===

## tidy data ####

### create apple subset
products %>%
  select(id, release_date, category_tags) %>%
  rename(
    date = release_date,
    tags = category_tags
  ) %>%
  # the next line of code uses stringr::str_detect() to look for the presence
  # of particular words in the tags string related to Apple products
  mutate(apple = str_detect(tags, pattern = "IPHONE|IPAD|MAC")) %>%
  filter(apple == TRUE) %>%
  select(-apple) -> apple

### count by month-year combinations
apple %>%
  mutate(
    year = year(date),
    # the next line of code adds a leading zero in front of January-September
    # so that you get a 01 for output instead of a 1
    month = str_pad(month(date), 2, pad = "0")
  ) %>%
  # paste0 is one way to concatenate strings togeather
  mutate(year_mon = paste0(year, "-", month)) %>%
  # group_by and summarise take a larger grouping variable and allow you
  # to count observations in those groups or compute summary statistics
  # like mean, median, mode, etc
  group_by(year_mon) %>%
  summarise(count = n()) -> by_month
  
# === === === === === === === === === === === === === === === === === ===
