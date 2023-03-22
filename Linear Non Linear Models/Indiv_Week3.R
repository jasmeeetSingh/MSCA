library(dplyr)
library(ggplot2)
 
dataPath <- 'C:\\Users\\jasme\\Downloads\\UChicago\\Quarter2\\Linear Non-Linear\\Week3\\nonlinear_models_03_data\\'
test_data <- read.table(paste(dataPath,'Week3_Test_Sample.csv',sep = '/'), header=TRUE)
plot(rank(test_data[,1])/length(test_data[,1]+1),
     rank(test_data[,2])/length(test_data[,1]+1),xlab="X",ylab="Y")


par(mfrow=c(1,1))
set.seed(13)

Frank.Copula<-frankCopula(param= 13,dim=2)
persp(Frank.Copula, dCopula, main="pdf",xlab="u", ylab="v", zlab="c(u,v)")
contour(Frank.Copula,dCopula, main="pdf",xlab="u", ylab="v")
Simulated.Frank.Copula<-rCopula(5000,Frank.Copula)
SimulatedN<-length(Simulated.Frank.Copula[,1])
plot(Simulated.Frank.Copula,main="Simulated Copula",xlab="Variable 1",ylab="Variable 2")
Empirical.Frank.Copula<-apply(Simulated.Frank.Copula,2,rank)/SimulatedN
plot(Empirical.Frank.Copula,main="Empirical Copula",xlab="Variable 1",ylab="Variable 2")
title("Frank Copula, param=5",outer=TRUE,line=-2)

copula.type="Frank"

copula.fit <- fitCopula(
  copula = copula::frankCopula(),
  data = pobs(test_data, ties.method = "average"),
  method = "ml",
  optim.method = "BFGS"
)
parameter = copula.fit@estimate


frank_conditional_dist = function(theta, alpha, u) {
  -1/theta*log(1-(alpha*(1-exp(-theta)))/(exp(-theta*u)+alpha*(1-exp(-theta*u))))
}

gaussian_condition_dist = function(theta, alpha, u) {
  pnorm(qnorm(alpha)*sqrt(1-theta**2)+theta*qnorm(u))
}

frank_conditional_dist(parameter, 0.5, pobs(test_data, ties.method = "average")[,1])
quantile = frank_conditional_dist(parameter, 0.5, pobs(test_data, ties.method = "average")[,1])

res <- list(copula.type = copula.type,
            parameter =parameter, 
            quantile = quantile) 

# $parameter
# [1] 0.8245078
# 
# $quantile
# [1] 0.447417483 0.718807032 0.714354307 0.604517874 0.269899306 0.847661373 0.065341858 0.603679892 0.048386576 0.685155546 0.698976062 0.765264610 0.066186885

############## CORRECT ####################
# $copula.type
# [1] "Frank"
# 
# $parameter
# [1] 9.950264
# 
# $quantile
# [1] 0.43724490 0.75017005 0.74558035 0.62386769 0.23834929 0.86355145 0.08773179 0.62289339 0.08125357 0.71468134

saveRDS(res, file = paste(dataPath,'result.rds',sep = '/'))
dat <- readRDS(paste(dataPath,'result.rds', sep = '/'))
print(dat)