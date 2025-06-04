ui <- fluidPage(
  titlePanel("Not All Children Breathe Equal"),
  
  tabsetPanel(
    tabPanel("Read the Story",
             fluidPage(
               h3("1. Introduction: A Preventable Tragedy"),
               p("Each year, thousands of children under five die from pneumonia, a disease that is both preventable and treatable..."),
               
               h3("2. Who Is Most at Risk?"),
               plotlyOutput("plot_risk"),
               
               h3("3. A Gendered Divide?"),
               plotlyOutput("plot_gender"),
               
               h3("4. Geography Matters"),
               plotlyOutput("plot_geo"),
               
               h3("5. Progress or Plateau?"),
               plotlyOutput("plot_trend"),
               
               h3("7. Conclusion: From Data to Action"),
               p("This data reveals real gaps in child health outcomes. The app helps identify where interventions may have the most impact.")
             )
    ),
    
    tabPanel("Custom Visualise",
             sidebarLayout(
               sidebarPanel(
                 selectInput("location_type", "Select Location Type:", choices = unique(cp_data$location_type)),
                 uiOutput("location_ui"),
                 selectizeInput("sex", "Select Sex:",
                                choices = c("Both", sort(unique(cp_data$sex))),
                                selected = "Both", multiple = TRUE),
                 selectInput("metric", "Select Metric:", choices = c("Number", "Rate")),
                 sliderInput("year_range", "Select Year Range:",
                             min = min(cp_data$year), max = max(cp_data$year),
                             value = c(min(cp_data$year), max(cp_data$year)), sep = "")
               ),
               mainPanel(
                 plotlyOutput("death_plot")
               )
             )
    )
  )
)
