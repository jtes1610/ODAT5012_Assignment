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
                     sliderInput("year_range_story", "Select Year Range:",
                                 min = min(cp_data$year),
                                 max = max(cp_data$year),
                                 value = c(min(cp_data$year), max(cp_data$year)),
                                 sep = "", step = 1),
                     
                     h3("1. Introduction: A Preventable Tragedy"),
                     p("Each year, thousands of children under five die from pneumonia..."),
                     
                     h3("2. Who Is Most at Risk?"),
                     plotOutput("plot_risk"),
                     
                     h3("3. A Gendered Divide?"),
                     plotOutput("plot_gender"),
                     
                     h3("4. Geography Matters"),
                     plotOutput("plot_geo"),
                     
                     h3("5. Progress or Plateau?"),
                     plotOutput("plot_trend"),
                     
                     h3("6. Explore the Data"),
                     dataTableOutput("data_table"),
                     
                     h3("7. Conclusion: From Data to Action"),
                     p("This data reveals real gaps in child health outcomes...")
                 )
        ),
        
        tabPanel("Custom Visualise",
                 sidebarLayout(
                     sidebarPanel(
                         selectInput("location_type", "Select Location Type:",
                                     choices = unique(cp_data$location_type)),
                         uiOutput("location_ui"),
                         radioButtons("metric", "Select Metric:", choices = c("Number", "Rate"), inline = TRUE),
                         selectInput("sex_filter", "Select Sex:",
                                     choices = c("Both", "Male", "Female"), selected = "Both"),
                         sliderInput("year_range", "Select Year Range:",
                                     min = min(cp_data$year), max = max(cp_data$year),
                                     value = c(min(cp_data$year), max(cp_data$year)),
                                     sep = "", step = 1)
                     ),
                     mainPanel(
                         plotOutput("death_plot")
                     )
                 )
        )
    )
)

server <- function(input, output, session) {
    
    # Story Plots (aggregated over sex)
    
    output$plot_risk <- renderPlot({
        cp_data %>%
            filter(year >= input$year_range_story[1], year <= input$year_range_story[2]) %>%
            group_by(year, location_type) %>%
            summarise(total_deaths = sum(Number, na.rm = TRUE), .groups = "drop") %>%
            ggplot(aes(x = year, y = total_deaths, colour = location_type)) +
            geom_line() +
            labs(title = "Deaths by Location Type", y = "Total Deaths", x = "Year")
    })
    
    output$plot_gender <- renderPlot({
        cp_data %>%
            filter(year >= input$year_range_story[1], year <= input$year_range_story[2]) %>%
            group_by(year, sex) %>%
            summarise(total_deaths = sum(Number, na.rm = TRUE), .groups = "drop") %>%
            ggplot(aes(x = year, y = total_deaths, colour = sex)) +
            geom_line() +
            labs(title = "Deaths by Sex", y = "Total Deaths", x = "Year")
    })
    
    output$plot_geo <- renderPlot({
        cp_data %>%
            filter(location %in% c("Sub-Saharan Africa - WB", "South Asia - WB", "Australia"),
                   year >= input$year_range_story[1], year <= input$year_range_story[2]) %>%
            group_by(year, location) %>%
            summarise(deaths = sum(Number, na.rm = TRUE), .groups = "drop") %>%
            ggplot(aes(x = year, y = deaths, colour = location)) +
            geom_line() +
            labs(title = "Deaths by Region/Country", y = "Number of Deaths", x = "Year")
    })
    
    output$plot_trend <- renderPlot({
        cp_data %>%
            filter(year >= input$year_range_story[1], year <= input$year_range_story[2]) %>%
            group_by(year) %>%
            summarise(global_deaths = sum(Number, na.rm = TRUE), .groups = "drop") %>%
            ggplot(aes(x = year, y = global_deaths)) +
            geom_line(colour = "steelblue") +
            labs(title = "Global Mortality Trend (1980–2021)", y = "Deaths", x = "Year")
    })
    
    output$data_table <- renderDataTable({
        cp_data
    })
    
    # Custom Visualise
    
    output$location_ui <- renderUI({
        req(input$location_type)
        selectInput("location", "Select Location(s):",
                    choices = cp_data %>%
                        filter(location_type == input$location_type) %>%
                        pull(location) %>% unique(),
                    multiple = TRUE)
    })
    
    output$death_plot <- renderPlot({
        req(input$location)
        filtered_data <- cp_data %>%
            filter(location %in% input$location,
                   year >= input$year_range[1],
                   year <= input$year_range[2])
        
        # Filter sex unless 'Both'
        if (input$sex_filter != "Both") {
            filtered_data <- filtered_data %>% filter(sex == input$sex_filter)
        }
        
        filtered_data %>%
            group_by(year, location) %>%
            summarise(val = sum(.data[[input$metric]], na.rm = TRUE), .groups = "drop") %>%
            ggplot(aes(x = year, y = val, colour = location)) +
            geom_line(size = 1.1) +
            labs(title = paste(input$metric, "Over Time"), y = input$metric, x = "Year") +
            theme_minimal()
    })
}

shinyApp(ui, server)
