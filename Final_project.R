levels.data <- read.csv("levels_data.csv")

library(corrplot)
library(dplyr)
# Checking Correlation
corrplot(cor(levels.data),method = "circle")

plot(levels.data$total_comp)

# Linear model with raw data
linear.model <- lm(total_comp~.,data=levels.data)
summary(linear.model)
plot(linear.model$residuals)

levels.data.scaled <- levels.data
str(levels.data.scaled)
levels.data.scaled$title_median_salary <- scale(levels.data.scaled$title_median_salary)
levels.data.scaled$total_yrs_exp <- scale(levels.data.scaled$total_yrs_exp)
levels.data.scaled$company_yrs_exp <- scale(levels.data.scaled$company_yrs_exp)
levels.data.scaled$state_median_income <- scale(levels.data.scaled$state_median_income)

linear.model <- lm(total_comp~.,data=levels.data.scaled)
summary(linear.model)
plot(linear.model$residuals)

# Removing outliers using cooks distance
cooksD <- cooks.distance(linear.model)
influential <- cooksD[(cooksD > (3 * mean(cooksD, na.rm = TRUE)))]
names_of_influential <- names(influential)
outliers <- levels.data[names_of_influential,]
levels.data.without.outliers <- levels.data.scaled %>% anti_join(outliers)

#Removing outliers using positive residuals
linear.model <- lm(total_comp~.,data=levels.data.without.outliers)
summary(linear.model)
plot(linear.model$residuals)
levels.data.without.outliers <- levels.data.without.outliers[linear.model$residuals < (quantile(linear.model$residuals,.75) + 1.5*IQR(linear.model$residuals)),]

# linear.model <- lm(total_comp~.,data=levels.data.without.outliers)
# summary(linear.model)
# plot(linear.model$residuals)
# levels.data.without.outliers <- levels.data.without.outliers[linear.model$residuals > (quantile(linear.model$residuals,.25) - 2*IQR(linear.model$residuals)),]

linear.model <- lm(total_comp~.,data=levels.data.without.outliers)
summary(linear.model)
plot(linear.model$residuals)
plot(linear.model)

# Removing Predictors by AIC
library("MASS")
stepAIC(linear.model,direction = "both")

drops <- c("Engineering","Technology")
levels.data.without.outliers <- levels.data.without.outliers[,!(names(levels.data.without.outliers) %in% drops)]

linear.model <- lm(total_comp~.,data=levels.data.without.outliers)
summary(linear.model)
plot(linear.model$residuals)


