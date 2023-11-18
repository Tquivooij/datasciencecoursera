#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
fluidPage(

    # Application title
  titlePanel( div(column(width = 6, h2("CSV Import Analysis")), 
                  column(width = 6, tags$img(src = "TMQ.gif", height="30%",
                                             width="30%", align="right"))),
              windowTitle="MyPage"
  ),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
          fileInput("upload", "Upload a CSV file", accept=c(".csv", "txt")),
          em("Only use comma separated files with headers. Max 5MB per file. Or:"), tags$br(),
          checkboxInput("startdata", "Use mtcars dataset", FALSE),
          uiOutput("cols"),
    #      actionButton("display", "Display results")
    
        ),

        # Mainpanel definition
        mainPanel(
          # the analysis panel
          uiOutput("analysis"),
          plotOutput("plot")
        )
    )
)
