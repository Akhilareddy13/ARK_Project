library("shiny")

ui<-fluidPage(
  
  titlePanel(h1("My Shiny App")),
  sidebarLayout(
    sidebarPanel(
      h2("Installation"),
      p("Script is found under the Model Answer button, but don’t just copy and paste it. "),
      br(),
      code('install.packages("shiny")'),
      br(),
      br(),
      br(),
      img(src = "R logo.png", height = 70, width = 200),
      br(),
      p("shiny is a product of", 
       span("Rstudio", style="color:blue") ),
),

mainPanel(h1("Introducing Shiny"),
          
          p("This lesson covers the most popular Shiny tag functions, but there are many more tag functions for you to use."),
br(),

p("Make sure you understand how the code works before moving on."),

h2("Features"),
p("-See how well you understand these functions by ."),

p("-Our app.R script is found under the Model Answer button, but 
don’t just copy and paste it. 
  Make sure you understand how the code works before moving on."),
          )
)
)
