# choose dataset
medidas <- read.table(file.choose(), header=TRUE)

# convert to dataframe
medFrame <- as.data.frame(medidas)
head(medFrame)
