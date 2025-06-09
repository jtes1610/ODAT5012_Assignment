# server_draft1.R

server_draft1<-function(input, output, session) {
  
  # Helper for Draft 1
  output$top10_bar_d1 <- renderPlotly({
    plot_ly(top_causes,
            x = ~deaths,
            y = ~reorder(cause, deaths),
            type = 'bar',
            orientation = 'h',
            marker = list(color = 'rgba(66, 135, 245, 0.8)')) %>%
      layout(
        xaxis = list(title = "Number of Deaths", tickformat = ",.0f"),
        yaxis = list(title = "Cause of Death", automargin = TRUE)
      )
  })
  
  output$global_trend_d1 <- renderPlotly({
    metric_col <- if (input$sdi_metric_d1 == "Rate") "Rate" else "Number"
    
    data <- cp %>%
      filter(sex %in% c("Male", "Female"),
             location_type == "SDI Group",
             year >= input$year_range_d1[1],
             year <= input$year_range_d1[2],
             !is.na(.data[[metric_col]])) %>%
      group_by(location, year) %>%
      summarise(value = mean(.data[[metric_col]], na.rm = TRUE), .groups = "drop") %>%
      mutate(value = if (input$sdi_metric_d1 == "Rate") value / 1000 else value)
    
    plot_ly(data, x = ~year, y = ~value, color = ~location, type = 'scatter', mode = 'lines') %>%
      layout(
        yaxis = list(title = if (input$sdi_metric_d1 == "Rate") "Death Rate (%)" else "Number of Deaths"),
        xaxis = list(title = "Year")
      )
  })
  
  output$regional_rates_d1 <- renderPlotly({
    metric_col <- if (input$who_metric_d1 == "Rate") "Rate" else "Number"
    
    data <- cp %>%
      filter(sex %in% c("Male", "Female"),
             location_type == "WHO Region",
             year %in% c(1980, 2021),
             !is.na(.data[[metric_col]])) %>%
      group_by(location, year) %>%
      summarise(value = mean(.data[[metric_col]], na.rm = TRUE), .groups = "drop") %>%
      mutate(value = if (input$who_metric_d1 == "Rate") value / 1000 else value)
    
    plot_ly(data, x = ~location, y = ~value, color = ~as.factor(year), type = 'bar', barmode = 'group') %>%
      layout(
        yaxis = list(title = if (input$who_metric_d1 == "Rate") "Death Rate (%)" else "Number of Deaths"),
        xaxis = list(title = "WHO Region")
      )
  })
  
  output$pcv_coverage_d1 <- renderPlotly({
    pcv_latest <- pcv %>%
      filter(!is.na(PCV)) %>%
      group_by(Entity) %>%
      filter(Year == max(Year)) %>%
      ungroup()
    
    plot_ly(pcv_latest,
            type = "choropleth",
            locations = ~Entity,
            locationmode = "country names",
            z = ~PCV,
            colorscale = "Blues",
            colorbar = list(title = "PCV Coverage (%)"))
  })
}