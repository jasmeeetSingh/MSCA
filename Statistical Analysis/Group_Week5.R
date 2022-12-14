library(dplyr)
dataPath <- 'C:\\Users\\jasme\\Downloads\\UChicago\\Statistical Analysis - Yuri\\Week 5\\test\\Benford_Law_Class_data\\'
data <- read.table(paste(dataPath,'test_sample.csv', sep = ''), sep = ',', header=TRUE)

# install.packages("benford.analysis")

library(benford.analysis)
bfd.cp <- benford(data$x) 

mat = matrix(ncol = 2, nrow = length(bfd.cp$bfd$digits), c(bfd.cp$bfd$digits, bfd.cp$bfd$difference))

indx = c(89, 2, 88, 5, 90, 1)
num1 = c()
for (i in indx) {
  res = mat[order(mat[,2], decreasing = TRUE),][,1][i]
  num1 = c(num1, res)
}
num1

num2 = bfd.cp$stats$chisq$p.value
num3 = bfd.cp$stats$mantissa.arc.test$p.value
num4 = bfd.cp$MAD
num5 = bfd.cp$MAD.conformity

res <- list(
  numbers=num1,
  Chi_square_p.value = num2,
  Mantissa_p.value = num3,
  MAD = num4,
  MAD.conformity  = num5
)

saveRDS(res, file = paste(dataPath,'result_group.rds',sep = '/'))
dat <- readRDS(paste(dataPath,'result_group.rds', sep = '/'))
print(dat)