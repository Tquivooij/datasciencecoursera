# The R script used for the project 
# Tim Quivooy
# 14-11-2023
install.packages("LaTeX")
library(LaTeX)
# What to do?
# 1. load the data
# 2. divide in test and training
# 3. Tidy the data/Exploratory data analysis
# 4. make multiple models (decision tree and random forest)
# 5. cross validation and pick best model
# 5. predict using the best model


# libraries
library(tidyverse)
library(caret) # a newer version is tidymodel
library(rattle) # prettier plot decision tree
# library(randomForest)
set.seed(123)


# load the data
# checking and creating directories
if(!file.exists("data")){
  dir.create("data")
}
# download files from internet
trainfileUrl <- "https://d396qusza40orc.cloudfront.net/predmachlearn/pml-training.csv"
trainfilename <- "./data/pml-training.csv"

testfileUrl <- "https://d396qusza40orc.cloudfront.net/predmachlearn/pml-testing.csv"
testfilename <- "./data/pml-testing.csv"

download.file(trainfileUrl, destfile = trainfilename, method="curl") # curl: for https
download.file(testfileUrl, destfile = testfilename, method="curl") # curl: for https
list.files("./data")

# read data
traindata <- read.csv(trainfilename, header=TRUE, sep = ",") # comma-seperated file with header
predictdata <- read.csv(testfilename, header=TRUE, sep = ",") # comma-seperated file with header

# Exploratory data analysis
# Tidy and validate data
dim(training); dim(test)
# check the different classes
unique(traindata$classe)
# check the different variables
names(training)
ncol(training)
# remove columns that are not related to measurements
# these are X, user_name, raw_timestamp_part_1, raw_timestamp_part_2, 
# cvtd_timestamp, num_window
traindata <- traindata [ , !names(traindata) %in% 
                        c("X", "user_name", "raw_timestamp_part_1",
                           "raw_timestamp_part_2", "cvtd_timestamp", "num_window", "new_window")]

# Since the predictors relate to device measurements, I choose to replace NA with 0s
# An NA measurement can be considered as a 0 measurement
# instead of simply omitting the NA-values and reduce the size of the training dataset
# The NA's are replaced by 0
traindata[is.na(traindata)] <- 0      
head(traindata)

# principal component analysis: reduce parameters
# Removing near zero variance variables.
nvz <- nearZeroVar(traindata)
traindata <- traindata[,-nvz]
dim(traindata); dim(predictdata)

# split data in Training (75%) and testing (25%)
# classe parameter is predicted variable Y
inTrain <- createDataPartition(y=traindata$classe, p=0.75, list = FALSE)
training <- traindata[inTrain, ] # 75% training
test <- traindata[-inTrain, ] # 25# test
dim(training); dim(test)


# model 1: Decision tree
modFit_tree <- train(classe~.,  method="rpart",  data=training)
print(modFit_tree$finalModel)
plot(modFit_tree$finalModel, uniform=TRUE, 
     main="Classification Tree")
text(modFit_tree$finalModel, use.n=TRUE, all=TRUE, cex=.8)

# install.packages("rattle")
# library(rattle)
fancyRpartPlot(modFit_tree$finalModel)

# model 2: random forest
modFit_RF <- train(classe~ .,data=training,method="rf",prox=TRUE)
modFit_RF

# parallel performance


# Use parallel implementation to increase performance of the random forest model (it was taking too much time before)
library(parallel)
# install.packages("doParallel")
library(doParallel)
cluster <-makeCluster(detectCores()-1)
registerDoParallel(cluster)

# configure trainControl object
fitControl<-trainControl(method="cv",number=20,allowParallel = TRUE)

# develop training model with fitControl
modFit_RF<-train(classe~.,method="rf",data=training,trControl=fitControl)
modFit_RF

# de-register parallel processing cluster
stopCluster(cluster)
registerDoSEQ()

# Cross validation
# use model to predict classe in validation set (test)
predict_tree <- predict(modFit_tree, newdata=test)
predict_RF <- predict(modFit_RF, newdata=test)


# show confusion matrix to get estimate of out-of-sample error
confusionMatrix(as.factor(test$classe), predict_tree)
confusionMatrix(as.factor(test$classe), predict_RF)


predictdata <- predictdata [ , !names(predictdata) %in% 
                           c("X", "user_name", "raw_timestamp_part_1",
                             "raw_timestamp_part_2", "cvtd_timestamp", "num_window", "new_window")]


result <- predict(modFit_RF, predictdata)
result

