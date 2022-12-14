library(dplyr)
library(ggplot2)

datapath <- 'C:\\Users\\jasme\\Downloads\\UChicago\\Statistical Analysis - Yuri\\Week 7\\statistics_07_data\\'
data <- read.table(paste(datapath,'Week7_Test_Sample.csv',sep = '/'), header=TRUE)

head(data)
Output = data$Output
Input1 = data$Input1
Input2 = data$Input2
Regression.ANOVA.Data = data

fit.1<-lm(Output~1,data=Regression.ANOVA.Data)
fit.1.2<-lm(Output~1+Input1,data=Regression.ANOVA.Data)
fit.1.3<-lm(Output~1+Input2,data=Regression.ANOVA.Data)
fit.1.2.3<-lm(Output~.,data=Regression.ANOVA.Data)

anova(fit.1.2)
anova(fit.1.3)

drop1(fit.1.2.3)
anova(fit.1, fit.1.2.3)