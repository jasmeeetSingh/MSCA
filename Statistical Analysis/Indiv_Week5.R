library(dplyr)
dataPath <- 'C:\\Users\\jasme\\Downloads\\UChicago\\Statistical Analysis - Yuri\\Week 5\\statistics_05_data\\'
data <- read.table(paste(dataPath,'Week5_Test_Sample1.csv', sep = ''), sep = ',', header=TRUE)

x = data$Input
y = data$Output
nSample = length(y)

plot(x, y)
m1 = lm(y ~ x)

residuals = model$residuals
matplot(x,cbind(y,GeneralModel$fitted.values),type="p",pch=16,ylab="Sample and Fitted Values")

steep = c()
x_steep = c()
flat = c()
x_flat = c()

for (i in 1:nSample) {
  if (y[i] > m1$fitted.values[i]) {
    steep = c(steep, y[i])
    x_steep = c(x_steep, x[i])
  }
  if (y[i] <= m1$fitted.values[i]) {
    flat = c(flat, y[i])
    x_flat = c(x_flat, x[i])
  }
}
m2 = lm(steep ~ x_steep)
m3 = lm(flat ~ x_flat)

plot(x, y, type="p",pch=19)
lines(x, m1$fitted.values,col="yellow",lwd=3)
lines(x_steep, m2$fitted.values,col="red",lwd=3)
lines(x_flat,m3$fitted.values, col="green",lwd=3)

res <- list( GeneralModel = m1,mSteep = m2,mFlat = m3)
saveRDS(res, file = paste(dataPath,'result.rds',sep = '/'))