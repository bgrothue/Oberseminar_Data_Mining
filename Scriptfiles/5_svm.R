#0. Arbeitsverzeichnis aufräumen und pfad setzen
rm(list = ls())
setwd(dr = "Dokumente/4._Semester/Oberseminar_Data_Mining/")

#1. Load the e1071 and caret packages:
library(e1071)
library(caret)

#2. Read the data:
bn <- read.csv("banknote-authentication.csv")

#3. Convert the outcome variable class to a factor:
bn$class <- factor(bn$class)

#4. Partition the data:
set.seed(1000)
train.idx <- createDataPartition(bn$class, p=0.7, list=FALSE)

#5. Build the model:
mod <- svm(class ~ ., data = bn[train.idx,])

#6. Check model performance on training data by generating an
#error/classification-confusion matrix:
(tab.train <- table(bn[train.idx,"class"], fitted(mod), dnn = c("Actual", "Predicted")))
round(prop.table(tab.train)*100,1) #Pozentual

#7. Check model performance on the validation partition:
pred <- predict(mod, bn[-train.idx,])
(tab.val <- table(bn[-train.idx, "class"], pred, dnn = c("Actual", "Predicted")))
round(prop.table(tab.val)*100,1) #Pozentual
#8. Plot the model on the training partition. Our data has more than two predictors, but
#we can only show two in the plot. We have selected skew and variance:
plot(mod, data=bn[train.idx,], skew ~ variance)

#9. Plot the model on the validation partition. Our data has more than two predictors,
#but we can only show two in the plot. We have selected skew and variance:
plot(mod, data=bn[-train.idx,], curtosis ~ entropy)


