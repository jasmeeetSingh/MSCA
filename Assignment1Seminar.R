library(dplyr)
dataPath <- 'C:\\Users\\jasme\\Downloads\\UChicago\\Statistical Analysis - Yuri\\Week 1\\Simpson_Paradox_Class_data'
test_data <- read.table(paste(dataPath,'test_sample.csv',sep = '/'), header=TRUE)

data = test_data

count1 = 0
count = 0
for (row in 1:nrow(data)){
  a = data[row, "A"]
  b = data[row, "B"]
  c = data[row, "C"]
  # if ( c == 4 ) { 
    # count1 = count1/ + 1
    if ( 4 > a && 4 > b) { 
      count = count + 1
    }
  # }
}
print(paste(count, count1))
print(count/1000)


count = 0
count1 = 0
count2 = 0
for (row in 1:nrow(data)){
  a = data[row, "A"]
  b = data[row, "B"]
  c = data[row, "C"]
  if ( b > a && b > c){
    count = count + 1
  }
  if ( a > b && a > c){
    count1 = count1 + 1
  }
  if ( c > a && c > b){
    count2 = count2 + 1
  }
}
print(count/1000)
print(count1/1000)
print(count2/1000)