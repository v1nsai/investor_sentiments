library(pdftools)
library(plyr)

setwd('/Users/doctor_ew/Downloads/sentiment_analysis/pdfs')

# Initialize text and dataframe
results = data.frame(filename=' ', category=' ', word=' ', occurrences=' ', stringsAsFactors = FALSE)
swap = list(filename=' ', category=' ', word=' ', occurrences=0)
files <- list.files('/Users/doctor_ew/Downloads/sentiment_analysis/pdfs')

# Keyword lists
social=c('social', 'society')
economic_changes=c('economic_changes', 'econom', 'market', 'exchange', 'trade', 'GDP', 'emerging markets')
demographic_changes=c('demographic_changes', 'demograph', 'aging', 'seniors', 'population')
sector_changes <- c('sector_changes', 'sector', 'industry')
regulatory_policy_changes <- c('regulatory_policy_changes', 'regulat', 'policy', 'legis')
thematic_aspects <- c('thematic_aspects', 'future of', 'climate change')
long_term_horizon <- c('long_term_horizon', 2019:2030)

keywords <- list(social, economic_changes, demographic_changes, sector_changes, 
                 regulatory_policy_changes, thematic_aspects, long_term_horizon)

for (fil in files) {
  swaptxt <- pdf_text(fil)
  for (list in keywords) {
    for (k in list){
      swap$filename <- fil
      swap$category <- list[1]
      swap$word <- k
      swap$occurrences <- length(grep(k, swaptxt))
      
      results <- rbind(results, swap)
    }
  }
}

results <- results[-1,]
write.csv(results, '/Users/doctor_ew/Downloads/sentiment_analysis/results.csv', row.names=FALSE)