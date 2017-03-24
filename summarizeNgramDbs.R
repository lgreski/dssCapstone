# scratch code for aggregating app data
# code added into buildNgramAppData.R once it was working 

ngram2App <- data.table(ngram2App)

setkey(ngram2App,base,prediction)

aggregated <- ngram2App[,.(count = sum(count)),keyby=.(base,prediction)]

# now select out only max(count) for each prediction 
setkey(aggregated,base,count)

subset <- aggregated[.N,,by=.(base,count)]

library(sqldf)

sqlstmt <- "select base, max(count) as count from aggregated group by base"

result <- sqldf(sqlstmt)

sqlstmt <- "select a.* from aggregated a, result r where a.base = r.base and a.count = r.count"

finalDb <- sqldf(sqlstmt)