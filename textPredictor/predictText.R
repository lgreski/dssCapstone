#
# predictText: function to predict next word 
#
predictText <- function(dataTable="dt",base="illegitimi non") {
     options(warn = -1) # surprss UTF encoding warnings 
     library(data.table)
     library(stringi)
     baseTokens <- strsplit(base,c(" "))[[1]]
     tokenCount <- length(baseTokens)
     top20 <- c("the","to","and","a","of",
                "I","in","for","is","that",
                "you","it","on","with","was",
                "my","at","be","this","have")
     tokenList <- NULL
     if (tokenCount >= 4) {
          # grab last 4 words and query database
          theBase <- paste(baseTokens[tokenCount-3],baseTokens[tokenCount-2],baseTokens[tokenCount-1],baseTokens[tokenCount])
          result <- dataTable[base == theBase,]
          if (nrow(result) > 0) return(result[1,prediction])
          # grab last 3 words and query database
          theBase <- paste(baseTokens[tokenCount-2],baseTokens[tokenCount-1],baseTokens[tokenCount])
          result <- dataTable[base == theBase,]
          if (nrow(result) > 0) return(result[1,prediction])
          
          # grab last 2 words and query database
          theBase <- paste(baseTokens[tokenCount-1],baseTokens[tokenCount])
          result <- dataTable[base == theBase,]
          if (nrow(result) > 0) return(result[1,prediction])
          
          # grab last word and query database
          theBase <- paste(baseTokens[tokenCount])
          result <- dataTable[base == theBase,]
          if (nrow(result) > 0) return(result[1,prediction])
          
          # return random from top 20 words
          return(top20[round(runif(1,min=1,max=20))])
          
     }
     else if (tokenCount == 3){
          # grab last 3 words and query database
          theBase <- paste(baseTokens[tokenCount-2],baseTokens[tokenCount-1],baseTokens[tokenCount])
          result <- dataTable[base == theBase,]
          if (nrow(result) > 0) return(result[1,prediction])
          
          # grab last 2 words and query database
          theBase <- paste(baseTokens[tokenCount-1],baseTokens[tokenCount])
          result <- dataTable[base == theBase,]
          if (nrow(result) > 0) return(result[1,prediction])
          
          # grab last word and query database
          theBase <- paste(baseTokens[tokenCount])
          result <- dataTable[base == theBase,]
          if (nrow(result) > 0) return(result[1,prediction])
          
          # return random from top 20 words
          return(top20[round(runif(1,min=1,max=20))])
          
     }
     else if (tokenCount == 2){
          # grab last 2 words and query database
          theBase <- paste(baseTokens[tokenCount-1],baseTokens[tokenCount])
          result <- dataTable[base == theBase,]
          if (nrow(result) > 0) return(result[1,prediction])
          
          # grab last word and query database
          theBase <- paste(baseTokens[tokenCount])
          result <- dataTable[base == theBase,]
          if (nrow(result) > 0) return(result[1,prediction])
          
          # return random from top 20 words
          return(top20[round(runif(1,min=1,max=20))])
          
          
     }
     else {
          # grab last word and query database
          theBase <- paste(baseTokens[tokenCount])
          result <- dataTable[base == theBase,]
          if (nrow(result) > 0) return(result[1,prediction])
          
          # return random from top 20 words
          return(top20[round(runif(1,min=1,max=20))])
          
          
     }
     # if we get here, it's a surpise, but must always return a prediction 
     # return random from top 20 words
     return(top20[round(runif(1,min=1,max=20))])

}