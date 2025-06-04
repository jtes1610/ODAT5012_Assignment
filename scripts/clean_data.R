library(dplyr)
library(readr)
library(tidyr)

# Read raw data
cp <- read_csv("data/child_pneumonia.csv")

# Define location classification groups
health_system <- c("Advanced Health System", "Basic Health System", 
                   "Limited Health System", "Minimal Health System")

wb_region <- c("East Asia & Pacific - WB", "Europe & Central Asia - WB", 
               "Latin America & Caribbean - WB", "Middle East & North Africa - WB", 
               "North America", "South Asia - WB", "Sub-Saharan Africa - WB")

who_region <- c("African Region", "Eastern Mediterranean Region", "European Region", 
                "Region of the Americas", "South-East Asia Region", "Western Pacific Region")

four_world <- c("Africa", "America", "Asia", "Europe")

sdi_group <- c("Low SDI", "Low-middle SDI", "Middle SDI", "High-middle SDI", "High SDI")

# Classify each location
location_classification <- cp %>%
  distinct(location) %>%
  mutate(
    location_type = case_when(
      location %in% health_system ~ "Health System",
      location %in% wb_region ~ "World Bank Region",
      location %in% who_region ~ "WHO Region",
      location %in% four_world ~ "World Region (4)",
      location %in% sdi_group ~ "SDI Group",
      TRUE ~ "Country"
    )
  )

# Pivot Number/Rate wider
cp_wide <- cp %>%
  select(location, year, sex, metric, val) %>%
  pivot_wider(names_from = metric, values_from = val) %>%
  left_join(location_classification, by = "location")

# Save cleaned output
write_csv(cp_wide, "data/cp_wide_classified.csv")
