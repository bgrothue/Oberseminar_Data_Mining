setwd(dir = "Dokumente/4._Semester/Oberseminar_Data_Mining/")
#1. load Packages
library(caret) # Classification And REgression Training-package
library(e1071) # Support Vector Machines The Interface to libsvm in package e1071
#2. Read the data:
bn <- read.csv("banknote-authentication.csv")

#3. Convert the outcome variable class to a factor:
bn$class <- factor(bn$class)

#4. Partition the data:
set.seed(1000)
t.idx <- createDataPartition(bn$class, p=0.7, list=FALSE)

#5. Build the model:
mod <- svm(class ~ ., data = bn[t.idx,])
#5.B assigning weights to the classes
#mod <- svm(class ~ ., data = bn[t.idx,], class.weights=c("0"=0.3, "1"=0.7 ))

#6. Check model performance on training data by generating an
# error/classification-confusion matrix:
table(bn[t.idx,"class"], fitted(mod), dnn = c("Actual", "Predicted"))

#7. Check model performance on the validation partition:
pred <- predict(mod, bn[-t.idx,])
table(bn[-t.idx, "class"], pred, dnn = c("Actual", "Predicted"))

#8. Plot the model on the training partition. Our data has more than two predictors, but
#we can only show two in the plot. We have selected skew and variance:
plot(mod, data=bn[t.idx,], skew ~ variance)

#9. Plot the model on the validation partition. Our data has more than two predictors,
#but we can only show two in the plot. We have selected skew and variance:
plot(mod, data=bn[-t.idx,], skew ~ variance)