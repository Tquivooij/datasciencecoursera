# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Tim Quivooij

library(shiny)

# Define server logic
function(input, output, session) {

# Load the file data  
  filedata <- reactive({
    
  if(input$startdata==TRUE)
  { mtcars
    } else {
  validate(need(input$upload,""))
  inFile <- input$upload
  if (is.null(inFile))
    return(NULL)
  read.csv(inFile$datapath)
    }
  })
  
  # change input dropdown 
output$cols <- renderUI({
  df <- filedata()
  if (is.null(df)) return(NULL)
  items = names(df)
  names(items) = items
  selectInput("cols", "Column:", items)
})


# analysis result should be generated below:
output$analysis <- renderUI({
  selcol <- input$cols
  df <- filedata()
  tocheck <- filedata()[,c(selcol)]

  dataset <- if(input$startdata==TRUE){"mtcars"}else{input$upload$name}
  
  
  if (is.null(df)) return(NULL)
#  tableOutput("contents") 
  if (input$cols == 0) return(NULL)
  # return the analysis of the columns
  if(is.numeric(tocheck)){
   h5("Dataset: ", dataset, tags$br(),
      "There are ", nrow(df)," rows in the dataset." , tags$br(), 
      "Number of columns: ", ncol(df),  tags$br(), tags$br(),
      "Selected variable: ", selcol, tags$br(), 

      
   "Mean: ", round(mean(tocheck, na.rm=TRUE),2),  tags$br(),
   "Standard deviation: ", round(sd(tocheck, na.rm=TRUE),2),  tags$br(),
   "Median: ", round(median(tocheck, na.rm=TRUE),2), tags$br(),
   "Min: ", round(min(tocheck, na.rm=TRUE),2), tags$br(),
   "Max: ", round(max(tocheck, na.rm=TRUE),2), tags$br(),  
   "Number of NA values: ", sum(is.na(tocheck)), tags$br(),  
   "Number of 0 values: ", sum((tocheck==0)), tags$br(),  
   "25% quantile: ", c(round(quantile(tocheck, na.rm = T,probs = 0.25), 2)), tags$br(),  
   "75% quantile: ", c(round(quantile(tocheck, na.rm = T,probs = 0.75), 2)), tags$br())  
  } else {
    h5("Dataset: ", dataset, tags$br(),
       "There are ", nrow(df)," rows in the dataset." , tags$br(), 
       "Number of columns: ", ncol(df),  tags$br(), tags$br(),
       
       "Selected variable: ", selcol, tags$br(),
       "This variable is non numeric"
       )
    
  }
  
  
})
# the plot
output$plot <- renderPlot({
  selcol <- input$cols
  column <- filedata()[,c(selcol)]
  if (is.numeric(column)) {
  hist(column, col ="lightblue" )
  } else {
    xaxis <- as.factor(column)
   plot(xaxis, col ="lightblue" )
  }
})

}
