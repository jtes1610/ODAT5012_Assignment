# Draft 1 UI (ui_draft1.R)
library(shiny)
library(plotly)

ui_draft1 <-tabPanel("Draft 1", fluidPage(add_custom_style,
                     titlePanel("Draft 1 - Original Layout"),
                     
                     h3("Leading Causes of Death in Children Under 5 (1980)"),
                     p("This horizontal bar chart shows the top 10 causes of death for children under 5 years of age in 1980. Pneumonia leads by a wide margin."),
                     plotlyOutput("top10_bar_d1"),
                     tags$div(style="background-color:#f0f0f0; padding:10px; margin-bottom:20px; border-left:4px solid #ccc;",
                              tags$strong("User Feedback:"),
                              tags$ul(
                                tags$li("Too much clutter on chart – remove labels from bars."),
                                tags$li("Simplify to display number only on hover."),
                                tags$li("Improve contrast by switching to darker blue palette match the rest of the theme."),
                                tags$li("Remove unncessary tool options.")
                              )
                     ),
                     
                     h3("Child Mortality by SDI Group"),
                     p("This line chart tracks pneumonia death rates across five sociodemographic index (SDI) groups."),
                     plotlyOutput("global_trend_d1"),
                     radioButtons("sdi_metric_d1", "Metric:", choices = c("Rate", "Number"), inline = TRUE),
                     sliderInput("year_range_d1", "Year Range:", min = 1980, max = 2021, value = c(1980, 2021), step = 1, sep = ""),
                     tags$div(style="background-color:#f0f0f0; padding:10px; margin-bottom:20px; border-left:4px solid #ccc;",
                              tags$strong("User Feedback:"),
                              tags$ul(
                                tags$li("Legend was unordered – correct it to show High to Low SDI."),
                                tags$li("No defintion of what SDI means."),
                                tags$li("Add hover detail and clearer colour progression."),
                                tags$li("Rate was confusing need to show % rounded to 4 decimals."),
                                tags$li("Needs to have a reset buton clearly displayed."),
                                tags$li("UI elements weren't well formatted."),
                                tags$li("Remove unncessary tool options.")
                              )
                     ),
                     
                     h3("Pneumonia Mortality by WHO Region"),
                     p("This grouped bar chart compares pneumonia mortality across WHO regions for 1980 and 2021."),
                     plotlyOutput("regional_rates_d1"),
                     radioButtons("who_metric_d1", "Metric:", choices = c("Rate", "Number"), inline = TRUE),
                     tags$div(style="background-color:#f0f0f0; padding:10px; margin-bottom:20px; border-left:4px solid #ccc;",
                              tags$strong("User Feedback:"),
                              tags$ul(
                                tags$li("The rate and death count values were confusing"),
                                tags$li("Add darker/lighter blue to show temporal difference aligned with theme."),
                                tags$li("Hover to show year and value only."),
                                tags$li("Remove unncessary tool options.")
                              )
                     ),
                     
                     h3("PCV Vaccine Coverage Map"),
                     p("Choropleth map showing global coverage of pneumococcal (PCV) vaccines as of the latest data year."),
                     plotlyOutput("pcv_coverage_d1"),
                     tags$div(style="background-color:#f0f0f0; padding:10px; margin-bottom:20px; border-left:4px solid #ccc;",
                              tags$strong("User Feedback:"),
                              tags$ul(
                                tags$li("Confusing that the lighter colours meant a better % coverage."),
                                tags$li("Remove unncessary tool options.")
                              )
                     )
)
)
