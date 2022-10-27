# 2022-10-04 exercise ####

# === === === === === === === === === === === === === === === === === ===

## load dependencies ####
library(dplyr)
library(ggplot2)
library(lubridate)
library(readr)

# === === === === === === === === === === === === === === === === === ===

## download data ####

# details - https://bakeoff.netlify.app/reference/ratings.html

ratings <- read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2022/2022-10-25/ratings.csv") %>%
  select(series, uk_airdate, viewers_28day) %>%
  mutate(series = as.factor(series))

# === === === === === === === === === === === === === === === === === ===

## plot viewers ####

### create palette
pal <- colorRampPalette(RColorBrewer::brewer.pal(9, "Set1"))

p <- ggplot(data = ratings, mapping = aes(x = uk_airdate, y = viewers_28day, 
                                          color = series)) +
  geom_line() +
  scale_x_date(
    date_breaks = "1 years", 
    date_labels = "%Y"
  ) + 
  scale_y_continuous(limits = c(0,16), breaks = seq(0,16, by = 2)) +
  scale_color_manual(values = pal(n = length(unique(ratings$series)))) +
  labs(
    title = "Great British Bakeoff 28-day Viewers",
    x = "Year",
    y = "28-day Viewers (millions)"
  )

ggsave(filename = "2022/2022-10-25/viewers.png", plot = p)
