source("server/server_draft1.R", local = TRUE)
source("server/server_draft2.R", local = TRUE)

server <- function(input, output, session) {
  server_draft1(input, output, session)
  server_draft2(input, output, session)
  
  # Shared Draft 2 elements
  output$selected_range_text <- renderText({
    paste0("Currently showing data from ", input$year_range[1], " to ", input$year_range[2])
  })
  
  observeEvent(input$reset_years, {
    updateSliderInput(session, "year_range", value = c(1980, 2021))
  })
}
