# library(haven)
# 
# carat <- read.csv("C:/Users/M329279/Downloads/Mispriced-Diamonds.csv")
# 
# library(ggplot2)
# library(dplyr)
# install.packages("ggplot2")
library(shiny)
library(plotly)
library(DT)
library(shiny)

ui <- fluidPage(navbarPage(
  "My Shiny App",
  tabPanel("tab 1",
           sidebarPanel(
             fileInput("upload", "Upload csv file", accept = ".csv"),
              numericInput("numInput", "Enter a number:", value = 0)
           ),
           mainPanel(
             tableOutput("head")
             # dataTableOutput("head")
           )
  )
))

server <- function(input, output, session) {
  data <- reactive({
    req(input$upload)
    read.csv(input$upload$datapath)
  })
  observeEvent(input$upload, {
        showNotification("File uploaded", duration = 10)

  })
  output$head <- renderTable({
    if(input$numInput<5){validate("
      enter number more than 5"
    )}
    head(data(), input$numInput)
    #head(data(), 10)
  })
  
  
  # output$head <- renderDT(data(), options = list(pageLength = 5))
  # output$head <- renderDT(data(), options = list(pageLength = 5))
  
}
shinyApp(ui, server)
