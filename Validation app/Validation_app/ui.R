library(shiny)
library(readr)
library(rmarkdown)

ui <- shinyUI(fluidPage(
  titlePanel("CSV File Analyzer"),
  sidebarLayout(
    sidebarPanel(
      fileInput("file", "Choose a CSV file:"),
      downloadButton("downloadOutput", "Download Analysis Report (PDF)")
    ),
    mainPanel(
      # textOutput("alert"),
      verbatimTextOutput("result"),
      verbatimTextOutput("num_columns"),
      tableOutput("missing_values_table")
      
    )
  )
))