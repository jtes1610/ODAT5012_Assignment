# Load individual draft servers
source("server/server_draft1.R", local = TRUE)
source("server/server_draft2.R", local = TRUE)
source("server/server_final.R", local = TRUE)

server <- function(input, output, session) {
  # Namespaced call to prevent output/input conflicts
  
  # DRAFT 1: Isolated with its own ID suffixes
  server_draft1(input, output, session)
  
  # DRAFT 2: Also uses unique IDs (e.g. _d2)
  server_draft2(input, output, session)
  
  # FINAL: Uses _d3 for all inputs/outputs (safe and isolated)
  server_final(input, output, session)
  
  # NOTE: Any shared elements between versions (e.g. reset buttons, tooltips)
  # must be suffixed to avoid overwrites. Final elements use *_d3 exclusively.
  
  # Do not define shared elements like this anymore:
  # output$selected_range_text <- renderText({ ... })
  # observeEvent(input$reset_years, { ... })
  # These are now handled in the appropriate *_d1, *_d2, *_d3 functions.
  
  message(">> All draft servers loaded successfully")
}