# Load individual draft & write-up servers
source("server/server_draft1.R",   local = TRUE)
source("server/server_draft2.R",   local = TRUE)
source("server/server_final.R",    local = TRUE)
source("server/server_writeup.R",  local = TRUE)

server <- function(input, output, session) {
  # DRAFT 1: uses its own _d1 IDs
  server_draft1(input, output, session)
  
  # DRAFT 2: uses its own _d2 IDs
  server_draft2(input, output, session)
  
  # FINAL: uses _d3 IDs
  server_final(input, output, session)
  
  # WRITE-UP: renders tables & write-up tab
  server_writeup(input, output, session)
  
  message(">> All servers (draft1, draft2, final & writeup) loaded successfully")
}
