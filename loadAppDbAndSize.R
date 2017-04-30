#
# run server R code and predict text
#

library(data.table)
library(stringi)
system.time(appData <- data.table(readRDS("textPredictor/data/textAppDb.rds")))
setkey(appData,base)
source("predictText.R")
format(object.size(appData),units="MB")

