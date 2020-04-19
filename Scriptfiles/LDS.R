# install required packages
#install.packages(c("MASS", "caret"))

#1. load requiered Packages
library(MASS)
library(caret)

#2. read dataset
bn <- read.csv("banknote-authentication.csv")

#3. Convert the outcome variable class to a factor:
bn$class <- factor(bn$class)

#4. Partition the data. The predictor variables are already numeric and the outcome
#variable class is already 0-1, so we do not have to do any data preparation. Refer
#to Creating random data partitions in Chapter, What's in There? – Exploratory Data
#Analysis for details on how the following command works:
set.seed(1000)
t.idx <- createDataPartition(bn$class, p = 0.7, list=FALSE)

#5. Build the Linear Discriminant Function model:
ldamod <- lda(bn[t.idx, 1:4], bn[t.idx, 5])

#6. Check how the model performs on the training partition 
#(your results could differ because of random partitioning):
bn[t.idx,"Pred"] <- predict(ldamod, bn[t.idx, 1:4])$class
table(bn[t.idx, "class"], bn[t.idx, "Pred"], dnn = c("Actual", "Predicted"))

#7. Generate predictions on the validation partition and check performance 
#(your results could differ):
bn[-t.idx,"Pred"] <- predict(ldamod, bn[-t.idx, 1:4])$class
table(bn[-t.idx, "class"], bn[-t.idx, "Pred"], dnn = c("Actual", "Predicted"))
