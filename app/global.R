# global.R

# Load required libraries
library(shiny)
library(tidyverse)
library(plotly)
library(readr)
library(leaflet)
library(tidyr)
library(bsplus)   # for bs_embed_tooltip()
library(DiagrammeR)

# Load child pneumonia dataset
cp <- read_csv("data/cp_wide_classified.csv")

# Load and rename PCV vaccine coverage columns
pcv <- read_csv(
  "https://ourworldindata.org/grapher/diphtheria-tetanus-pertussis-vaccine-vs-pneumococcal-vaccine-coverage.csv?v=1&csvType=full&useColumnShortNames=true"
) %>%
  rename(
    PCV = coverage__antigen_pcv3,
    DTP = coverage__antigen_dtpcv3
  )

# Create top 10 causes of under-5 death data frame
top_causes <- tibble::tibble(
  cause = c(
    "Pneumonia", 
    "Diarrheal diseases", 
    "Neonatal preterm birth", 
    "Congenital birth defects", 
    "Neonatal asphyxia & trauma", 
    "Measles", 
    "Nutritional deficiencies", 
    "Malaria", 
    "Other neonatal disorders", 
    "Neonatal sepsis & infections"
  ),
  deaths = c(
    2510000, 
    2240000, 
    1440000, 
    916838, 
    883253, 
    697689, 
    603141, 
    431847, 
    379039, 
    303686
  )
)

# Custom CSS
add_custom_style <- tags$head(
  tags$style(HTML("
    body {
      font-family: 'Georgia', serif;
      font-size: 17px;
      line-height: 1.7;
      color: #333;
      background-color: #fff;
      max-width: 750px;
      margin: 0 auto;
      padding: 20px;
    }

    h3 {
      font-size: 26px;
      font-weight: bold;
      margin-top: 40px;
      margin-bottom: 20px;
      color: #111;
    }

    p, ul {
      margin-bottom: 20px;
    }

    /* bring the chart up so the modebar sits inside */
    .plotly {
      margin-top: 20px !important;
      margin-bottom: 60px;
      position: relative;
    }

    /* position the toolbar at the very top of the plot */
    .plotly .modebar-container {
      position: absolute !important;
      top: 0px         !important;
      right: 0px       !important;
      z-index: 10;
    }

    /* light background for contrast */
    .modebar {
      background-color: rgba(255,255,255,0.9) !important;
    }

    /* red icons */
    .modebar-btn path {
      stroke: #FF0000 !important;
      fill:   #FF0000 !important;
    }

    /* darker red on hover */
    .modebar-btn:hover path {
      stroke: #CC0000 !important;
      fill:   #CC0000 !important;
    }
  "))
)
