library(shiny)
library(readr)

shinyServer(function(input, output) {
  observeEvent(input$file, {
    file <- input$file$datapath
    file_extension <- tools::file_ext(file)
    
    if (file_extension != "csv") {
      output$alert <- renderPrint({
        "Alert: Only CSV files are allowed."
      })
      return()
    }
    
    data <- read_csv(file)
    num_rows <- nrow(data)
    
    output$result <- renderPrint({
      paste("Number of rows in the uploaded CSV:", num_rows)
    })
  })
})
