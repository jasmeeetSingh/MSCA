library(dplyr)
library(ggplot2)

dataPath <- 'C:\\Users\\jasme\\Downloads\\UChicago\\Quarter2\\Linear Non-Linear\\Week4\\nonlinear_models_04_data\\'

train_dat <- read.table(paste(dataPath,'Week4_Test_Sample_Train.csv',sep = '/'), header=TRUE)
test_dat <- read.table(paste(dataPath,'Week4_Test_Sample_Test.csv',sep = '/'), header=TRUE)

glm.logit  <- glm(Output ~ ., family = binomial(link = "logit"), data=train_dat)
glm.probit <- glm(Output ~ ., family = binomial(link = "probit"), data=train_dat)

summary(glm.logit)
summary(glm.probit)

drop1(glm.logit)

# Train Data
train_dat$predict_logit <- sapply(predict(glm.logit, newdata=train_dat, type="response") >= 0.5, function(x) if(x) 1 else 0)
train_dat$predict_probit <- sapply(predict(glm.probit, newdata=train_dat, type="response") >= 0.5, function(x) if(x) 1 else 0)

table(train_dat$Output, train_dat$predict_logit)

balancedAccuracy <- function(true_values, predictions) {
  sensitivity = mean(predictions[true_values == 1] == 1)
  specificity = mean(predictions[true_values == 0] == 0)
  0.5 * (sensitivity + specificity)
}
balancedAccuracy(train_dat$Output, train_dat$predict_logit)
balancedAccuracy(train_dat$Output, train_dat$predict_probit)

# Test Data  
Predicted.glm.logit <- predict(glm.logit, newdata=test_dat, type="response")
Predicted.glm.probit <- predict(glm.probit, newdata=test_dat, type="response")

Predicted.Output.logit <- sapply(Predicted.glm.logit > 0.5, function(x) if(x) 1 else 0)
Predicted.Output.probit <- sapply(Predicted.glm.probit > 0.5, function(x) if(x) 1 else 0)

table(Predicted.Output.logit, Predicted.Output.probit)

res <- list(Predicted.Output.logit=Predicted.Output.logit,
            Predicted.Output.probit=Predicted.Output.probit)

write.table(res, file = paste(dataPath, 'result.csv',sep = '/'), row.names = F)