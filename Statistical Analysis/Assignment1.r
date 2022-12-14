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

# install.packages("dplyr")
library(dplyr)
dataPath <- 'C:\\Users\\jasme\\Downloads\\UChicago\\Statistical Analysis - Yuri\\Week 1'
data <- read.table(paste(dataPath,'Week1_Test_Sample.csv',sep = '/'), header=TRUE)
u = data$u
v = data$v
totalNumberOfRows = nrow(data)

uniqueU = sort(unique(u))
uniqueV = sort(unique(v))

matrix_init = c()
for (i in uniqueU) {
  for (j in uniqueV) {
    numberRows = nrow(filter(data, (u == i & v == j)))
    matrix_init = c(matrix_init, numberRows/totalNumberOfRows)
    print(paste(i, j,numberRows))
  }
}

joint_distribution = matrix(matrix_init, nrow = length(uniqueU), ncol = length(uniqueV), byrow = TRUE)
print(joint_distribution)

u_Marginal = marginal_function(data, u)
v_Marginal = marginal_function(data, v)
print(u_Marginal)
print(v_Marginal)

# Conditional Probability
condProbabV4 = c()
for (i in uniqueU) {
  numberRows = nrow(filter(data, (u == i & v == 4)))
  numberRowsV = nrow(filter(data, (v == 4)))
  condProbabV4 = c(condProbabV4, numberRows/numberRowsV)
}
print(condProbabV4)

condProbabU3 = c()
for (i in uniqueV) {
  numberRows = nrow(filter(data, (u == 3 & v == i)))
  numberRowsU = nrow(filter(data, (u == 3)))
  condProbabU3 = c(condProbabU3, numberRows/numberRowsU)
}
print(condProbabU3)

res <-list(Joint_distribution=joint_distribution,
           u_Marginal = u_Marginal,
           v_Marginal = v_Marginal,
           u_Conditional_v = condProbabV4,
           v_Conditional_u = condProbabU3)

saveRDS(res, file = paste(dataPath,'result.rds',sep = '/'))

dat <- readRDS(paste(dataPath,'result.rds', sep = '/'))
print(dat)