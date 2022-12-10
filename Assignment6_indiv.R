library(dplyr)
library(ggplot2)

datapath <- 'C:\\Users\\jasme\\Downloads\\UChicago\\Statistical Analysis - Yuri\\Week 6\\statistics_06_data\\'
train_dat <- read.table(paste(datapath,'Week6_Test_Sample_Train.csv',sep = '/'), header=TRUE)
ggplot(train_dat, aes(x=Input, y=Output, color=factor(Selection.Sequence))) + geom_point()
TrainingLinear <- lm(Output ~ Input, data=train_dat)

Logistic.Model.Data <- data.frame(
  Output = train_dat$Selection.Sequence, 
  Input = TrainingLinear$residuals
)

Logistic.Model.Training <- glm(Output ~ Input, 
                               data=Logistic.Model.Data,
                               family=binomial(link=logit))

train_dat$Predicted.Probabilities <- predict(Logistic.Model.Training, type='response')

train_dat$Unscramble <- (train_dat$Predicted.Probabilities > 0.5) * 1

main_dat <- read.table(paste(datapath,'Week6_Test_Sample_Test.csv',sep = '/'), header=TRUE)

LinearModel <- lm(Output ~ Input, data=main_dat)

main_dat$Unscramble <- (predict(Logistic.Model.Training, 
                                newdata=data.frame(
                                  Output = LinearModel$residuals,
                                  Input = LinearModel$residuals),
                                type='response') > 0.5) * 1

res <- list(Unscrambling.Sequence.Logistic = main_dat$Unscramble)
write.table(res, file = paste(datapath,'result.csv',sep = '/'), row.names = F)
