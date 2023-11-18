### Introduction
This peer assessed assignment has two parts. First, you will create a Shiny application and deploy it on Rstudio's servers. Second, you will use Slidify or Rstudio Presenter to prepare a reproducible pitch presentation about your application.

The Shiny app that I created is the CSV Import Analysis

#### CSV Import Analysis
Every time I need to make a new assignment for the Coursera Data Science Specialisation, I spend quite some in understanding the provided data set. This part is the exploratory data analysis. To facilitate this process, I created a Shiny app to quicker understand the provided input. This will be done by uploading the dataset and browse thought the different columns. For each column, a basic data analyis is done.

#### Usage
The shiny app is a tool where you can upload and perform a basic analysis of an CSV file. Beware to only use comma separated files with headers. Max 5MB per file.
You can also use the mtcars dataset included in R to test the app.

The app consists of two parts:
- ui.R
- server.R

#### Limitations
The app currently only accepts CSV files that are comma separated with a header and a maximum of 5 MB. Also, currently a basic analysis of the various input data is done.

