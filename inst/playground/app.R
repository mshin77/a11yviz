library(shiny)
library(bslib)
library(ggplot2)
library(palmerpenguins)
library(DT)
library(a11yviz)

penguins <- na.omit(penguins)

dt_options <- list(
  dom        = "Bfrtip",
  buttons    = c("copy", "csv", "excel"),
  pageLength = 10,
  scrollX    = TRUE,
  autoWidth  = TRUE
)

ui <- page_sidebar(
  sidebar = sidebar(width = 240,
    radioButtons("level", "WCAG level:",
                 choices = c("AA", "AAA"), selected = "AA", inline = TRUE)
  ),
  navset_card_underline(
    nav_panel("Baseline",
      plotOutput("plot_before", height = "320px"),
      tags$h3("Audit", class = "h6 mt-3"),
      DT::dataTableOutput("audit_before")
    ),
    nav_panel("Accessible",
      plotOutput("plot_after", height = "320px"),
      tags$h3("Audit", class = "h6 mt-3"),
      DT::dataTableOutput("audit_after")
    )
  )
)

server <- function(input, output) {
  base_plot <- reactive({
    ggplot(penguins, aes(flipper_length_mm, body_mass_g, color = species)) +
      geom_point() +
      labs(title = "Penguins (default ggplot)")
  })

  a11y_plot <- reactive({
    p <- ggplot(penguins, aes(flipper_length_mm, body_mass_g, color = species)) +
      geom_point(size = 2, alpha = 0.75) +
      theme_a11y(level = input$level) +
      scale_color_a11y(level = input$level) +
      labs(title = "Penguins (theme_a11y + scale_color_a11y)",
           x = "Flipper length (mm)", y = "Body mass (g)", color = "Species") +
      theme(legend.position = "top")
    a11y_alt_text(p, "Penguin body mass vs flipper length by species, AA accessible.")
  })

  output$plot_before <- renderPlot(base_plot())
  output$plot_after  <- renderPlot(a11y_plot())

  output$audit_before <- DT::renderDT(
    DT::datatable(a11y_audit_actionable(a11y_audit_chart(base_plot(),     level = input$level)),
                  extensions = "Buttons", options = dt_options,
                  class = "compact stripe hover", rownames = FALSE)
  )
  output$audit_after <- DT::renderDT(
    DT::datatable(a11y_audit_actionable(a11y_audit_chart(a11y_plot(), level = input$level)),
                  extensions = "Buttons", options = dt_options,
                  class = "compact stripe hover", rownames = FALSE)
  )
}

shinyApp(ui, server)
