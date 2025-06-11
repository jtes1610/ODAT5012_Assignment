# server_writeup.R
library(shiny)
library(DiagrammeR)

server_writeup <- function(input, output, session) {
  
  output$plan_diagram <- renderGrViz({
    grViz("
    digraph timeline {
      graph [
        rankdir   = LR
        splines   = orthogonal
        nodesep   = 1.0
        ranksep   = 1.0
        ratio     = fill        // let it stretch vertically
        // size    = \"6,3\"    // or use size to force a width x height in inches
      ]
      node [
        shape     = box
        style     = filled
        fontname  = Helvetica
        fontsize  = 14
        margin    = 0.3
      ]
      subgraph cluster_r1 {
        label='Testing Round 1'; style=filled; fillcolor=lightblue; color=transparent
        Heur [label='Heuristic Evaluation']
        UT1  [label='User Testing\nRound 1']
        Req1 [label='Requirements\nRefinement']
      }
      subgraph cluster_r2 {
        label=''; style=filled; fillcolor=lightgreen; color=transparent
        Dev2 [label='Development of\nRelease 2']
      }
      subgraph cluster_r3 {
        label='Testing Round 2'; style=filled; fillcolor=lightblue; color=transparent
        UT2  [label='User Testing\nRound 2']
        Req2 [label='Requirements\nRefinement']
      }
      subgraph cluster_r4 {
        label=''; style=filled; fillcolor=lightgreen; color=transparent
        DevF [label='Development of\nFinal Version']
      }
      Heur -> UT1 -> Req1 -> Dev2 -> UT2 -> Req2 -> DevF
    }
  ")
  })
  
  
  # Round 1: Users Tested & their Description
  output$round1_users <- renderTable({
    data.frame(
      Individual = c("Jake", "Julie", "Tyson", "Dylan"),
      Profession = c(
        "Mechanical Engineer",
        "Graphic Designer",
        "Graduate Student",
        "History Teacher"
      ),
      Description = c(
        paste(
          "Jake is comfortable with using graphs to quickly find information as it is a part of his day to day work.",
          "\n\nAs Jake was very comfortable interacting with visualisations, he was able to complete the tasks quickly.",
          "He provided commentary throughout on inconsistencies throughout."
        ),
        "Julie has experience building reports and developing infographics and is comfortable with interpreting data.",
        "Tyson has a Computer Science background and is currently doing a grad rotation in UI.",
        paste(
          "Dylan provided his thoughts as he went through the visualisations.",
          "He is comfortable with looking at graphs but tended to go straight to answering the question",
          "before reading everything and taking it in."
        )
      ),
      stringsAsFactors = FALSE
    )
  }, striped = TRUE, hover = TRUE)
  
  # Round 1: Identified Improvements from Heuristic Evaluation & User Testing :contentReference[oaicite:5]{index=5}
  output$round1_improvements <- renderTable({
    data.frame(
      Aspect    = c(
        "Article Text",
        "Graph 2: Pneumonia Rate by SDI group",
        "Graph 2: Pneumonia Rate by SDI group",
        "Graph 2: Pneumonia Rate by SDI group",
        "Graph 4: Latest Pneumococcal Vaccine (PVC) Coverage by Country",
        "Graph 2 & Graph 3",
        "All Graphs",
        "All Graphs"
      ),
      `Description of Improvement` = c(
        paste(
          "Implement rewording to better integrate the text with the messaging and content of the article.",
          "Each paragraph should explicitly talk about the data shown in the following graph.",
          "\n\nReorder visualisations to better tie in with the narrative.",
          "\n\nImplement a clear purpose of focusing on Pneumonia, implement with more strength."
        ),
        "Define the term SDI in the context of the graph. Add tooltips or inline explanations.",
        "Clearer placement of UI Elements for intuitive use.",
        paste(
          "Ensure Legend is in order (High to Low SDI) and the colours are intuitive",
          "(eg. use a colour scale from pale blue to black from Low to High)."
        ),
        "Invert colour scale to perform as more of a heat map to allow greater intuitive interaction.",
        paste(
          "Change displayed data on hover to less decimal places and as a percentage",
          "OR",
          "Represent the value as ‘Deaths per 1000’ for cleaner values."
        ),
        "Implement a working reset function on all figures.",
        paste(
          "Implement a colour theme throughout to tie the article together.",
          "This could be achieved by ensuring Graphs 2 and 3 follow the blue theme that 1 and 4 follow."
        )
      ),
      Priority = c("High", "High", "Low", "High", "Medium", "Medium", "Low", "Medium"),
      `Include in final design?` = rep("Yes", 8),
      stringsAsFactors = FALSE
    )
  }, striped = TRUE, hover = TRUE)
  
  # Round 2: Users Tested & their Description :contentReference[oaicite:6]{index=6}
  output$round2_users <- renderTable({
    data.frame(
      Individual = c("Jackson", "Cameron", "Julian", "Nik"),
      Profession = c(
        "Clinical Trial Coordinator",
        "High School Biology Teacher",
        "Photographer & Operations Manager",
        "Biomedical Engineering Student"
      ),
      Description = c(
        "Comfortable with looking at graphs and reading data. He completed tasks quickly and extracted correct information.",
        "Cameron has a science background and has a good understanding of data and reporting.",
        "Julian has data knowledge but doesn’t often generate or use plots in daily work.",
        "Nik has limited knowledge of interacting with data."
      ),
      stringsAsFactors = FALSE
    )
  }, striped = TRUE, hover = TRUE)
  
  # Round 2: Identified Improvements from Heuristic Evaluation & User Testing :contentReference[oaicite:7]{index=7}
  output$round2_improvements <- renderTable({
    data.frame(
      Aspect    = c(
        "Graph 2: Latest Pneumococcal Vaccine (PVC) Coverage by Country",
        "Graph 3: Pneumonia Rate by SDI group",
        "Graph 3 & Graph 4",
        "Graph 3: Pneumonia Rate by SDI group",
        "Graph 3: Pneumonia Rate by SDI group",
        "All Graph"
      ),
      `Description of Improvement` = c(
        "Add tooltip icon to explain that white nations represent countries with no data.",
        "Higher contrast of colours for the SDI graph is needed to separate the different SDI groups.",
        "Move number/rate button to be inline with the graph for more intuitive interaction.",
        "Add icon with tooltip on hover to inform user on what SDI is.",
        "Removed sliding scale.",
        "Change tooltips to red for easier identification."
      ),
      Priority = c("Medium", "High", "Low", "High", "Low", "Medium"),
      `Include in final design?` = c("Yes", "Yes", "No", "Yes", "Yes", "Yes"),
      stringsAsFactors = FALSE
    )
  }, striped = TRUE, hover = TRUE)
}
