library(dplyr)
library(ggplot2)
library(relimp)
library(relaimpo)

datapath <- 'C:\\Users\\jasme\\Downloads\\UChicago\\Statistical Analysis - Yuri\\Week 8\\statistics_08_data\\'
data <- read.table(paste(datapath,'data.csv',sep = '/'), header=TRUE)

# head(data$Pred2)
# 
# Data.Levels<-as.numeric(data[1,])
# Project.Data <- data[-1,]
# head(Project.Data)
# 
# matplot(Project.Data,type="l")
# Project.Data.PCA <- princomp(Project.Data)
# 
# names(Project.Data.PCA)
# plot(Project.Data.PCA)
# test_dat <- data
# linMod <- lm(Resp~., data=test_dat)
# original.r.squared <- summary(linMod)$r.squared
# original.r.squared
# predictors <- test_dat[,2:11]
# pca <- princomp(predictors)
# summary(pca)
# plot(pca)
# 
# td_rot <- as.data.frame(cbind(Resp=test_dat$Resp, pca$scores))
# linModPCA <- lm(Resp~., data=td_rot)
# 
# calc.relimp(linModPCA)@lmg.rank
# 
# # order <- c(1,3,5,6,4,10,9,7,8,2)
# order = c(3,1,2,4,7,10,8,9,6,5)
# calc.relimp(linModPCA)@lmg.rank[order]
# td_rot_reorder <- td_rot[,c(1,order+1)]


r2s <- sapply(2:11, function(x) {
  summary(lm(Resp~., data=td_rot_reorder[,1:x]))$r.squared
})
r2s >= summary(lm(Resp~., data=test_dat))$r.squared*0.9


order[1:3]