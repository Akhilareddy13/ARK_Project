

server <- function(input, output, session) {
  output$alert <- renderText(NULL)
  output$result <- renderText(NULL)
  output$num_columns <- renderText(NULL)
  output$missing_values_table <- renderTable(NULL)
  
  observeEvent(input$file, {
    file <- input$file$datapath
    file_extension <- tools::file_ext(file)
    
    if (file_extension != "csv") {
      output$alert <- renderText({
        "Alert: Only CSV files are allowed."
      })
      return()
    }
    
    data <- read_csv(file)
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
  
  output$downloadPdf <- downloadHandler(
    filename = function() {
      "results_summary.pdf"
    },
    content = function(file) {
      # Create a summary of results as a data frame
      summary_data <- data.frame(
        Result = c(output$result(), output$num_columns()),
        MissingValues = as.character(output$missing_values_table())
      )
      
      # Create a table using kableExtra
      table <- kable(summary_data, format = "html") %>%
        kable_styling(full_width = FALSE)
      
      # Convert HTML table to PDF
      webshot::webshot(table, file = "temp.png")
      
      # Convert the image to PDF
      png_path <- "temp.png"
      pdf_path <- "results_summary.pdf"
      png2pdf(png_path, pdf_path)
      
      # Remove the temporary PNG image
      file.remove(png_path)
      
      # Move the PDF to the final location
      file.rename(pdf_path, file)
    }
  )
}

