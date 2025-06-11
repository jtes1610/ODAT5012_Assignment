library(shiny)
library(shinyBS)
library(plotly)
library(shinyhelper)
library(bsplus)

ui_final <- tabPanel("Article", fluidPage(
  
  add_custom_style,
  
  tags$head(
    tags$style(HTML(".tooltip-inner { max-width: 300px; }"))
  ),
  
  #titlePanel("Article Title"),
  
  tags$img(
    src = "header_image.png",
    style = "width: 80%; display: block; margin: 0 auto 20px;"
  ),
  
  p("Authors: Daniel Fry (550847335), Matilda Marriott(480269964),", tags$br(),
    "James Tesoriero (310247934), William Gore (541024079)"),
  
  h3("A World of Bad News — But Quiet Progress"),
  p("If the only source of information about the world were news media, one would be forgiven for feeling as though global suffering is on a smooth upwards trend with war, poverty, natural disasters and sickness spiralling out of control. While it is certainly true that some issues in the world are worsening and will need high-level global collaboration to solve, there are many positive stories and trends that do not often make news media headlines."),
  p("Some monumental positive shifts in health and wellbeing are occurring in regions of the world that are classified as low on the sociodemographic index (SDI). These are nations that have historically been ravaged by poverty, hunger and war, and are still commonly associated with this. While this narrative of suffering is pervasive, it is not entirely truthful, and remarkable progress has been made in large swathes of the developing world. After all, with enough time spent ‘developing’, the eventual result should eventually be ‘developed’. While downtrends in sickness and suffering are not often the headlines that make the front page, that does not mean that these trends are not occurring."),
  
  h3("Pneumonia: A Disease of Inequality"),
  p("Throughout history, a leading cause of child mortality has been Pneumonia, with 2.5 million children dying before the age of 5 from this disease in 1980, more than from any other cause. Pneumonia often develops alongside other infections, and is related to a range of conditions that are largely preventable. These conditions tend to have a larger impact on the health of young children, who are less resilient to infection. While pneumonia cases are present in every nation, the greatest impact in terms of mortality is felt in low to middle SDI nations. The major conditions which tend to be predictive of higher incidence of pneumonia are; undernutrition, air pollution, poor access to clean water and sanitation as well as a lack of access to appropriate vaccines, all conditions that are associated with lower levels of national development."),
  
  # Horizontal bar chart here
  plotlyOutput("top10_bar_d3"),
  p("When these conditions are combined with other development related factors such as low or missing healthcare infrastructure and access, the result can be high death rates due to largely preventable diseases like pneumonia. In many low income countries, the persistence of the associated risk factors is ultimately a byproduct of poverty and underfunded health systems. In contrast, high income nations with robust healthcare, widespread immunisation programs, and safer living environments see significantly less deaths due to pneumonia in absolute terms, but are still not able to completely eradicate it as a top cause of child mortality."),
  
  h3("A Catalyst for Decline"),
  p("In recent decades, there has been a downward trend in pneumonia deaths among children worldwide. This is not the result of any single breakthrough, but rather the outcome of decades of development that have improved living conditions and healthcare access around the world. Rising GDP in many low and middle income countries has led to better nutrition, safer sanitation, and increased access to healthcare, all of which have contributed to this change. In tandem, improvements in rural healthcare delivery, including the expansion of community health worker programs, have brought timely diagnosis and treatment to previously underserved populations."),
  p("One major catalyst for the reduction of pneumonia caused deaths, however, is the remarkable global collaborations that strove and continue to strive to expand global immunisation programs. Since the year 2000, access to pneumococcal conjugate vaccines (PCV) around the world has been expanded substantially, with the organisation Gavi immunizing over 1 billion children against pneumonia alone. In combination with substantial progress in other measures of development, this additional factor has contributed to further accelerate the decline of pneumonia-associated child mortality."),
  
  # Vaccination coverage map
  tags$div(
    style = "position: relative;",
    plotlyOutput("pcv_coverage_d3"),
    tags$div(
      style = "position: absolute; top: 78%; left: 86%; cursor: help; z-index: 1000;",
      icon("exclamation-circle", id = "pcv_note_icon", style = "font-size:18px; color:#FF0000;") %>%
        bs_embed_tooltip(
          "Note: Countries shown in white have no available data for PCV coverage.",
          placement = "left",
          trigger   = "hover"
        )
    )
  ),
  
  h3("A Promising Trend"),
  p("With all of the developmental changes that have eventuated since the 1980s, combined with the arrival of new vaccines and global efforts to distribute them, the pneumonia-associated child mortality rate worldwide has been plummeting. Within a single lifetime, low SDI nations have experienced a dramatic and still accelerating decline in child mortality due to pneumonia."),
  p("Where in 1980, nearly one in every 100 children would die of pneumonia in low SDI nations; that number is now down to between 1 and 2 in every thousand. In low-middle SDI nations, where 6 in every 1000 children were dying of pneumonia in 1980; that number has fallen to less than 1 in every 1000."),
  p("Although the pneumonia associated child mortality rate in middle SDI countries was not as high in 1980 as it was in low SDI countries, these nations have also experienced significant declines in mortality. Today, middle-SDI countries, which in many cases are still classified as developing nations, have reduced this rate to as low as 3 deaths per 10,000 children"),
  
  # Pneumonia child death rate time-series plot
  plotlyOutput("global_trend_d3"),
  br(), br(), br(), br(),
  fluidRow(
    column(6,
           radioButtons(
             "sdi_metric_d3",
             "Metric:",
             choices  = c("Rate", "Number"),
             selected = "Rate",
             inline   = TRUE
           )
    ),
    br(), 
    column(6,
           icon("question-circle", id = "sdi_info_d3", style = "margin-left:6px; cursor:help; color:#FF0000;") %>%
             bs_embed_tooltip(
               title     = "SDI = Sociodemographic Index: combines income, education and fertility.",
               placement = "right",
               trigger   = "hover"
             )
    )
  ),
  
  h3("A Global Success Story"),
  p("In 2021, pneumonia dropped from the first leading cause of child mortality worldwide to the third, with complications and issues in the 28 days following childbirth now the leading cause of child mortality worldwide. Pneumonia still being ranked so highly may make it seem as though progress in handling this disease has been minimal, however, in 1980 diarrheal diseases and pneumonia combined accounted for more deaths than the top 20 leading causes of child mortality in 2021. In absolute terms, 2 million less children died due to pneumonia in 2021 than did in 1980; a monumental achievement in wellbeing."),
  p("While there is still a long way to go before low to middle SDI nations have pneumonia associated child mortality rates as low as their wealthier counterparts, it is a good exercise in positivity to take a moment to reflect on what these reductions in death rate mean in children’s lives saved. In Africa, 140,000 less children died of pneumonia in 2021 than in 1980; in the Western Pacific Region, 211,000 less children died in 2021 than in 1980, and in South-East Asia 398,000 less children died in 2021 than in 1980."),
  p("In these three regions alone, two thousand less children are dying of pneumonia every day than were doing so in 1980."),
  
  # Comparison by region 1980 vs 2024
  plotlyOutput("regional_rates_d3"),
  radioButtons("who_metric_d3", "Metric:", choices = c("Rate", "Number"), inline = TRUE),
  
  h3("Where to Next?"),
  p("Pneumonia remains the single largest infectious cause of death in children worldwide. But the data proves that we know what works — and that global collaboration can shift what’s possible."),
  p("By continuing to invest in vaccines, education and health systems, we can accelerate this progress and ensure no child dies from a preventable disease.")
  
))
