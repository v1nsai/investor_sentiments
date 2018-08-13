# Investor sentiment analysis

#### keywords.R
Takes a list of words and searches all documents in the PDF folder folder and counts occurrences of them.  The output is a file called
results.csv that contains a count of the words broken out by the file they were found in and the category.

#### sentiments.R
Uses the nrc lexicon data from the tidytext package to analyze the sentiment associated with words found in the PDFs in the PDF folder.
The output is a file called sentiments.csv that contains a list of all the feelings found in each file.
