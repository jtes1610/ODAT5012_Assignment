# ui_writeup.R
library(shiny)
library(bsplus)
library(DiagrammeR)

ui_writeup <- tabPanel(
  "Evaluation",
  fluidPage(
    # ---- USER TESTING & EVALUATION ----
    h2("User Testing & Evaluation"),
    p("Once an initial concept and design for the article was developed, the article and visualisations underwent two rounds of testing to allow for improvement to the final product. The phases of the testing and development are summarised in the diagram below."),
    # Placeholder for diagram

    tags$div(
      style = "text-align: center; margin: 20px 0;",
      tags$img(
        src = "improvement_plan.png",
        alt = "Testing and Improvement Plan diagram",
        style = "max-width: 100%; height: auto; display: inline-block;"
      )
    ),
    
    
    p("Both a Heuristic Evaluation and User Testing was conducted to get an extensive view of the changes to be made to the article and visualisations to ensure good usability and benefit to the end user. Due to time constraints and to allow time for improvement and further development, it was decided to conduct the Heuristic Evaluation and the User Testing concurrently to allow for one large incorporation of feedback into the second version of the product. The outcome of this round of testing was a list of changes that were discussed with the team to be incorporated into the second version. Once the changes are implemented, a second round of testing was conducted to confirm a better user experience for the users and identify any smaller changes that may have slipped through the initial iterations. Any tweaks to the final design will be discussed and implemented to produce the final version of the article and visualisations."),
    
    tags$hr(),
    
    # ---- TESTING ROUND 1 ----
    h3("Testing Round 1"),
    
    h4("Heuristic Evaluation"),
    p("To conduct the Heuristic Evaluation, each of the four team members assessed the visualisations independently, providing a rating and commentary on each of the categories. The Heuristics used for assessment were selected as a team as it was agreed that the collection chosen provided a well rounded assessment for the purpose of the article. A summary of the Heuristic Assessments can be found in Appendix A."),
    
    h4("User Testing"),
    p("The team decided that to gain useful and holistic responses for meaningful feedback and improvement to the article and visualisations, the user test would involve the user being provided with the article and being asked to find values from the 4 different graphs. With this approach, the user would need to both interact with the visualisations but also navigate through the article and the accompanying text to complete their task."),
    
    h5("User Testing Steps"),
    tags$ol(
      tags$li("The user was provided with the link to the article and given 1 minute to skim through and get familiar with the layout and context of the article."),
      tags$li("The user was given 4 sequential tasks, each involving interaction with a different graph. Each task involved finding a specific value within one of the graphs. Each task was timed and notes were taken by the observer."),
      tags$li("Each user had the same number of tasks to complete and had to interact with all visualisations, but the values they were asked to find were changed for each task."),
      tags$li("The outcomes of each user test can be found in Appendix B.")
    ),
    
    h5("Round 1: Users Tested and their Description"),
    tableOutput("round1_users"),
    
    tags$hr(),
    
    # ---- USING THE FEEDBACK (ROUND 1) ----
    h4("Using the Feedback"),
    p("The Heuristic Evaluation and User Testing proved valuable in unveiling some key insights into improvements to be made to the visualisations and the article overall. After both the heuristic evaluation and the user testing was conducted, a summary of the key feedback was collected. Each item was assigned a priority and it was discussed whether to include each in the final design. The outcomes are summarised in the table below."),
    
    h5("Round 1: Identified Improvements from Heuristic Evaluation & User Testing"),
    tableOutput("round1_improvements"),
    
    tags$hr(),
    
    # ---- TESTING ROUND 2 ----
    h3("Testing Round 2"),
    p("All changes suggested were decided to be incorporated into the final design. Once the second release was created, with the Heuristic Evaluation and User Testing Outcomes included as well as some further enhancements to the style, layout and content in the article, a second round of user testing was conducted. The same test was repeated on a new group of users to ensure that familiarity was not serving as an advantage."),
    
    h5("Round 2: Users Tested and their Description"),
    tableOutput("round2_users"),
    
    tags$hr(),
    
    # ---- USING THE FEEDBACK (ROUND 2) ----
    h4("Using the Feedback"),
    p("The results for the second round brought less negative feedback, indicating the changes implemented from the first round resulted in an overall greater user experience. The results of the user tests can be found in Appendix C. The changes identified are summarised in the table below."),
    
    h5("Round 2: Identified Improvements from Heuristic Evaluation & User Testing"),
    tableOutput("round2_improvements"),
    
    tags$hr(),
    
    # ---- LINKS ----
    p("You can view the final version of the article as well as the first and second versions at the link below. Previous versions include inline commentary on the changes that were made as a result of the two rounds of testing:"),
    tags$a(href = "https://jtes1610.shinyapps.io/child-pneumonia-article/",
           "Child Pneumonia Article on Shinyapps.io", target = "_blank")
  )
)
