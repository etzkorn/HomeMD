### Some helpful code sourced from:
### https://rstudio-pubs-static.s3.amazonaws.com/285359_35d630ddbc554c62b9137c13f063ee0e.html

library(ggplot2)
library(ggmap)
library(maps)
library(mapdata)
library(dplyr)

md_county <- subset(map_data("county"), region == "maryland")
md_fill <- 
tibble(subregion = unique(md_county$subregion)) %>%
mutate(y = rnorm(n()))

md_county <- left_join(md_county, md_fill)

  ggplot() +
  coord_fixed(1.3) + 
  geom_polygon(data = md_county, 
               aes(x = long, y = lat, group = group, fill = y), 
               color = "white") +
  theme_void()+ 
  theme(legend.position = "none")
  