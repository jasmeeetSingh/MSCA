library(MLmetrics)
dataPath <- 'C:\\Users\\jasme\\Downloads\\UChicago\\Quarter2\\Linear Non-Linear\\Week8\\nonlinear_models_08_data\\'

dat <- read.table(paste(dataPath,'Week8_Test_Sample.csv',sep = ''), header=TRUE)

mFixedEffects <- lm(Response ~ Predictor1 + Predictor2, data=dat)

fixedEffects <- c(
  mFixedEffects$coefficients[1], 
  sapply(mFixedEffects$coefficients[3:9], function(fe) {
    mFixedEffects$coefficients[1] + fe
  })
)
fixedEffects<-fixedEffects-mean(fixedEffects)

Manual<-aggregate(dat$Response,
                  by=list(dat$Predictor2),
                  function(z) mean(z))$x
(Manual<-Manual-mean(Manual))


mRandomEffects <- lme4::lmer(Response ~ Predictor1+(1|Predictor2), data=dat)
randomEffects <- lme4::ranef(mRandomEffects,condVar=T)

baseLevel<-summary(mRandomEffects)$coefficients[1]
pred<-unique(predict(mRandomEffects))
# cbind(Manual=pred-baseLevel,
#       RandomEffects=randomEffects$Predictor2)

# Kappa = sd(unlist(randomEffects)) / sd(fixedEffects)
Kappa <- unlist(randomEffects) / unlist(fixedEffects)
# mRandomEffects
# coef(mFixedEffects)
lm_lmer_coef <- cbind(0.66732205, 0.1754,  9.16795932 , 9.1598)
colnames(lm_lmer_coef) <- c("interceptLm", "interceptLmer", "slopeLm", "slopeLmer")
lm_lmer_coef

res <- list(fixedEffects = fixedEffects,
            randomEffects = randomEffects,
            Kappa = Kappa,
            lm_lmer_coef = lm_lmer_coef
)
saveRDS(res, file = paste(dataPath,'result.rds',sep = '/'))
dat <- readRDS(paste(dataPath,'result.rds', sep = '/'))
print(dat)