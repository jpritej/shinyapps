library(shiny)
library(ggplot2)
data(mtcars)
mtcars$am<-factor(mtcars$am,labels=c("automatic","manual"))
mtcars$vs<-factor(mtcars$vs,labels=c("V engine","straight engine"))
mpg <- function(am,hp,vs){
b_0 = 22.177
b_1 = 4.666
b_2 = -0.038
b_3 = 10.341
b_4 = -0.075
b_0 + b_1*(am=="manual") + b_2*hp + b_3*(vs=="straight") + b_4*hp*(vs=="straight")
}
shinyServer(
        function(input, output) {
                output$oid1 <- renderPrint({input$am})
                output$oid2 <- renderPrint({input$vs})
                output$odate <- renderPrint({input$hp})
                output$car <- renderText({paste("The predicted miles per galon for your car with ", input$am, " transmission, ", input$vs, " engine and a gross horsepower of ", input$hp, " are:")})
                miles <- reactive({mpg(input$am,input$hp,input$vs)})
                output$prediction <- renderText({paste(as.character(miles())," mpg")})
                output$newPlot <- renderPlot({
                        ## Initial call to ggplot
                        g<-ggplot(mtcars,aes(hp,mpg,colour=vs))
                        ## Create facets per type and a trend line
                        ann_text <- data.frame(mpg = miles(), hp = input$hp+25, vs=input$vs, am=input$am)
                        ann_car <- data.frame(mpg = miles(), hp = input$hp, vs=input$vs, am=input$am)
                        p<-g + geom_point(shape=1,size=3,)+facet_grid(am ~ .)+geom_point(data = ann_car,shape=3,size=4,colour="black")+scale_shape(solid = TRUE)+labs(title="Common miles per gallon in 1974 Motor Trend US magazine's cars",x="Gross horsepower",y="Miles per gallon")+
                                geom_text(data = ann_text,label = "Your car",colour="black") 
                        print(p)
                })
                
        }
)