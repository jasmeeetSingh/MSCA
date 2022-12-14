library(dplyr)
dataPath <- 'C:\\Users\\jasme\\Downloads\\UChicago\\Statistical Analysis - Yuri\\Week 2\\statistics_02_data'
data <- read.table(paste(dataPath,'Week2_Test_Sample.csv',sep = '/'), header=TRUE)

x = data$x
y = data$y

sd_x = (round(sd(x), 2))
sd_y = (round(sd(y), 2))
corr = (round(cor(x, y), 2))

a = round(corr * (sd_y / sd_x), 3)

result <- data.frame(sdX=sd_x, sdY=sd_y, cXY=corr, a=a)
write.table(result, file = paste(dataPath,'result.csv',sep = '/'), row.names = F)


