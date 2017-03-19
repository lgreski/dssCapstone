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
  titlePanel("Text Predictor"),
  
  # Sidebar with text input and <predict> button 
 
    sidebarPanel(
       textInput("aPhrase",
                 label = h3("Text to predict"),
                 value="enter text..."),
       br(),
       br(),
       submitButton("Predict")
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
       h3("Predicted Word"),
       textOutput("predictedValue")
    )

))
