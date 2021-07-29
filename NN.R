# choose dataset
medidas <- read.table(file.choose(), header=TRUE)

# convert to dataframe
medFrame <- as.data.frame(medidas)
# print the 6 first records
head(medFrame)

# split dataframe for train and test
# 80% registers for training
# 20% registers for testing
trainset <- medFrame[1:59,]
testset <- medFrame[60:74,]

# library for neural networks
# https://www.rdocumentation.org/packages/neuralnet/versions/1.44.2/topics/neuralnet
# output = expected
# inputs (nave, mes, alimentos)
# without hidden layer
# act function does not apply
# error function as sopping criteria = 0.01
# this NN is for training
library(neuralnet)
nn <- neuralnet(`expected` ~ `mes` + `nave` + `alimento`, data=trainset,
                hidden=c(3,2), linear.output=FALSE, threshold=0.01)

# Printing the results matrix
# with information such as the error, steps, and expected values
nn$result.matrix

# display neural network as graph
plot(nn)

# process for testing
# split columns from testset DataFrame
temp_test <- subset(testset, select = c("mes", "nave", "alimento"))
head(temp_test)

# collect NN and data for testing in a new DataFrame
# nn.results <- compute(nn, temp_test)
# transform the input data into a standardized format
output <- compute(nn, temp_test)
p1 <- output$net.result
pred1 <- ifelse(p1>0.5,1,0)
results <- data.frame(real=testset$expected, prediction=pred1)
results

# Transform the data in a matriz with round applied
redondeo<-sapply(results,round,digits=0)
redondeodf=data.frame(redondeo)
# Show the confusion matrix
table(real, prediction)

