library(tidyverse)
library(shiny)
source("data-prep-script.R")
shinyApp(
  
  ui = fluidPage(
    selectInput("sport", "Sport:",
                choices = sports_list)
    ,plotOutput("plot1", height = "300px")
    ,br()
    ,br()
    ,br()
    ,selectInput("country", "Country:", 
                 choices = country_list)
    ,plotOutput("plot2",height = "300px")
  ),

  
  
  server <- function(input, output) {
    
    plot1_data <- reactive({
      gender_sport_country_facet_data %>% 
        filter(Sport == input$sport)
    })
    
    output$plot1 <- renderPlot({
      
      p <- ggplot(plot1_data()) +
        labs(title = "Cumulative Medals Earned by Country and Gender",
             subtitle = input$sport)+
        ylab('Cum Medal Count')+
        geom_line(aes(x=Year, y=cumulative_medals, color = Country)) +
        facet_wrap(vars(Gender)) +
        theme(
          text=element_text(size=18),
          axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1, size=14),
          axis.title.x = element_blank()
        )
      p
    })
    
    plot2_data <- reactive({
      gender_sport_country_facet_data %>% 
        filter(Country == input$country)
    })
    
    output$plot2 <- renderPlot({
      
      p <- ggplot(plot2_data()) +
        labs(title = "Yearly Medals Earned by Sport and Gender",
             subtitle = input$country)+
        ylab('Yearly Medals Earned')+
        geom_bar(aes(x=Year, y=medal_count, fill = Sport),
                 position='stack', stat='identity') +
        facet_wrap(vars(Gender)) +
        theme(
          text=element_text(size=18),
          axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1, size=14),
          axis.title.x = element_blank()
        )
      p
    })
  }
)
