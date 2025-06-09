library(shiny)
library(shinyBS)
library(plotly)

ui <- navbarPage(
  "Child Mortality Article Viewer",
  
  # --- Draft 1 ---
  tabPanel("Draft 1",
           fluidPage(
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
  ),
  
  # --- Draft 2 ---
  tabPanel("Draft 2",
           fluidPage(
             titlePanel("Draft 2 - Updated Based on User Feedback"),
             
             h3("1. A World of Bad News — But Quiet Progress"),
             p("If we relied solely on the headlines, it would be easy to believe the world is constantly spiralling into chaos. War, poverty, climate disasters, and disease dominate the news cycle. But the data tells a different story—one of quiet, sustained progress, especially in public health."),
             p("Some of the most significant improvements have taken place in low-income countries. These are regions typically overlooked in narratives about progress, yet they have seen remarkable strides in child health outcomes. The story of pneumonia, long the leading infectious killer of children under five, illustrates this quiet transformation."),
             
             h3("2. Pneumonia: A Disease of Inequality"),
             p("In 1980, pneumonia claimed the lives of 2.5 million children under five—more than any other cause. It is a disease that thrives in conditions linked to poverty: malnutrition, poor air quality, lack of access to clean water, limited healthcare infrastructure, and missing vaccinations. These factors converge most heavily in low and lower-middle SDI (Sociodemographic Index) countries."),
             p("While pneumonia affects children in every region of the world, the burden is not equally shared. The highest death rates are concentrated in areas with the weakest health systems and the fewest resources to prevent or treat infection."),
             plotlyOutput("top10_bar_d2"),
             p("In high-income countries, pneumonia is still a serious health concern—but one that is rarely fatal. Widespread immunisation, better nutrition, and robust healthcare systems have significantly reduced the risk. In contrast, children in low-income regions continue to die from this largely preventable disease."),
             
             h3("3. Development and the Decline of Pneumonia"),
             p("Since 1980, global child mortality from pneumonia has declined dramatically. This progress hasn’t come from a single innovation, but from many overlapping efforts: economic development, expanded healthcare access, improvements in sanitation, and better nutrition."),
             p("A major turning point was the expansion of pneumococcal conjugate vaccines (PCVs) after 2000. Organisations like Gavi have helped deliver more than one billion vaccine doses, protecting children who previously had little or no access to life-saving immunisations. Combined with broader development trends, this global collaboration has sharply accelerated the decline of pneumonia deaths."),
             plotlyOutput("pcv_coverage_d2"),
             
             h3("4. A Promising Trend"),
             p("The results speak for themselves. In low SDI countries, the pneumonia mortality rate for children under five has dropped from nearly 1 in 100 in 1980 to fewer than 2 in 1,000 today. In low-middle SDI nations, the rate has declined from 6 in 1,000 to less than 1 in 1,000."),
             p("Middle SDI countries, though starting from a lower baseline, have also seen impressive improvements. Pneumonia now causes fewer than 3 deaths per 10,000 children in these regions."),
             plotlyOutput("global_trend_d2"),
             tags$div(
               tags$strong("SDI Group"),
               tags$span(icon("info-circle"), id = "sdi_info")
             ),
             fluidRow(
               column(4, radioButtons("sdi_metric", "Metric:", choices = c("Rate", "Number"), inline = TRUE)),
               column(4, sliderInput("year_range", "Year Range:", min = 1980, max = 2021, value = c(1980, 2021), step = 1, sep = "")),
               column(4, actionButton("reset_years", "Reset Chart", icon = icon("undo")))
             ),
             textOutput("selected_range_text"),
             
             h3("5. A Global Success Story"),
             p("In 2021, pneumonia dropped to the third leading cause of child mortality worldwide, overtaken by complications related to childbirth. That change doesn’t mean pneumonia is no longer a concern—it still kills far too many children—but it does highlight just how far we’ve come."),
             p("Compared to 1980, two million fewer children died from pneumonia in 2021. That’s not just a statistic—it’s a signal of progress, and a reminder of what's possible when the world prioritises equitable health outcomes."),
             p("The regional impact is just as striking:"),
             tags$ul(
               tags$li("Africa: 140,000 fewer deaths in 2021 than in 1980"),
               tags$li("Western Pacific: 211,000 fewer deaths"),
               tags$li("South-East Asia: 398,000 fewer deaths"),
               tags$li("Across just these three regions, 2,000 fewer children are dying of pneumonia every single day.")
             ),
             plotlyOutput("regional_rates_d2"),
             radioButtons("who_metric", "Metric:", choices = c("Rate", "Number"), inline = TRUE),
             
             h3("6. Where to Next?"),
             p("Pneumonia remains the single largest infectious cause of death in children worldwide. But we know what works. Vaccination, better nutrition, stronger health systems—these tools are proven."),
             p("Global collaboration has already shown that dramatic progress is possible. Continued investment can push this trend even further. With the right support, the next generation of children could grow up in a world where no child dies of a preventable disease like pneumonia."),
             
             bsTooltip("sdi_info", "SDI = Sociodemographic Index: a measure combining income, education, and fertility", placement = "right")
           )
  )
)