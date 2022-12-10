#https://rpubs.com/aaronsc32/linear-congruential-generator-r
lcg.rand <- function(n) {
  rng = vector(length = n)
  m = 2 ** 32
  a = 1103515245
  c = 12345
  # Set the seed using the current system time in microseconds
  d = as.numeric(Sys.time()) * 1000
  for (i in 1:n) {
    d <- (a * d + c) %% m
    rng[i] <- d / m
  }
  return(rng)
}


library(random)

sampleSize = 1000
dataFromRandom<-randomNumbers(n=sampleSize, min=-1000, max=1000, col=1, base=10, check=TRUE)
head(dataFromRandom)

# Print 10 random numbers on the half-open interval [0, 1)
pseudoSample = lcg.rand(1000)
trueSample = pseudoSample

dataPath <- 'C:\\Users\\jasme\\Downloads\\UChicago\\Statistical Analysis - Yuri\\Week 3\\statistics_03_data\\'
# data <- read.table(paste(dataPath,'Week3_Test_Sample.csv', sep = ''), sep = ',', header=TRUE)
res<-data.frame(pseudoSample=pseudoSample,trueSample=trueSample)
saveRDS(res,paste(dataPath,'result.rds',sep='/'))
