ui <- fluidPage(
  titlePanel("Vision"),
  
  sidebarLayout(
    sidebarPanel(
      helpText("Selecting color demographics"),
      
      selectInput("select", 
                  label = "Choose a color",
                  choices = list("White", 
                                 " Black",
                                 "Orange" 
                                 ),
                  selected = "White"),
      
      sliderInput("slider1", 
                  label = "Range of interest:",
                  min = 0, max = 100, value = c(0, 100))
    ),
    
    mainPanel()
  )
)