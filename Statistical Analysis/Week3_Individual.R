library(dplyr)
dataPath <- 'C:\\Users\\jasme\\Downloads\\UChicago\\Statistical Analysis - Yuri\\Week 3\\statistics_03_data\\'
data <- read.table(paste(dataPath,'Week3_Test_Sample.csv', sep = ''), sep = ',', header=TRUE)

mean_normal = data$x[1]
std_normal = data$x[2]
intensity_exponential = data$x[3]
dat = data$x[4:503]
mean
std
intensity
summary(dat)

# dataExp = -((log(1 - dat, base = exp(1))/intensity_exponential))

datNorm = qnorm(dat, mean = mean_normal, sd = std_normal)
datExp = qexp(dat, rate = intensity_exponential)

plot(sort(datNorm), type = 'l')
# plot(sort(datExp), type = 'l')

res<-cbind(datNorm=datNorm,datExp=datExp)
write.table(res, file = paste(dataPath,'result.csv',sep = '/'), row.names = F)