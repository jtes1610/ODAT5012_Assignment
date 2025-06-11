# app/ui_datasource.R
library(shiny)

ui_datasource <- tabPanel(
  "Data & References",
  fluidPage(
    h2("Data Source and Explanation"),
    
    h3("References"),
    tags$ul(
      tags$li(HTML("Institute for Health Metrics and Evaluation (IHME). (2024). Global Burden of Disease Study (2021) Results. Seattle, United States: IHME. Retrieved from <a href='https://ghdx.healthdata.org/gbd-results-tool' target='_blank'>https://ghdx.healthdata.org/gbd-results-tool</a>")),
      tags$li("WHO/UNICEF Estimates of National Immunization Coverage (WUENIC), 2023 Revision (completed 15 July 2024), data from 1980–2023.")
    ),
    
    h3("Data Selection"),
    p("The group had discussions regarding the specific topic that would be explored through Our World in Data. After settling on health as a direction, each group member explored charts and topics through OWID looking for data that might tell an engaging story. Initially, explorations focussed on the biggest killers in terms of diseases, but after some further investigation the group decided that there was an interesting and positive story to be told in the changes in child mortality due to pneumonia over recent decades."),
    p("The data used is from the Institute for Health Metrics and Evaluation’s Global Burden of Disease Study (2024). This was an enormous dataset, with a wide range of filters available for downloading the data with only variables of interest. The group decided to extract only data relating to mortality (absolute and rate) in children (< 5 years old) from the years 1980–2021. Additionally, results were grouped by WHO region and sociodemographic index (SDI), a common index for categorising nations by level of development. With these filters, it was decided that an engaging and telling narrative could likely be told regarding global progress in reducing child mortality due to pneumonia."),
    p("To provide additional context for the narrative that was settled on, additional data regarding immunisation coverage by country was also retrieved. This was sourced from the WHO/UNICEF, with only data relating to the PCV vaccine being included.")
  )
)
