library(dplyr)

zips <- read.csv("Data/american_business.csv")

clean_table <- zips %>%
  select(
    name = name,
    address = address,
    city = city,
    zipcode = postal_code,
    lat = latitude,
    lon = longitude,
    ratings = stars,
    r_count = review_count,
    status = is_open,
    cate = categories
  )