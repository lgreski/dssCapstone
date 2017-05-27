library(shiny)
library(data.table)
library(stringi)
system.time(appData <- data.table(readRDS("textPredictor/data/textAppDb.rds")))
setkey(appData,base)
min(appData$count)
max(appData$base)
theWords <- strsplit(appData$base," ")max(unlist(lapply(theWords,function(x) {length(x)})))
fiveCount <- appData[appData$count >= 5,]
table(appData$count)

# percentage of 2 - 4 counts in text database
(6297798 - nrow(fiveCount) ) / 6297798
