
library(shiny)

# Define UI for miles per gallon application
shinyUI(pageWithSidebar(
  
  # Application title
  headerPanel("Miles Per Gallon: Linear Model with Two Predictors"),
  
  # Sidebar with controls to select the variable to plot against mpg
  # and to specify whether outliers should be included
  sidebarPanel(
    radioButtons("varCont", "Choose continous predictor:",
       list(
         "Displacement" = "disp",
         "Gross horsepower" = "hp",
         "Rear axle ratio" = "drat",
         "Weight" = "wt",
         "1/4 mile time" = "qsec"
    )),
    radioButtons("varCat", "Choose categorical predictor:",
       list(
         "Number of cylinders" = "cyl",
         "Engine type (Straight or V-type)" = "vs",
         "Transmission type" = "am",
         "Number of forward gears" = "gear",
         "Number of carburetors" = "carb"
   )),
    helpText("Note: select one of the continous predictor, try to select differnet categorical predictors to take a look at the difference of the distributions and linear models.")
  ),
  
  # Show the caption and plot of the requested variable against mpg
  mainPanel(
    h3(textOutput("caption")),
    
    plotOutput("mpgPlot")
  )
))