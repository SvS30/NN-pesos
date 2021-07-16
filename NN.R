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

# library for neural networks
# https://www.rdocumentation.org/packages/neuralnet/versions/1.44.2/topics/neuralnet
# output = expected
# inputs (nave, mes, alimentos)
# without hidden layer
# act function does not apply
# error function as sopping criteria = 0.01
library(neuralnet)
nn <- neuralnet(`expected` ~ `nave` + `mes` + `alimentos`, data=trainset, hidden=0, linear.output=FALSE, threshold=0.01)

# Printing the results matrix
# with information such as the error, steps, and expected values
nn$result.matrix

# display neural network as graph
plot(nn)
