# choose dataset
medidas <- read.table(file.choose(), header=TRUE)

# convert to dataframe
medFrame <- as.data.frame(medidas)
head(medFrame)

# split dataframe for train and test
# 348 registers for training
# 116 registers for testing
trainset <- medFrame[1:348,]
testset <- medFrame[349:463,]
