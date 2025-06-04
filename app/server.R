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
    selected_locs <- c("Australia", "South Asia - WB", "Sub-Saharan Africa - WB")
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
  
  output$location_ui <- renderUI({
    req(input$location_type)
    available_locations <- cp_data %>%
      filter(location_type == input$location_type) %>%
      distinct(location) %>%
      pull(location) %>%
      sort()
    selectInput("location", "Select Location(s):",
                choices = c("All" = "__ALL__", available_locations),
                selected = "__ALL__",
                multiple = TRUE)
  })
  
  output$death_plot <- renderPlotly({
    req(input$location_type, input$metric, input$sex, input$year_range)
    
    filtered <- cp_data %>%
      filter(location_type == input$location_type,
             year >= input$year_range[1],
             year <= input$year_range[2])
    
    # ── Handle combinations ──
    if ("__ALL__" %in% input$location && identical(input$sex, "Both")) {
      # Global total
      plot_data <- filtered %>%
        filter(sex %in% c("Male", "Female")) %>%
        group_by(year) %>%
        summarise(val = ceiling(sum(.data[[input$metric]], na.rm = TRUE)), .groups = "drop") %>%
        mutate(group = "Total")
      
    } else if ("__ALL__" %in% input$location) {
      # Global split by sex
      plot_data <- filtered %>%
        filter(sex %in% input$sex) %>%
        group_by(year, sex) %>%
        summarise(val = ceiling(sum(.data[[input$metric]], na.rm = TRUE)), .groups = "drop") %>%
        mutate(group = paste0("Total - ", sex))
      
    } else if (identical(input$sex, "Both")) {
      # Per location totals
      plot_data <- filtered %>%
        filter(location %in% input$location, sex %in% c("Male", "Female")) %>%
        group_by(year, location) %>%
        summarise(val = ceiling(sum(.data[[input$metric]], na.rm = TRUE)), .groups = "drop") %>%
        mutate(group = paste0("Total - ", location))
      
    } else {
      # Per location per sex
      plot_data <- filtered %>%
        filter(location %in% input$location, sex %in% input$sex) %>%
        mutate(val = ceiling(.data[[input$metric]])) %>%
        unite("group", location, sex, sep = " - ", remove = FALSE) %>%
        select(year, group, val)
    }
    
    p <- ggplot(plot_data, aes(x = year, y = val, colour = group)) +
      geom_line(size = 1.1) +
      labs(title = "Custom Deaths Visualisation", y = input$metric, x = "Year") +
      theme_minimal()
    
    ggplotly(p)
  })
}
