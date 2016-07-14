library(shiny)
library(markdown)
# Define UI for dataset viewer application
shinyUI(
  pageWithSidebar(
    # Application title
    headerPanel("Miles per Gallon Estimation"
      
    ),
    
    sidebarPanel(
      numericInput('wt', 'Weight in tons', 3, min = 1, max = 6, step = .01),
      radioButtons("disp", "Displacement (cu.in.):",
                   c("More or equal than 193.6 cu.in." = "0",
                     "Less than 193.6 cu.in." = "1")),
      submitButton('Submit')
    ),
    mainPanel(
      tabsetPanel(
         tabPanel('Your results',
            p('Using a linear model built on mtcars data, we estimate mpg
            without considering your Displacement,
            your car can run when it\'s weight in tons : '),
            verbatimTextOutput("inputValue"),
            h4('Which resulted in a prediction of '),
            verbatimTextOutput("prediction1"),
            h4('in the 95% prediction interval : '),
            verbatimTextOutput("prediction2"),
            plotOutput('myPlot'),
            p("Considering your Displacement we obtain a more confident estimation :"),
            verbatimTextOutput("prediction3"),
            h4('in the 95% prediction interval : '),
            verbatimTextOutput("prediction4")
         ),
         tabPanel('Documentation',
           includeMarkdown("readme.md")
         )
      )   
    )
  )
)
