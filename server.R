# Data Science Capstone Project July 2020
# Shiny app development for predicting the next word 
# "server.R" file for the Shiny app


suppressWarnings(library(tm))  # suppress warning messages
suppressWarnings(library(stringr)) # suppress warning messages
suppressWarnings(library(shiny)) # suppress warning messages

# Load Quantgram,Quadgram,Trigram & Bigram Data frame files saved earlier

 quantgram<-readRDS("quantgram.RData");
 quadgram <- readRDS("quadgram.RData");
 trigram <- readRDS("trigram.RData");
 bigram <- readRDS("bigram.RData");
 messag <<- ""    # To display the output message

# Cleaning the user input before algorith predicts the next word

Predict <- function(phrase) {
  Data_clean <- removeNumbers(removePunctuation(tolower(phrase))) # clean the input phrase and convert to lower 
  clean_001 <- strsplit(Data_clean, " ")[[1]] # it is single vector input
  
  # Back Off Algorithm
  # Predict the next word taking user input pharase
  # 1. Use Quantgram for prediction (1st 4 words) of Quantgram are the last four words of the user provided pharase).
  # 2. If no Quantgram is found, back off to Quadgram  (first three words of Quadgram are the last three words of the pharase).
  # 3. If no Quadgram is found, back off to Trigram (first two word of Trigram is the last two word of the pharase)
  # 4. If no Trigram is found, back off to Bigram (first word of Bigram is the last word of the pharase)
  # 4. If no Bigram is found, back off to the most common word with highest frequency 'the' is returned.
  
  if (length(clean_001)>= 4) {
    clean_001 <- tail(clean_001,4)
    if (identical(character(0),head(quantgram[quantgram$unigram == clean_001[1] & quantgram$bigram == clean_001[2] & 
        quantgram$trigram == clean_001[3] & quantgram$quadgram==clean_001[4], 5],1))){
      Predict(paste(clean_001[2],clean_001[3],clean_001[4], sep=" "))
    }
    else {messag <<- "Predict Next word by Quantgram"; head(quadgram[quadgram$unigram == clean_001[1] 
          & quadgram$bigram == clean_001[2] & quadgram$trigram == clean_001[3]& quadgram== clean_001[4], 5],1)}
  }
  
  
  
    else if (length(clean_001)== 3) {
      clean_001 <- tail(clean_001,3)
    if (identical(character(0),head(quadgram[quadgram$unigram == clean_001[1] & quadgram$bigram == clean_001[2] & quadgram$trigram == clean_001[3], 4],1))){
      Predict(paste(clean_001[2],clean_001[3],sep=" "))
    }
    else {messag <<- "Predict next word by Quadgram"; head(quadgram[quadgram$unigram == clean_001[1] 
        & quadgram$bigram == clean_001[2] & quadgram$trigram == clean_001[3], 4],1)}
  }
  else if (length(clean_001) == 2){
    clean_001 <- tail(clean_001,2)
    if (identical(character(0),head(trigram[trigram$unigram == clean_001[1] & trigram$bigram == clean_001[2], 3],1))) {
      Predict(clean_001[2])
    }
    else {messag<<- "Predict Next word by Trigram"; head(trigram[trigram$unigram == clean_001[1] & trigram$bigram == clean_001[2], 3],1)}
  }
  else if (length(clean_001) == 1){
    clean_001 <- tail(clean_001,1)
    if (identical(character(0),head(bigram[bigram$unigram == clean_001[1], 2],1))) {messag<<-"Sorry No match - Try again - the  word 'the' is returned."; head("the",1)}
    else {messag <<- "Predict Next by bigram"; head(bigram[bigram$unigram == clean_001[1],2],1)}
  }
}


shinyServer(function(input, output) {
  output$next_prediction <- renderPrint({
    result <- Predict(input$inputPhrase)
    output$text2 <- renderText({messag})
    result
  });
  
  output$text1 <- renderText({
    input$inputPhrase});
}
)