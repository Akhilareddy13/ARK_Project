server <- function(input, output, session) {
  observeEvent(input$file, {
    file <- input$file$datapath
    file_extension <- tools::file_ext(file)
    
    if (file_extension != "csv") {
      output$alert <- renderText({
        "Alert: Only CSV files are allowed."
      })
      return()
    }
    
    data <- read.csv(file)
    num_rows <- nrow(data)
    num_columns <- ncol(data)
    missing_counts <- sapply(data, function(col) sum(is.na(col)))
    
    output$result <- renderPrint({
      paste("Number of rows in the uploaded CSV:", num_rows)
    })
    
    output$num_columns <- renderPrint({
      paste("Number of columns in the uploaded CSV:", num_columns)
    })
    
    output$missing_values_table <- renderTable({
      data.frame(
        Column = names(data),
        DataType = sapply(data, class),
        MissingValues = missing_counts
      )
    }, rownames = FALSE)
    
    num_rows_reactive <- reactive({
      file <- input$file$datapath
      data <- read.csv(file)
      return(nrow(data))
    })
    
    num_columns_reactive <- reactive({
      file <- input$file$datapath
      data <- read.csv(file)
      return(ncol(data))
    })
    
    missing_values <- reactive({
      file <- input$file$datapath
      data <- read.csv(file)
      missing_counts <- sapply(data, function(col) sum(is.na(col)))
      return(missing_counts)
    })
    
    column_types_table <- reactive({
      data <- read.csv(file)
      data.frame(
        Column = names(data),
        DataType = sapply(data, class),
        MissingValues = missing_counts
      )
    })
    
    output$downloadOutput <- downloadHandler(
      filename = function() {
        paste("data-", Sys.Date(), ".txt", sep = "")
      },
      content = function(file) {
        content <- c(
          paste("Number of rows in the uploaded CSV:", num_rows_reactive()),
          paste("Number of columns in the uploaded CSV:", num_columns_reactive())
        )
        
        column_types_table_content <- capture.output(print(column_types_table()))
        
        all_content <- c(content, column_types_table_content)
        writeLines(all_content, file)
      }
    )
  })
}
