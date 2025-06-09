source("ui/ui_draft1.R")
source("ui/ui_draft2.R")

ui <- navbarPage(
  "Child Mortality Article Viewer",
  ui_draft2,
  ui_draft1
)