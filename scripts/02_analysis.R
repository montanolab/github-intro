# The Stats script
#
# the actual analysis, should only use processed data
#
# evolution often involves simple changes to modelling
# nothing else needs to change

# Q: Does flipper length predict body mass across penguin species?
# Goal: Model the relationship between flipper length and mass

library(tidyverse)
library(broom) # for tidying model outputs


# running the model ###

# load the processed data
penguins_clean <- read_csv("data/processed_for_analysis.csv")

# run the linear model
mass_model <- lm(body_mass_g ~ flipper_length_mm + species, 
                 data = penguins_clean)

# summarise model results
model_results <- broom::tidy(mass_model, conf.int = TRUE)

# save results for downstream use or reporting
write_csv(model_results, "outputs/model_summary.csv")


# get model predictions for plotting ###

# 'prediction grid' to predict over
model_pred <- penguins_clean %>%
  group_by(species) %>%
  summarise(flipper_min = min(flipper_length_mm),
            flipper_max = max(flipper_length_mm)) %>%
  rowwise() %>%
  # for each species, need to predict over 100 values of flipper length
  reframe(species = species,
          flipper_length_mm = seq(flipper_min, flipper_max, length.out = 100))

# get model predictions
model_pred$predicted_mass <- predict(mass_model, newdata = model_pred)

# save for downstream use or reporting
write_csv(model_pred, "outputs/model_predictions.csv")
