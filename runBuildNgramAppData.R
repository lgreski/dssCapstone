#
# runBuildNgramAppData.R
# Date: 19 March 2017
# purpose: create the databases for Capstone shiny app
#

source('./capstone/buildNgramAppData.R')

# 2-grams file
system.time(ngram2App <- buildNgramAppDb())
format(object.size(ngram2App),units="Mb")

# 3-grams file
system.time(ngram3App <- buildNgramAppDb(ngramSize=3))
format(object.size(ngram3App),units="Mb")

# 4-grams file
system.time(ngram4App <- buildNgramAppDb(ngramSize=4))
format(object.size(ngram4App),units="Mb")

# 5-grams file
system.time(ngram5App <- buildNgramAppDb(ngramSize=5))
format(object.size(ngram5App),units="Mb")

# aggregate to single file and write to RDS
fileList <- c("appDb-ngram2","appDb-ngram3","appDb-ngram4","appDb-ngram5")
theDbs <- lapply(fileList,function(x) {readRDS(paste("./capstone/data/",x,".rds",sep=""))})
data <- do.call(rbind,theDbs)
format(object.size(data),units="Mb")
saveRDS(data,"./capstone/data/textAppDb.rds")

