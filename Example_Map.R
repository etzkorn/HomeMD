### Some helpful code sourced from:
### https://rstudio-pubs-static.s3.amazonaws.com/285359_35d630ddbc554c62b9137c13f063ee0e.html

library(ggplot2)
library(ggmap)
library(maps)
library(mapdata)
library(dplyr)

        (
            map_data("county") %>%
            subset(region == "maryland") %>% 
            group_by(group) %>%
            mutate(y = rnorm(1)) %>%
            ungroup %>%
            ggplot() +
            coord_fixed(1.3) + 
            geom_polygon(
                   aes(x = long, y = lat, group = group, fill = y), 
                   color = "white") +
            theme_void()+ 
            theme(legend.position = "none")
        )%>%
        ggplotly(tooltip = c("subregion")) %>%
        layout(xaxis = list(fixedrange = TRUE,
                            showgrid = FALSE), 
               yaxis = list(fixedrange = TRUE,
                            showgrid = FALSE)) 
  