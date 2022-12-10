marginal_function = function(data, column) {
  distinctValues = sort(unique(column))
  totalNumberOfRows = nrow(data)
  marginal = c()
  for (x in distinctValues) {
    numberOfValues = nrow(data[column == x,])
    marginal = c(marginal, numberOfValues/numberOfRows)
  }
  return (marginal)
}

library(dplyr)
dataPath <- 'C:\\Users\\jasme\\Downloads\\UChicago\\Statistical Analysis - Yuri\\Conditional_Distribution_Class_data\\'
data <- read.table(paste(dataPath,'test_sample.csv', sep = ''), sep = ',', header=TRUE)

u = data$u
v = data$v
w = data$w

u_Marginal = marginal_function(data, u)
v_Marginal = marginal_function(data, v)
w_Marginal = marginal_function(data, w)
print(u_Marginal)
print(v_Marginal)
print(w_Marginal)

uniqueU = sort(unique(u))
uniqueV = sort(unique(v))
uniqueW = sort(unique(w))

condProbabVWU1 = c()
for (i in uniqueW) {
  for (j in uniqueV) {
    numberRows = nrow(filter(data, (u == 1 & v == j & w == i)))
    numberRowsU = nrow(filter(data, (u == 1)))
    condProbabVWU1 = c(condProbabVWU1, numberRows/numberRowsU)
  }
}
joint_distribution = matrix(condProbabVWU1, nrow = length(uniqueV), ncol = length(uniqueW), byrow = TRUE)
print(joint_distribution)

condProbabU1 = c()
for (i in uniqueV) {
  numberRows = nrow(filter(data, (u == 1 & v == i)))
  numberRowsU = nrow(filter(data, (u == 1)))
  condProbabU1 = c(condProbabU1, numberRows/numberRowsU)
}
print(condProbabU1)

condProbabWV2U1 = c()
for (j in uniqueW) {
  numberRows = nrow(filter(data, (u == 1 & v == 2 & w == j)))
  numberRowsUV = nrow(filter(data, (u == 1 & v == 2)))
  condProbabWV2U1 = c(condProbabWV2U1, numberRows/numberRowsUV)
}
print(condProbabWV2U1)

res<- list(vMarginal = v_Marginal,
           uMarginal = u_Marginal,
           wMarginal = w_Marginal,
           cond1 = joint_distribution, 
           cond2 = condProbabU1,
           cond3 = condProbabWV2U1)

saveRDS(res, file = paste(dataPath,'result.rds',sep = '/'))

dat <- readRDS(paste(dataPath,'result.rds', sep = '/'))
print(dat)