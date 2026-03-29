# The Artist script
#
# communicate the results
# separate Art from Science

library(tidyverse)

# load results
penguins_clean <- read_csv("data/processed_for_analysis.csv")
model_pred <- read_csv("outputs/model_predictions.csv")


# create plot
penguins_plot <- ggplot() +
  # Raw Data Points
  geom_point(data = penguins_clean, 
             aes(x = flipper_length_mm, y = body_mass_g, color = species), 
             alpha = 0.3) +
  # Model Prediction Lines
  geom_line(data = model_pred, 
            aes(x = flipper_length_mm, y = predicted_mass, color = species), 
            linewidth = 1.2) +
  labs(title = "Model-Based Predictions",
       subtitle = "Lines generated via predict() from saved .rds model",
       x = "Flipper Length (mm)",
       y = "Body Mass (g)") +
  # scale_color_brewer(palette = "Set2") +
  theme_minimal()


# save plot
ggsave(filename = "outputs/model_plot.png", plot = penguins_plot, 
       dpi = 300, width = 8, height = 6)
