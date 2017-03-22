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
shinyUI(pageWithSidebar(
  
  # Application title
  titlePanel("Text Predictor: Backoff Model"),
  
  # Sidebar with text input and <predict> button 
 
    sidebarPanel(
       textInput("aPhrase",
                 label = h3("Enter text..."),
                 value=""),
       br(),
       br(),
       submitButton("Predict",icon("refresh"))
    ),
    
    # Show predicted word 
    mainPanel(
      br(),
       h3("Predicted Word"),
       textOutput("predictedValue")
    )

))
