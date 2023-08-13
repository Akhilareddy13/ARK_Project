library(shiny)

shinyUI(fluidPage(
  titlePanel("CSV File Validator"),
  fileInput("file", "Upload a CSV file"),
  verbatimTextOutput("result"),
  verbatimTextOutput("alert")
))


