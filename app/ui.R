source("ui/ui_draft1.R")
source("ui/ui_draft2.R")
source("ui/ui_final.R")
source("ui/ui_writeup.R")
source("ui/ui_datasource.R")

ui <- navbarPage(
  "Child Mortality Article Viewer",
  ui_final,
  ui_writeup,
  ui_datasource,
  ui_draft2,
  ui_draft1
)