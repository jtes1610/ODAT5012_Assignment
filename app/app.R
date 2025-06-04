library(shiny)
library(dplyr)
library(readr)
library(plotly)
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
                     plotlyOutput("plot_risk"),
                     
                     h3("3. A Gendered Divide?"),
                     p("Examine the difference in mortality between male and female children under five."),
                     plotlyOutput("plot_gender"),
                     
                     h3("4. Geography Matters"),
                     p("Choose a few sample regions or countries and compare their progress over time."),
                     plotlyOutput("plot_geo"),
                     
                     h3("5. Progress or Plateau?"),
                     p("Has global pneumonia mortality improved over time?"),
                     plotlyOutput("plot_trend"),
                     
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
                         uiOutput("location_ui"),
                         checkboxInput("aggregate", "Show Aggregated Total", value = TRUE),
                         selectInput("sex", "Select Sex:", choices = unique(cp_data$sex), selected = "Female"),
                         selectInput("metric", "Select Metric:", choices = c("Number", "Rate"), selected = "Number"),
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

server <- function(input, output, session) {
    
    output$plot_risk <- renderPlotly({
        p <- cp_data %>%
            group_by(year, location_type) %>%
            summarise(total_deaths = sum(Number, na.rm = TRUE), .groups = "drop") %>%
            ggplot(aes(x = year, y = total_deaths, colour = location_type)) +
            geom_line() +
            labs(title = "Deaths by Location Type", y = "Total Deaths", x = "Year") +
            theme_minimal()
        ggplotly(p)
    })
    
    output$plot_gender <- renderPlotly({
        p <- cp_data %>%
            group_by(year, sex) %>%
            summarise(total_deaths = sum(Number, na.rm = TRUE), .groups = "drop") %>%
            ggplot(aes(x = year, y = total_deaths, colour = sex)) +
            geom_line() +
            labs(title = "Deaths by Sex", y = "Total Deaths", x = "Year") +
            theme_minimal()
        ggplotly(p)
    })
    
    output$plot_geo <- renderPlotly({
        selected_locs <- c("Sub-Saharan Africa - WB", "South Asia - WB", "Australia")
        p <- cp_data %>%
            filter(location %in% selected_locs) %>%
            ggplot(aes(x = year, y = Number, colour = location)) +
            geom_line() +
            labs(title = "Deaths by Region/Country", y = "Number of Deaths", x = "Year") +
            theme_minimal()
        ggplotly(p)
    })
    
    output$plot_trend <- renderPlotly({
        p <- cp_data %>%
            group_by(year) %>%
            summarise(global_deaths = sum(Number, na.rm = TRUE), .groups = "drop") %>%
            ggplot(aes(x = year, y = global_deaths)) +
            geom_line(colour = "steelblue") +
            labs(title = "Global Mortality Trend (1980–2021)", y = "Deaths", x = "Year") +
            theme_minimal()
        ggplotly(p)
    })
    
    output$data_table <- renderDataTable({
        cp_data
    })
    
    output$location_ui <- renderUI({
        req(input$location_type)
        available_locations <- cp_data %>%
            filter(location_type == input$location_type) %>%
            distinct(location) %>%
            pull(location)
        selectInput("location", "Select Location(s):", choices = available_locations,
                    selected = available_locations[1], multiple = TRUE)
    })
    
    output$death_plot <- renderPlotly({
        req(input$location_type, input$metric, input$sex, input$year_range)
        
        filtered <- cp_data %>%
            filter(location_type == input$location_type,
                   sex == input$sex,
                   year >= input$year_range[1],
                   year <= input$year_range[2])
        
        if (input$aggregate) {
            filtered <- filtered %>%
                group_by(year) %>%
                summarise(val = sum(.data[[input$metric]], na.rm = TRUE), .groups = "drop") %>%
                mutate(location = paste("Total (", input$location_type, ")", sep = ""))
        } else {
            filtered <- filtered %>%
                filter(location %in% input$location) %>%
                select(year, location, val = all_of(input$metric))
        }
        
        p <- ggplot(filtered, aes(x = year, y = val, colour = location)) +
            geom_line(size = 1.1) +
            labs(title = "Custom Deaths Visualisation",
                 y = input$metric,
                 x = "Year") +
            theme_minimal()
        
        ggplotly(p)
    })
}

shinyApp(ui, server)
