library(tidytext)
library(pdftools)
library(dplyr)

# Set up vars
nrc <- get_sentiments('nrc')
setwd('/Users/doctor_ew/Documents/GitHub/investor_sentiments/pdfs')
files <- list.files('/Users/doctor_ew/Documents/GitHub/investor_sentiments/pdfs')
df <- data.frame(filename=' ', sentiment=' ', n=0)
wordlist <- list('')

for (file in files) {
  # Dump all the text into a pile
  document <- pdf_text(file)
  
  # Split into a list
  doctext <- strsplit(document, ' ')
  
  # Read list into a dataframe column
  for (row in doctext) {
    for (element in row) {
      wordlist <- c(wordlist, element)
    }
  }
  
  # Initialize as a dataframe, create and update column names
  swapdf <- do.call(rbind.data.frame, wordlist)
  colnames(swapdf) <- 'word'
  swapdf$filename <- file
  
  # Get sentiments for current file and add to big file
  swapfeelings <- merge(x=swapdf, y=nrc, by='word')
  swapfeelings_sum <- count(swapfeelings, filename, sentiment)
  df <- rbind(df, swapfeelings_sum)

  write.csv(df, '/Users/doctor_ew/Documents/GitHub/investor_sentiments/sentiments.csv', row.names=FALSE)
}

# feelings_raw <- merge(x=df, y=nrc, by='word')
# feelings_summarized <- count(feelings_raw, filename, sentiment)
# write.csv(sentiments, '/Users/doctor_ew/Downloads/sentiment_analysis/sentiments.csv', row.names=FALSE)
