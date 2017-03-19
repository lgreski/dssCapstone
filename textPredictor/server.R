#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(data.table)
library(stringi)
data <- data.table(readRDS("data/textAppDb.rds"))
setkey(data,base)
source("predictText.R")

# Define server logic required to predict text from UI input
shinyServer(function(input, output) {
  # aResult <- predictText(data,input$aPhrase)  
  output$predictedValue <- renderText({
       data[1,prediction]
 
  })
  
})
