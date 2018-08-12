library(tidytext)
library(pdftools)
library(dplyr)

nrc <- get_sentiments('nrc')
setwd('/Users/doctor_ew/Downloads/sentiment_analysis/pdfs')
files <- list.files('/Users/doctor_ew/Downloads/sentiment_analysis/pdfs')
df <- data.frame(word=' ', filename=' ')
wordlist <- list('')

for (file in files) {
  document <- pdf_text(file)
  
  doctext <- strsplit(document, ' ')
  
  for (row in doctext) {
    for (element in row) {
      wordlist <- c(wordlist, element)
    }
  }
  swapdf <- do.call(rbind.data.frame, wordlist)
  colnames(swapdf) <- 'word'
  swapdf$filename <- file
  df <- rbind(df, swapdf)
}

feelings_raw <- merge(x=df, y=nrc, by='word')
feelings_summarized <- count(feelings_raw, filename, sentiment)
write.csv(sentiments, '/Users/doctor_ew/Downloads/sentiment_analysis/sentiments.csv', row.names=FALSE)
