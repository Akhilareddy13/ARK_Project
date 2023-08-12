library(shiny)

ui <- fluidPage(
  
  titlePanel("Validation App"),
  
  sidebarLayout(
    sidebarPanel(
      selectInput("data", label = "Data set",
                  choices = c("", "mtcars", "faithful", "iris"))
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      tableOutput("table"),
      plotOutput("plot")
    )
  )
)



