#
# generatengramdb.R
# 
# Purpose: generate database of base text, predicted text, and frequency countsf
#          for n-grams of a given size
#
# Date:   01 March 2017
# Author: Len Greski

generatengramdb <- function(inputRDS,nGramSize,threshold=10,subsetTop3=TRUE) {
     library(data.table)
     library(stringr)
     startTime <- Sys.time()
     # check input arguments
     if (nGramSize > 5) stop("nGramSize must be 5 or less.")
     theFileName <- paste("./capstone/data/",inputRDS,nGramSize,".rds",sep="")
     message(paste("Starting generatengramdb() function for ",theFileName,":",startTime)) 
     
     if (!file.exists(theFileName)) stop("Input RDS file does not exist.")
     # runtime: 121 seconds x-360 for 2-grams
     
     # read input RDS, convert ngrams to a data table so we can aggregate counts
     message(paste("Start: convert ngrams to data table",Sys.time()))
     theTable <- data.table(ngram=(unname(unlist(readRDS(theFileName)))),count=1)
     message(paste("End: convert ngrams to data table",Sys.time()))
     
     
     # runtime: 10.47 seconds x-360 
     message(paste("Start: aggregate data table by ngram",Sys.time()))
     
     aggNgram <- theTable[,.(count = sum(count)),keyby=ngram][count>=threshold]
     message(paste("End: aggregate data table by ngram",Sys.time()))
     rm(theTable)
     
     # format(object.size(aggNgram),units="Mb")
     # now, create base and predicted values by parsing ngram by nth underscore
     # return(aggNgram)
     theTokens <- strsplit(aggNgram$ngram,"_")
     
     # create vectors for base and predicted by extracting correct elements from each item
     # in theTokens list 
     library(stringi)
     aggNgram$base <- str_trim(unlist(lapply(theTokens,function(x) {
          outVar <- x[1]
          if (nGramSize >2) {
               # note: coded only to handle ngrams up to 5
               
               if (nGramSize == 3) {outVar <- paste(outVar,x[2])}
               else if (nGramSize ==4) {outVar <- paste(outVar,x[2],x[3])}
               else if (nGramSize ==5) {outVar <- paste(outVar,x[2],x[3],x[4])}
          }
          outVar})))
     aggNgram$prediction <- str_trim(unlist(lapply(theTokens,function(x) {x[nGramSize]})))
     # eliminate blank base, only return first 3 rows by descending count for each base
     setorder(aggNgram,base,-count)
     aggNgram <- aggNgram[base != "",.(base, prediction, count)]
     
     endTime <- Sys.time()
     paste("aggNgram generation took: ",endTime - startTime,attr(endTime- startTime,"units"))
     rm(theTokens)
     
     if (subsetTop3 == TRUE) {
          # now, truncate each base to top 3 by processing base as a factor / list to extract
          # top 3
          
          
          message(paste("Starting sort data table ",Sys.time()))
          system.time(aggNgram <- aggNgram[order(base,prediction,-count),])
          message(paste("Ending sort data table: ",Sys.time()))

          # pick the top 3 items for each base to use in our prediction app
          message(paste("Starting extract by descending count: ",Sys.time())) 
          message(paste("Elapsed: ",system.time(ngramdb <- aggNgram[,.SD[c(1,2,3)],by=.(base,prediction)][!is.na(count),])[3]))
          message(paste("Ending extract by descending count: ",Sys.time()))

     } else {
          # code to create sorged ngram list without apply function
          ngramdb <- aggNgram 
     }
     # now, finally write the output file
     
     # this is 7mb for bases that occur at least twice
     message(paste("Output ngram file size is: ",format(object.size(ngramdb),units="Mb")))
     outFileName <- paste("./capstone/data/",inputRDS,nGramSize,"Db.rds",sep="")
     saveRDS(ngramdb,outFileName)
     endTime <- Sys.time()
     message(paste("Ending generatengramdb() function at ",endTime))
     message(paste("Total elapsed time:",round(endTime - startTime,2),attr(endTime - startTime,"units")))
     ngramdb
}