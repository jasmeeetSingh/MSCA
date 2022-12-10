library(dplyr)
dataPath <- 'C:\\Users\\jasme\\Downloads\\UChicago\\Statistical Analysis - Yuri\\Week 4\\statistics_04_data\\'
data <- read.table(paste(dataPath,'NewTest.csv', sep = ''), sep = ',', header=TRUE)

x = data$X
y = data$Y

plot(x, y)
Estimated.LinearModel <- lm(y ~ x)
print(Estimated.LinearModel$coefficients)
plot(Estimated.LinearModel$residuals)
fit_values = fitted(Estimated.LinearModel)

summary(Estimated.LinearModel)
Estimated.Residuals <- Estimated.LinearModel$residuals
# plot(Estimated.Residuals, x)

print(Estimated.Residuals)
scrambled0 = c()
scrambled1 = c()
scrambled = c()
for (i in Estimated.Residuals) {
  if (i > 0){
    scrambled1 = c(scrambled1, 1)
    scrambled = c(scrambled, 1)
  }
  else {
    scrambled0 = c(scrambled0, 0)
    scrambled = c(scrambled, 0)
  }
}
plot(scrambled[1:10], type = 's')
res <- list(Unscrambled.Selection.Sequence = scrambled)
write.table(res, file = paste(dataPath,'result.csv',sep = '/'), row.names = F)
