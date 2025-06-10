server_final <- function(input, output, session) {
  
  # Text and interactivity feedback
  output$selected_range_text_d3 <- renderText({
    paste0("Currently showing data from ", input$year_range_d3[1], " to ", input$year_range_d3[2])
  })
  
  observeEvent(input$reset_years_d3, {
    updateSliderInput(session, "year_range_d3", value = c(1980, 2021))
  })
  
  # --- Final Visuals (_d3) ---
  
  output$top10_bar_d3 <- renderPlotly({
    plot_ly(top_causes,
            x = ~deaths,
            y = ~reorder(cause, deaths),
            type = 'bar',
            orientation = 'h',
            hovertext = ~paste0("Approx. ", scales::comma(deaths), " deaths"),
            hoverinfo = 'text',
            marker = list(color = 'rgba(0, 70, 140, 0.8)')) %>%
      layout(
        title = list(text = "Top 10 Causes of Death in Children of Ages 5 and Under (1980)", x = 0.05),
        xaxis = list(title = "Number of Deaths", tickformat = ",.0f"),
        yaxis = list(title = "", automargin = TRUE),
        margin = list(l = 100),
        hovermode = "closest"
      ) %>%
      config(
        displaylogo = FALSE,
        modeBarButtonsToRemove = c("zoom2d", "pan2d", "select2d", "lasso2d",
                                   "zoomIn2d", "zoomOut2d", "autoScale2d", "resetScale2d",
                                   "hoverCompareCartesian", "hoverClosestCartesian", "toImage")
      )
  })
  
  output$pcv_coverage_d3 <- renderPlotly({
    pcv_latest <- pcv %>%
      group_by(Entity) %>%
      filter(Year == max(Year, na.rm = TRUE)) %>%
      ungroup()
    
    validate(
      need(nrow(pcv_latest) > 0, "No data available for selected countries.")
    )
    
    pcv_latest <- pcv_latest %>%
      mutate(hover_text = ifelse(is.na(PCV),
                                 paste0("<b>", Entity, "</b><br>No data available"),
                                 paste0("<b>", Entity, "</b><br>Vaccination coverage: ", round(PCV, 1), "%")))
    
    plot_ly(
      pcv_latest,
      type = "choropleth",
      locations = ~Entity,
      locationmode = "country names",
      z = ~PCV,
      colorscale = "Blues",
      reversescale = TRUE,
      text = ~hover_text,
      hoverinfo = "text",
      colorbar = list(
        title = "PCV Coverage (%)",
        orientation = "h",
        x = 0.5,
        y = 0.01,
        xanchor = "center",
        len = 0.75
      )
    ) %>%
      layout(
        title = list(
          text = "Latest Pneumococcal Vaccine (PCV) Coverage by Country",
          x = 0.05,
          y = 0.95,
          font = list(size = 16)
        ),
        margin = list(t = 10, b = 30, l = 0, r = 0),
        height = 500
      ) %>%
      config(
        displaylogo = FALSE,
        displayModeBarOnHover = TRUE,
        modeBarButtonsToRemove = c("pan2d", "select2d", "lasso2d", "toImage", "hoverClosestCartesian"),
        showTips = FALSE
      )
  })
  
  output$global_trend_d3 <- renderPlotly({
    metric_col <- if (input$sdi_metric_d3 == "Rate") "Rate" else "Number"
    legend_order <- c("High SDI", "High-middle SDI", "Middle SDI", "Low-middle SDI", "Low SDI")
    sdi_colours <- list(
      "High SDI" = "#08306b",
      "High-middle SDI" = "#2171b5",
      "Middle SDI" = "#6baed6",
      "Low-middle SDI" = "#9ecae1",
      "Low SDI" = "#c6dbef"
    )
    
    data <- cp %>%
      filter(sex %in% c("Male", "Female"),
             location_type == "SDI Group",
             location %in% legend_order,
             year >= input$year_range_d3[1],
             year <= input$year_range_d3[2],
             !is.na(.data[[metric_col]])) %>%
      group_by(location, year) %>%
      summarise(value = mean(.data[[metric_col]], na.rm = TRUE), .groups = "drop") %>%
      mutate(value = if (input$sdi_metric_d3 == "Rate") value / 1000 else value,
             location = factor(location, levels = legend_order))
    
    plot_ly(data,
            x = ~year,
            y = ~value,
            color = ~location,
            type = 'scatter',
            mode = 'lines',
            colors = unname(unlist(sdi_colours)),
            text = ~paste0("<b>", location, "</b><br>",
                           if (input$sdi_metric_d3 == "Rate") {
                             paste0("Rate: ", round(value, 4), "%")
                           } else {
                             paste0("Deaths: ", scales::comma(round(value)))
                           }),
            hoverinfo = 'text') %>%
      layout(
        title = list(
          text = paste("Pneumonia", input$sdi_metric_d3, "by SDI Group"),
          x = 0.05,
          font = list(size = 16)
        ),
        xaxis = list(title = "Year", tickvals = seq(1980, 2021, 5)),
        yaxis = list(title = if (input$sdi_metric_d3 == "Rate") "Death Rate (%)" else "Number of Deaths"),
        margin = list(t = 120, b = 60),
        height = 600,
        hovermode = "closest",
        legend = list(
          orientation = "h",
          x = 0.5,
          y = 0.95,
          xanchor = "center",
          yanchor = "bottom"
        )
      ) %>%
      config(
        displayModeBarOnHover = TRUE,
        displaylogo = FALSE,
        modeBarButtonsToRemove = c("zoom2d", "pan2d", "select2d", "lasso2d",
                                   "zoomIn2d", "zoomOut2d", "autoScale2d", "resetScale2d", "toImage")
      )
  })
  
  output$regional_rates_d3 <- renderPlotly({
    metric_col <- if (input$who_metric_d3 == "Rate") "Rate" else "Number"
    
    data <- cp %>%
      filter(sex %in% c("Male", "Female"),
             location_type == "WHO Region",
             year %in% c(1980, 2021),
             !is.na(.data[[metric_col]])) %>%
      group_by(location, year) %>%
      summarise(value = mean(.data[[metric_col]], na.rm = TRUE), .groups = "drop") %>%
      mutate(value = if (input$who_metric_d3 == "Rate") value / 1000 else value)
    
    plot_ly(data,
            x = ~location,
            y = ~value,
            color = ~as.factor(year),
            colors = c("1980" = "#9ecae1", "2021" = "#08519c"),
            type = 'bar',
            barmode = 'group',
            hovertemplate = paste(
              "<b>%{x}</b><br>",
              "Year: %{customdata}<br>",
              if (input$who_metric_d3 == "Rate") {
                "Rate: %{y:.4%}"
              } else {
                "Deaths: %{y:,}"
              },
              "<extra></extra>"
            ),
            customdata = ~year,
            hoverinfo = 'text') %>%
      layout(
        title = list(text = "Pneumonia Mortality Across WHO Regions: 1980 vs 2021", x = 0.05),
        yaxis = list(title = if (input$who_metric_d3 == "Rate") "Death Rate (%)" else "Number of Deaths"),
        xaxis = list(title = "WHO Region"),
        margin = list(t = 100),
        hovermode = "closest",
        height = 550
      ) %>%
      config(
        displaylogo = FALSE,
        modeBarButtonsToRemove = c("zoom2d", "pan2d", "select2d", "lasso2d",
                                   "zoomIn2d", "zoomOut2d", "autoScale2d", "resetScale2d", "toImage")
      )
  })
  
}
