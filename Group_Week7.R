library(dplyr)
library(ggplot2)
library(zoo)

datapath <- 'C:\\Users\\jasme\\Downloads\\UChicago\\Statistical Analysis - Yuri\\Week 7\\Rolling_Window_Analysis_data\\'
AssignmentData <- read.table(paste(datapath,'test_sample.csv',sep="/"), row.names=1,header=TRUE,sep=",")[,1:8]
head(AssignmentData)

Window.width<-20
Window.shift<-5

all.means<-rollapply(AssignmentData,width=Window.width,
                     by=Window.shift,by.column=TRUE, mean)
head(all.means)

apply(AssignmentData[1:20,],2,mean)
apply(AssignmentData[6:25,],2,mean)

Count<-1:dim(AssignmentData)[1]
Rolling.window.matrix<-rollapply(Count,
                                 width=Window.width,
                                 by=Window.shift,
                                 by.column=FALSE,FUN=function(z) z)
Points.of.calculation<-Rolling.window.matrix[,10]    
Points.of.calculation[1:10]
length(Points.of.calculation)

all.means

AssignmentData1 <-rollapply(AssignmentData,width=Window.width,
                     by=Window.shift,by.column=TRUE, mean)
head(all.means)

model_ = lm(Output1~USGG3M+USGG5YR+USGG30YR, data = all.means)

summary(model_)


# 
# vol_ind = rollapply(AssignmentData1,
#           width=Window.width,
#           by=Window.shift,
#           by.column=FALSE,FUN=sd)
# dates = rollapply(rownames(AssignmentData1),
#             width=Window.width,
#             by=Window.shift,
#             by.column=FALSE, FUN = function(x) x)
# 
# dat = data.frame(dates, vol_ind)
# head(dats)
# dats = filter(dat, (vol_ind >= 0.3))
# 
dates <- read.table(paste(datapath,'dates.csv',sep="/"),header=TRUE)

high.volatility.periods = c()
for (i in dates){
  high.volatility.periods = c(high.volatility.periods, i)
}

head(dats)

res <- list(high.volatility.periods=high.volatility.periods,
            high.slopeSpread.periods=high.volatility.periods,
            high.slope5Y=high.volatility.periods,
            low.r.squared = high.volatility.periods,
            USGG3M_insignificant=high.volatility.periods,
            USGG5Y_insignificant=high.volatility.periods,
            USGG30Y_insignificant=high.volatility.periods)

datapath <- 'C:\\Users\\jasme\\Downloads\\UChicago\\Statistical Analysis - Yuri\\Week 7\\Rolling_Window_Analysis_data\\'
saveRDS(res, file = paste(dataPath,'result.rds',sep = '/'))

dat <- readRDS(paste(dataPath,'result.rds', sep = '/'))
print(dat)
