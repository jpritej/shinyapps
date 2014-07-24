library(shiny)
shinyUI(pageWithSidebar(
        headerPanel("Predicting the miles per gallon of your car"),
        sidebarPanel(
                h3('Configure your car:'),                
                radioButtons("am", "Transmission type:",
                                   c("Manual" = "manual",
                                     "Automatic" = "automatic"),selected="manual"),
                radioButtons("vs", "Engine type:",
                             c("V engine" = "V",
                               "Straight engine" = "straight"),selected="straight"),
                sliderInput('hp', 'Gross horsepower',value = 90, min = 50, max = 350, step = 1,),        
                h3('Application help:'),                
                helpText("Select above the type of transmission of your car (manual or automatic), its type of engine (commonly straight) and the gross horsepower. The box on the right will display the miles per gallon estimated for your car from historical data from 1974 Motor Trend US magazine. In the plot you can see the position of your car in comparison with such magazine data.")
        ),     
        mainPanel(
                h3('Prediction for your car'),
                textOutput('car'),
                verbatimTextOutput('prediction'),
                plotOutput('newPlot')
        )       
))