## Clean global environment and free space
rm(list = ls())
gc()

## Load packages and install if needed
pck <- c("ggplot2") ## vector with needed package

lapply(pck, function(pkg)
{
  if (!requireNamespace(pkg, quietly = T)) ##if R can not find the package
    install.packages(pkg) ## it installs
  suppressPackageStartupMessages(library(pkg, character.only = TRUE)) ## load the package
})
  
## Create survival dummy data
surv_dat <-data.frame(size_t0 = c(22, 5, 30, 15, 45, 40, 14, 42, 2, 38, 35, 10, 25), 
                      survival = c(1, 0, 1, 0, 1, 0, 1, 1, 0, 1, 0, 1, 1))

## run the model on the data
glm(survival ~ size_t0, data = surv_dat, family = "binomial") %>% summary()

## Visualize with ggplot
survival_example <- ggplot(surv_dat, aes(x = size_t0, y = survival)) + 
  geom_point() +
  geom_smooth(method = "glm", method.args = list(family = "binomial"), se = F) +
  labs(x = "Size at t0", y = "Probability of survival") +
  theme_minimal() +
  theme(panel.grid = element_blank(), 
        axis.line = element_line(color = "black"), axis.ticks = element_line(color = "black"), 
        axis.text = element_text(size = 12), axis.title = element_text(size = 15), 
        legend.text = element_text(size = 12), legend.title = element_text(size = 14))

survival_example

