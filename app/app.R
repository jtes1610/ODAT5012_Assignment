library(shiny)
library(dplyr)
library(readr)
library(ggplot2)
library(DT)

cp_data <- read_csv("data/cp_wide_classified.csv")

ui <- fluidPage(
    titlePanel("Not All Children Breathe Equal"),
    
    tabsetPanel(
        tabPanel("Read the Story",
                 fluidPage(
                     h3("1. Introduction: A Preventable Tragedy"),
                     p("Each year, thousands of children under five die from pneumonia, a disease that is both preventable and treatable. Despite global advances in healthcare, pneumonia remains a leading cause of child mortality, especially in regions with limited access to quality healthcare."),
                     
                     h3("2. Who Is Most at Risk?"),
                     p("Explore child pneumonia deaths by different location types such as health system strength, SDI group, and WHO region."),
                     plotOutput("plot_risk"),
                     
                     h3("3. A Gendered Divide?"),
                     p("Examine the difference in mortality between male and female children under five."),
                     plotOutput("plot_gender"),
                     
                     h3("4. Geography Matters"),
                     p("Choose a few sample regions or countries and compare their progress over time."),
                     plotOutput("plot_geo"),
                     
                     h3("5. Progress or Plateau?"),
                     p("Has global pneumonia mortality improved over time?"),
                     plotOutput("plot_trend"),
                     
                     h3("6. Explore the Data"),
                     p("Browse the full dataset below."),
                     dataTableOutput("data_table"),
                     
                     h3("7. Conclusion: From Data to Action"),
                     p("This data reveals real gaps in child health outcomes. The app helps identify where interventions may have the most impact.")
                 )
        ),
        
        tabPanel("Custom Visualise",
                 sidebarLayout(
                     sidebarPanel(
                         selectInput("location_type", "Select Location Type:", choices = unique(cp_data$location_type)),
                         uiOutput("location_ui")
                     ),
                     mainPanel(
                         plotOutput("death_plot")
                     )
                 )
        )
    )
)

server <- function(input, output, session) {
    # Plot 1: Deaths by location type
    output$plot_risk <- renderPlot({
        cp_data %>%
            group_by(year, location_type) %>%
            summarise(total_deaths = sum(Number, na.rm = TRUE), .groups = "drop") %>%
            ggplot(aes(x = year, y = total_deaths, colour = location_type)) +
            geom_line() +
            labs(title = "Deaths by Location Type", y = "Total Deaths", x = "Year")
    })
    
    # Plot 2: Deaths by sex
    output$plot_gender <- renderPlot({
        cp_data %>%
            group_by(year, sex) %>%
            summarise(total_deaths = sum(Number, na.rm = TRUE), .groups = "drop") %>%
            ggplot(aes(x = year, y = total_deaths, colour = sex)) +
            geom_line() +
            labs(title = "Deaths by Sex", y = "Total Deaths", x = "Year")
    })
    
    # Plot 3: Geography comparison
    output$plot_geo <- renderPlot({
        cp_data %>%
            filter(location %in% c("Sub-Saharan Africa - WB", "South Asia - WB", "Australia")) %>%
            ggplot(aes(x = year, y = Number, colour = location)) +
            geom_line() +
            labs(title = "Deaths by Region/Country", y = "Number of Deaths", x = "Year")
    })
    
    # Plot 4: Global trend
    output$plot_trend <- renderPlot({
        cp_data %>%
            group_by(year) %>%
            summarise(global_deaths = sum(Number, na.rm = TRUE), .groups = "drop") %>%
            ggplot(aes(x = year, y = global_deaths)) +
            geom_line(colour = "steelblue") +
            labs(title = "Global Mortality Trend (1980–2021)", y = "Deaths", x = "Year")
    })
    
    # Table
    output$data_table <- renderDataTable({
        cp_data
    })
    
    # Dynamic filter UI for custom visualisation
    output$location_ui <- renderUI({
        req(input$location_type)
        selectInput("location", "Select Location(s):",
                    choices = cp_data %>%
                        filter(location_type == input$location_type) %>%
                        pull(location) %>% unique(),
                    multiple = TRUE)
    })
    
    # Custom visualisation plot
    output$death_plot <- renderPlot({
        req(input$location)
        cp_data %>%
            filter(location %in% input$location) %>%
            ggplot(aes(x = year, y = Number, colour = location)) +
            geom_line(size = 1.1) +
            labs(title = "Deaths Over Time", y = "Number of Deaths", x = "Year") +
            theme_minimal()
    })
}

shinyApp(ui, server)
