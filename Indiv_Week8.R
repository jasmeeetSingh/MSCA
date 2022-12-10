library(dplyr)
library(ggplot2)

datapath <- 'C:\\Users\\jasme\\Downloads\\UChicago\\Statistical Analysis - Yuri\\Week 8\\statistics_08_data\\'
dat <- read.table(paste(datapath,'Week8_Test_Sample.csv',sep = '/'), header=TRUE)

library(faraway)

head(dat)
head(coagulation)
# 
# summaryByGroup<-aggregate(coag~diet,data=coagulation,FUN=summary)
# means<-cbind(Means=summaryByGroup$coag[,4],Sizes=aggregate(coag~diet,data=coagulation,FUN=length)$coag)
# rownames(means)<-as.character(summaryByGroup$diet)
# means
# 
# model <- lm(coag~diet, data=coagulation)
# modelSummary <- summary(model)
# modelANOVA <- anova(model)

# modelSummary$coefficients

fit.1 <- lm(Output ~ Treatment, data=dat) # utility test
fit.2 <- lm(Output~Treatment-1, data=dat) # compare to 0 test

anova(fit.1)
anova(fit.2)

# summary(anova(fit.1, fit.2))
