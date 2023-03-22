derivative <- function(FUN, val, projectID, eps=0.0001) {
  y0 = FUN(val, projectID)
  y1 = FUN(val+eps, projectID)
  return( (y1-y0) / (val+eps-val) )
}

taylor_iteration <- function(FUN, val, projectID) {
  val - FUN(val, projectID) / derivative(FUN, val, projectID)
}

my.Optimizer <- function(Start.Value, Function.To.Optimize, Epsilon, projectID) {
  X1 = Start.Value - Function.To.Optimize(Start.Value,projectID) / derivative(Function.To.Optimize, Start.Value, projectID)
  if(Epsilon < (X1 - Start.Value)) {
    return(my.Optimizer(X1, Function.To.Optimize, Epsilon, projectID))
  } else {
    return(X1)
  }
}

my.Function<-function(my.X, projectID) {
  my.X^2*3-my.X*5-6
}


library(dplyr)
library(ggplot2)

dataPath <- 'C:\\Users\\jasme\\Downloads\\UChicago\\Quarter2\\Linear Non-Linear\\Week2\\'
testFunction <- readRDS(paste(datapath,'documents_MScA Linear and Non-Linear Models 31010_MScA 31010 Lecture 2_MScA_Nonlinear_Models_Week2_TestFunction.rds',sep = '/'))$Week2_Test_Function

projectID= 625
testFunction(0,projectID)

X<-seq(from=-5,to=5,by=.1)
Y<-my.Function(X)
plot(X,Y,type="l")
abline(h=0)

my.root = my.Optimizer(-4, my.Function, Epsilon=0.0001, 6)
uniroot.root = uniroot(my.Function,lower=-5,upper=+2)$root
my.root - uniroot.root

my.root = my.Optimizer(-4, testFunction, 0.0001, projectID)
uniroot.root = uniroot(testFunction, lower=-4, upper=1, projectID=projectID)$root

res <- list(Start.Value = -4,
            my.Optimizer.root = my.root,
            uniroot.root = uniroot.root,
            uniroot.lower = -4,
            uniroot.upper = 0)

write.table(res, file = paste(dataPath,'result.csv',sep = '/'), row.names = F)