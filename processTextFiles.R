#
# processTextFiles.R
#
# Author:  Len Greski
# Date:    01 March 2017
#
# Purpose: manipulate text data for text prediction application so it may be loaded into
#          a Shiny app for use 

# Processing Steps
#
# 1. Read & combine files
# 2. Create n-grams of varying sizes and save to RDS files

library(readr)
library(dtplyr)
library(stringr)
library(stringi)

blogFile <- "./capstone/data/en_us.blogs.txt"
newsFile <- "./capstone/data/en_us.news.txt"
twitterFile <- "./capstone/data/en_us.twitter.txt"
#
# note: change inFile & outFile references for each file type
#
inFile <- blogFile
outFile <- "all-"
blogData <- read_lines(blogFile)
newsData <- read_lines(newsFile)
twitterData <- readLines(twitterFile) # had to use readLines because it handled embedded nulls in 4 lines (167155, 268547, 1274086, and 1759032)
allData <- c(blogData,newsData,twitterData) # about 800mb file
# allData <- read_lines(inFile)
# allData <- readLines(inFile) # required for twitter file
# rm(blogData,newsData,twitterData)

allData <- str_replace_all(allData, "â","")
allData <- str_replace_all(allData, "\"","")
allData <- str_replace_all(allData, "  "," ")

library(quanteda)
# library(knitr)
# library(pastecs)

theText <- corpus(allData)
# corpus is about 1gb
rm(allData)

# runtime about 214 seconds on x360 
words <- quanteda::tokenize(toLower(theText),
                            removePunct=TRUE,
                            removeNumbers=TRUE,
                            removeSeparators=TRUE,
                            removeTwitter=TRUE,
                            verbose=TRUE)
paste("theText size is: ",format(object.size(theText),units="auto"))

rm(theText)
system.time(saveRDS(words,paste("./capstone/data/",outFile,"words.rds",sep="")))
paste("Tokenized words size is: ",format(object.size(words),units="MB"))
system.time(ngram2 <- ngrams(words,n=2))
system.time(saveRDS(ngram2,paste("./capstone/data/",outFile,"ngram2.rds",sep="")))
paste("ngram2 size is: ",format(object.size(ngram2),units="MB"))
rm(ngram2)
# runtime: 27 seconds x-360 
# system.time(words <- readRDS(paste("./capstone/data/",outFile,"words.rds",sep=""))) 
# runtime: 356 seconds x-360 
system.time(ngram3 <- ngrams(words,n=3))
# runtime: 57.72 seconds x-360 
system.time(saveRDS(ngram3,paste("./capstone/data/",outFile,"ngram3.rds",sep="")))
paste("ngram3 size is: ",format(object.size(ngram3),units="MB"))
rm(ngram3)
# runtime: 356.14 seconds x-360
system.time(ngram4 <- ngrams(words,n=4))
# runtime: 480 seconds x-360 
system.time(saveRDS(ngram4,paste("./capstone/data/",outFile,"ngram4.rds",sep=""))) 
paste("ngram4 size is: ",format(object.size(ngram4),units="MB"))
rm(ngram4)
system.time(ngram5 <- ngrams(words,n=5))
system.time(saveRDS(ngram5,paste("./capstone/data/",outFile,"ngram5.rds",sep=""))) 
paste("ngram5 size is: ",format(object.size(ngram5),units="MB"))
rm(ngram5)

#
# now, process into data tables, using generateNgramDb function 
#
