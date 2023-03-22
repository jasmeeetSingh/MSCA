library(MLmetrics)
dataPath <- 'C:\\Users\\jasme\\Downloads\\UChicago\\Quarter2\\Linear Non-Linear\\Week7\\nonlinear_models_07_data'

test_dat <- read.table(paste(dataPath,'Week7_Test_Sample_Test.csv',sep = '/'), header=TRUE)
train_dat <- read.table(paste(dataPath,'Week7_Test_Sample_Train.csv',sep = '/'), header=TRUE)

polr.fit <- MASS::polr(factor(train_dat$Y) ~ ., data=train_dat)
multinom.fit <- nnet::multinom(train_dat$Y ~ ., data=train_dat)

predicted.prob.polr.train <- predict(polr.fit, newdata = train_dat, type='probs')
predicted.prob.multinom.train <- predict(multinom.fit, newdata = train_dat, type='probs')

log.loss.polr.train <- MLmetrics::MultiLogLoss(predicted.prob.polr.train, train_dat$Y)
log.loss.multinom.train <- MLmetrics::MultiLogLoss(predicted.prob.multinom.train, train_dat$Y)

predicted.prob <- predict(multinom.fit, newdata = test_dat, type='probs')

res <- list(predicted.prob=predicted.prob,
            log.loss.polr.train=log.loss.polr.train,
            log.loss.multinom.train=log.loss.multinom.train)
saveRDS(res, file = paste(dataPath,'result.rds',sep = '/'))