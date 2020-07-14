
# ui.R - user-interface for Shiny web application - Data Science Swiftkey NLP project


library(shiny)
suppressWarnings(library(shiny)) # suppress warning messages 
suppressWarnings(library(markdown)) # suppress warning messages 
shinyUI(navbarPage("Data Science Capstone Project",
                   tabPanel("Text word Prediction",
                            
                            # Sidebar
                            sidebarLayout(
                              sidebarPanel(
                                helpText("Please enter a phrase to get the next word"),
                                textInput("inputPhrase", "Enter the phrase 3-5 words ",value = ""),
                              
                             submitButton('Press After Entering the Phrase')   ),
                              mainPanel(
                                h1("Next PREDICTED Word is Displayed here"),
                                verbatimTextOutput("next_prediction"),
                                strong("Sentence Input:"),
                                tags$style(type='text/css', '#text1 {background-color: rgba(255,255,0,0.40); color: black;}'), 
                                textOutput('text1'),
                                br(),
                                strong("Note:"),
                                tags$style(type='text/css', '#text2 {background-color: rgba(255,255,0,0.40); color: blue;}'),
                                textOutput('text2')
                              )
                            )
                            
                   )
                   
)
)

