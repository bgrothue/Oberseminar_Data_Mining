#0. Arbeitsverzeichnis aufräumen und pfad setzen
rm(list = ls())
setwd(dr = "Dokumente/4._Semester/Oberseminar_Data_Mining/")

#1. load required packages
library(class)
library(caret)

#2. read data:
vac <- read.csv("vacation-trip-classification.csv")

#3. Standardize the predictor variables Income and Family_size :
vac$Income.z <- scale(vac$Income)
vac$Family_size.z <- scale(vac$Family_size)

4. Partition the data. You need three partitions for KNN:
  > set.seed(1000)
> train.idx <- createDataPartition(vac$Result, p = 0.5, list =
                                     FALSE)
> train <- vac[train.idx, ]
> temp <- vac[-train.idx, ]
> val.idx <- createDataPartition(temp$Result, p = 0.5, list =
                                   FALSE)
> val <- temp[val.idx, ]
> test <- temp[-val.idx, ]

5. Generate predictions for validation cases with k=1 :
  > pred1 <- knn(,train[4:5], val[,4:5], train[,3], 1)

6. Generate an error matrix for k=1 :
  > errmat1 <- table(val$Result, pred1, dnn = c("Actual",
                                                "Predicted")