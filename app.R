library(shiny)
library(ggplot2)
library(ggmap)
library(maps)
library(mapdata)
library(dplyr)
library(plotly)

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Senior Homeowner Policies in Maryland"),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
         sidebarPanel(
             width = 2,
             selectInput("count", "Choose a County:",
                         {
                             map_data("county") %>%
                                 subset(region == "maryland") %>% 
                                 select(subregion) %>%
                                 unlist() %>% 
                                 unique %>% 
                                 sort()
                         })),

        # Show a plot of the generated distribution
        mainPanel(
            width = 10,
            plotlyOutput("mapMD", height = "800px")
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
    output$mapMD <- renderPlotly({
        (map_data("county") %>%
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
        theme(legend.position = "none"))%>%
        ggplotly(tooltip = c("subregion")) %>%
        layout(xaxis = list(fixedrange = TRUE,
                            showgrid = FALSE), 
               yaxis = list(fixedrange = TRUE,
                            showgrid = FALSE)) #%>%
        #config(modeBarButtonsToRemove = c("zoomIn2d", "zoomOut2d"))
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
