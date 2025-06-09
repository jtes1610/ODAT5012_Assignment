### global.R

# Load libraries
library(shiny)
library(shinyBS)
library(tidyverse)
library(plotly)
library(readr)
library(leaflet)

# Load child pneumonia dataset
cp <- read_csv("data/cp_wide_classified.csv")

# Load and rename PCV vaccine coverage columns
pcv <- read_csv("https://ourworldindata.org/grapher/diphtheria-tetanus-pertussis-vaccine-vs-pneumococcal-vaccine-coverage.csv?v=1&csvType=full&useColumnShortNames=true") %>%
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

# Add custom CSS for layout and spacing
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

    p {
      margin-bottom: 20px;
    }

    ul {
      margin-bottom: 20px;
    }

    .plotly {
      margin-top: 40px;
      margin-bottom: 40px;
    }

    .modebar {
      top: 50px !important;
    }
  "))
)
