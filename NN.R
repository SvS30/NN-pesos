# choose dataset
medidas <- read.table(file.choose(), header=TRUE)

# convert to dataframe
medFrame <- as.data.frame(medidas)
# print the 6 first records
head(medFrame)

# split dataframe for train and test
# 348 registers for training
# 116 registers for testing
trainset <- medFrame[1:348,]
testset <- medFrame[349:463,]

# library for neural networks
# https://www.rdocumentation.org/packages/neuralnet/versions/1.44.2/topics/neuralnet
# output = expected
# inputs (nave, mes, alimentos)
# without hidden layer
# act function does not apply
# error function as sopping criteria = 0.01
# this NN is for training
library(neuralnet)
nn <- neuralnet(`expected` ~ `nave` + `mes` + `alimentos`, data=trainset, hidden=0, linear.output=FALSE, threshold=0.01)

# Printing the results matrix
# with information such as the error, steps, and expected values
nn$result.matrix

# display neural network as graph
plot(nn)

# process for testing
# split columns from testset DataFrame
temp_test <- subset(testset, select = c("nave", "mes", "alimentos"))
head(temp_test)

# collect NN and data for testing in a new DataFrame
nn.results <- compute(nn, temp_test)
# transform the input data into a standardized format
results <- data.frame(actual = testset$expected, prediction = nn.results$net.result)
head(results)
