# Draft 2 UI (ui_draft2.R)
library(shiny)
library(shinyBS)
library(plotly)

ui_draft2 <-tabPanel("Draft 2", fluidPage(
  
  add_custom_style,
  titlePanel("Draft 2 - Updated Based on User Feedback"),
  tags$img(
    src = "header_image.png",
    style = "width: 80%; display: block; margin: 0 auto 20px;"
  ),
  p("Authors: Daniel Fry (), Matilda Marriott(),", tags$br(),
    "James Tesoriero (310247934), William Gore (541024079)"),
  
  h3("A World of Bad News — But Quiet Progress"),
  p("If the only source of information about the world were news media, one would be forgiven for feeling as though global suffering is on a smooth upwards trend with war, poverty, natural disasters and sickness spiralling out of control. While it is certainly true that some issues in the world are worsening and will need high-level global collaboration to solve, there are many positive stories and trends that do not often make news media headlines."),
  p("Some monumental positive shifts in health and wellbeing are occurring in regions of the world that are low down on the sociodemographic index (SDI). Nations that are typically associated with poverty, hunger and war. While the narrative of suffering is pervasive, it is not wholly truthful, and remarkable advances have already been made in the developing world. After all, after a long enough time spent ‘developing’, the eventual result must at some point be ‘developed’. While downtrends in sickness and suffering are not often the headlines that make the front page, that does not mean that these trends are not occurring."),
  
  h3("Pneumonia: A Disease of Inequality"),
  p("Throughout history, a leading cause of child mortality has been Pneumonia, with 2.5 million children dying before the age of 5 from this disease in 1980, more than from any other cause. Pneumonia often develops alongside other infections, and is related to a range of conditions that are largely preventable. These conditions tend to have a larger impact on the health of young children, who are less resilient to infection. While pneumonia cases are present in every nation, the greatest impact in terms of mortality is felt in low to middle SDI nations. Some of the conditions which tend to be predictive of higher incidence of pneumonia are; undernutrition, air pollution, poor access to clean water and sanitation as well as a lack of access to appropriate vaccines, all conditions that are associated with lower levels of national development."),
  plotlyOutput("top10_bar_d2"),
  p("When these conditions are combined with other development related factors such as low or missing healthcare infrastructure and access, the result can be high death rates due to largely preventable diseases like pneumonia. In many low income countries, the persistence of the associated risk factors is ultimately a byproduct of poverty and underfunded health systems. In contrast, high income nations with robust healthcare, widespread immunisation programs, and safer living environments see significantly less deaths due to pneumonia in absolute terms, but are still not able to completely eradicate it as a top cause of child mortality."),
  
  h3("A Catalyst for Decline"),
  p("In recent decades, there has been a downward trend in pneumonia deaths among children worldwide. This is not the result of any single breakthrough, but rather the outcome of decades of development that have improved living conditions and healthcare access around the world. Rising GDP in many low and middle income countries has led to better nutrition, safer sanitation, and increased access to healthcare, all of which have contributed to this change. In tandem, improvements in rural healthcare delivery, including the expansion of community health worker programs, have brought timely diagnosis and treatment to previously underserved populations."),
  p("One major catalyst for the reduction of pneumonia caused deaths, however, is the remarkable global collaborations that strove and continue to strive to expand global immunisation programs. Since the year 2000, access to pneumococcal conjugate vaccines (PCV) around the world has been expanded substantially, with the organisation Gavi immunizing over 1 billion children against pneumonia alone. In combination with substantial progress in other measures of development, this additional factor has contributed to further accelerate the decline of pneumonia-associated child mortality."),
  plotlyOutput("pcv_coverage_d2"),
  
  h3("A Promising Trend"),
  p("With all of the developmental changes that have eventuated since the 1980s, combined with the arrival of new vaccines and global efforts to distribute them, the pneumonia-associated child mortality rate worldwide has been plummeting. Within a single lifetime, nations classified as low SDI have experienced a dramatic and still accelerating decline in child mortality due to pneumonia. Where in 1980, nearly one in every 100 children would die of pneumonia in low SDI nations, that number is now down to between 1 and 2 in every thousand. In low-middle SDI nations, where 6 in every 1000 children were dying of pneumonia in 1980, that number has fallen to less than 1 in every 1000."),
  plotlyOutput("global_trend_d2"),
  tags$div(
    tags$strong("SDI Group"),
    tags$span(icon("info-circle"), id = "sdi_info")
  ),
  br(),  # ← add one or two of these
  br(),  # ← add one or two of these
  br(),  # ← add one or two of these
  br(),  # ← add one or two of these
  fluidRow(
    column(4, radioButtons("sdi_metric", "Metric:", choices = c("Rate", "Number"), inline = TRUE)),
    column(4, sliderInput("year_range", "Year Range:", min = 1980, max = 2021, value = c(1980, 2021), step = 1, sep = "")),
    column(4, actionButton("reset_years", "Reset Chart", icon = icon("undo")))
  ),
  textOutput("selected_range_text"),
  p("While the pneumonia associated child mortality rate was not as high in 1980 in middle SDI nations, there have also been similarly remarkable declines in deaths due to pneumonia in these countries. In middle SDI countries, which in many cases are still considered to be developing nations, this number is now as low as 3 deaths in every 10,000 children."),
  
  h3("A Global Success Story"),
  p("In 2021, pneumonia dropped from the first leading cause of child mortality worldwide to the third, with complications and issues in the 28 days following childbirth now the leading cause of child mortality worldwide. Pneumonia still being ranked so highly may make it seem as though progress in handling this disease has been minimal, however, in 1980 diarrheal diseases and pneumonia combined accounted for more deaths than the top 20 leading causes of child mortality in 2021. In absolute terms, 2 million less children died due to pneumonia in 2021 than did in 1980; a monumental achievement in wellbeing."),
  p("While there is still a long way to go before low to middle SDI nations have pneumonia associated child mortality rates as low as their wealthier counterparts, it is a good exercise in positivity to take a moment to reflect on what these reductions in death rate mean in children’s lives saved. In Africa, 140,000 less children died of pneumonia in 2021 than in 1980; in the Western Pacific Region, 211,000 less children died in 2021 than in 1980, and in South-East Asia 398,000 less children died in 2021 than in 1980."),
  p("In these three regions alone, two thousand less children are dying of pneumonia every day than in 1980."),
  plotlyOutput("regional_rates_d2"),
  radioButtons("who_metric", "Metric:", choices = c("Rate", "Number"), inline = TRUE),
  
  h3("Where to Next?"),
  p("Pneumonia remains the single largest infectious cause of death in children worldwide. But we know what works. Vaccination, better nutrition, stronger health systems—these tools are proven."),
  p("Global collaboration has already shown that dramatic progress is possible. Continued investment can push this trend even further. With the right support, the next generation of children could grow up in a world where no child dies of a preventable disease like pneumonia."),
  
  bsTooltip("sdi_info", "SDI = Sociodemographic Index: a measure combining income, education, and fertility", placement = "right")
)
)