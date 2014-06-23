
library(shiny)
library(datasets)
library(ggplot2)

# We tweak the "am" field to have nicer factor labels. Since this doesn't
# rely on any user inputs we can do this once at startup and then use the
# value throughout the lifetime of the application
data(mtcars)
mcars <- mtcars
mcars$am <- factor(mtcars$am, levels=c(0,1), labels=c("Automatic","Manual"))
mcars$cyl <- ordered(mtcars$cyl, levels=c(4,6,8), labels=c("4 Cylinder","6 Cylinder","8 Cylinder"))
mcars$vs <- factor(mtcars$vs, levels=c(0,1), labels=c("V Engine","Straight Engine"))
mcars$gear <- ordered(mtcars$gear, levels=c(3,4,5), labels=c("3 Gear","4 Gear","5 Gear"))
mcars$carb <- ordered(mtcars$carb, levels=c(1,2,3,4,6,8))
predictors <- names(mtcars)[!(names(mtcars) %in% c("mpg"))]

xlabTitles = data.frame(
  disp="Displacement (cubic inch)",
  hp="Gross horsepower",
  drat="Rear axle ratio",
  wt="Weight (lb/1000)",
  qsec="1/4 mile time (seconds)"
)
catTitles = data.frame(
  cyl="Number of cylinders",
  vs="Engine type (Straight or V-type)",
  am="Transmission type",
  gear="Number of forward gears",
  carb="Number of carburetors"
)

# Define server logic required to plot various variables against mpg
shinyServer(function(input, output) {
  
  # Compute the forumla text in a reactive expression since it is 
  # shared by the output$caption and output$mpgPlot expressions
  formulaText <- reactive({
    paste("mpg ~ ", input$varCont, " (", xlabTitles[[input$varCont]], ") + ", input$varCat, " (", catTitles[[input$varCat]], ")")
  })
  
  # Return the formula text for printing as a caption
  output$caption <- renderText({
    formulaText()
  })
  
  # Generate a plot of the requested variable against mpg and only 
  # include outliers if requested
  output$mpgPlot <- renderPlot({
 
      ggplot(mcars, aes_string(x = input$varCont, y = "mpg", col=input$varCat)) + 
        geom_point() + geom_smooth(method = "lm") + 
        ylab("Miles Per Gallon") + xlab(xlabTitles[[input$varCont]])

  })
})
