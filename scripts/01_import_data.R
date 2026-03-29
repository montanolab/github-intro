# The Janitor script
#
# field data is messy, and needs lots of processing, BUT...
# raw data should never be overwritten, processing should be separate & programmatic
#
# how did raw data become analysis data?

library(tidyverse)
# install.packages("palmerpenguins")
library(palmerpenguins)
# install.packages("janitor")
library(janitor)

View(penguins_raw)

# load raw Palmer Penguins data
# clean column names + select only necessary columns
# remove missing values/rows
# let's convert grams to kilograms
penguins_clean <- penguins_raw |> 
  janitor::clean_names() |> 
  # get year from date
  mutate(year = as_date(date_egg) |> year()) |> 
  select(species, island, flipper_length_mm, body_mass_g, sex, year) |> 
  filter(!is.na(body_mass_g),
         !is.na(flipper_length_mm)) |> 
  mutate(body_mass_kg = body_mass_g/1000)

write_csv(penguins_clean,
          file = "data/processed_for_analysis.csv")
