
library(shiny)
library(shinydashboard)

# Product data (you can replace this with your product data)
products <- data.frame(
  ProductID = c(1, 2, 3, 4),
  ProductName = c("Product A", "Product B", "Product C", "Product D"),
  Price = c(10, 15, 20, 25)
)

ui <- dashboardPage(
  dashboardHeader(
    title = "Simple E-commerce Website",
    tags$li(
      class = "dropdown",
      tags$a(
        href = "#",
        class = "dropdown-toggle",
        `data-toggle` = "dropdown",
        icon("bars"), # Font Awesome menu icon
        "Menu"
      ),
      tags$ul(
        class = "dropdown-menu",
        tags$li(tags$a(href = "#", icon("home"), "Home")),
        tags$li(tags$a(href = "#", icon("info-circle"), "About")),
        tags$li(tags$a(href = "#", icon("shopping-cart"), "Cart"))
      )
    )
  ),
  dashboardSidebar(),
  dashboardBody(
    fluidRow(
      box(
        width = 4,
        title = "Product Listing",
        tableOutput("product_table")
      ),
      box(
        width = 4,
        title = "Shopping Cart",
        tableOutput("cart_table"),
        actionButton("checkout_button", "Checkout")
      )
    )
  )
)

server <- function(input, output, session) {
  # Initialize the shopping cart as an empty data frame
  cart <- reactiveVal(data.frame(ProductID = integer(), ProductName = character(), Price = numeric()))
  
  # Render the product listing table
  output$product_table <- renderTable({
    products
  })
  
  # Update the shopping cart when a product is added
  observeEvent(input$product_table_rows_selected, {
    selected_row <- input$product_table_rows_selected
    if (length(selected_row) > 0) {
      product <- products[selected_row, ]
      current_cart <- cart()
      updated_cart <- rbind(current_cart, product)
      cart(updated_cart)
    }
  })
  
  # Render the shopping cart table
  output$cart_table <- renderTable({
    cart()
  })
  
  # Perform checkout when the checkout button is clicked
  observeEvent(input$checkout_button, {
    # Implement your checkout logic here (e.g., payment processing, order confirmation)
    # For this example, we'll just reset the cart to empty after checkout
    cart(data.frame(ProductID = integer(), ProductName = character(), Price = numeric()))
    showModal(modalDialog(
      title = "Checkout Successful",
      "Thank you for your purchase!",
      easyClose = TRUE
    ))
  })
}


