ui <- fluidPage(
  # ... (Your UI code)
)

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
    
    output$result <- renderText({
      paste("Number of rows in the uploaded CSV:", num_rows)
    })
    
    output$num_columns <- renderText({
      paste("Number of columns in the uploaded CSV:", num_columns)
    })
    
    output$missing_values_table <- renderTable({
      data.frame(Column = names(missing_counts), MissingValues = missing_counts)
    }, rownames = FALSE)
  })
  
  num_rows <- reactive({
    file <- input$file$datapath
    data <- read.csv(file)
    return(nrow(data))
  })
  
  num_columns <- reactive({
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
  
  output$downloadOutput <- downloadHandler(
    filename = function() {
      paste("data-", Sys.Date(), ".txt", sep = "")
    },
    content = function(file) {
      content <- c(
        paste("Number of rows in the uploaded CSV:", num_rows()),
        paste("Number of columns in the uploaded CSV:", num_columns())
      )
      
      # Prepare content for missing values table
      missing_table <- as.data.frame(missing_values())
      missing_table_content <- capture.output(print(missing_table))
      
      # Combine all content and write to file
      all_content <- c(content, "Missing values table:", missing_table_content)
      writeLines(all_content, file)  # Generates a text file
    }
  )
  
}


