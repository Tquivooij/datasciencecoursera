# Prediction Assignment By Tim
The goal will be to use data from accelerometers on the belt, forearm, arm, and dumbell of 6 participants to create a model that predicts (quantifies) how well an  Unilateral Dumbbell Biceps Curl (excercise) is done.

A clasification model is created using this data and with the information from the course. In the analysis report is explained 
1) how I built my models (Decision Tree and Random Forest)
2) how I performed cross validation using a confusion matrix
3) the expected out of sample error
4) predict 20 different test cases. 

## Content
predictionAssignment.R : the r script for the analysis
predictionAssignment.Rmd : the Markdown file
predictionAssignment.html : the knitted report in HTML format


## Parallel processing and performance of knitting the document
I used (with the help of google) a parallel implementation of the Random Forest model to increase its performance. It was simply taking too much time to calculate the model using the commands as teached in the course. The slow response times only appeared during the knitting of the rmd document, and this required me to run the models separately and add the results in. According to the discussion forum of the course, multiple other students were facing a simular issue.