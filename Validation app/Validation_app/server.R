server <- function(input, output) {
  
  data <- reactive({ get(input$data, 'package:datasets') })
  
  output$plot <- renderPlot({
    hist(data()[, 1], col = 'forestgreen', border = 'white')
  })
  
  output$table <- renderTable({
    head(data())
  })
  
}