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
appData <- data.table(readRDS("data/textAppDb.rds"))
setkey(appData,base)
source("predictText.R")

# Define server logic required to predict text from UI input
shinyServer(function(input, output) {

  output$predictedValue <- renderText({
       baseTokens <- strsplit(stri_trim_both(stri_trans_tolower(input$aPhrase)),c(" "))[[1]]
       tokenCount <- length(baseTokens)
       
       aResult <- predictText(dataTable=appData,base=stri_trim_both(stri_trans_tolower(input$aPhrase)))
       # if (length(aResult) == 0) "the"
       # else aResult
       aResult
 
  })
  
})
