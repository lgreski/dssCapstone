#
# test reading RDS vs. flat file
#

system.time(theData <- readRDS("./textPredictor/Data/textAppDb.rds"))
# write as CSV file
library(readr)
system.time(write_csv(theData,"./textPredictor/Data/textAppDb.csv"))
# re-read from disk
system.time(read_csv("./textPredictor/Data/textAppDb.csv"))