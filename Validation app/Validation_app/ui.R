library(shiny)
library(readr)

ui <- shinyUI(fluidPage(
  titlePanel("CSV File Analyzer"),
  tabsetPanel(
    tabPanel("Upload CSV",
             sidebarLayout(
               sidebarPanel(
                 fileInput("file", "Choose a CSV file:"),
                 downloadButton("downloadOutput", "Download Analysis Report (TXT)")
               ),
               mainPanel(
                 verbatimTextOutput("result"),
                 verbatimTextOutput("num_columns"),
                 tableOutput("missing_values_table"),
                 tableOutput("column_types_table")
               )
             )
    ),
    tabPanel("Display Local File",
             fileInput("local_file", "Choose a local file:"),
             verbatimTextOutput("local_file_content")
    )
  )
))