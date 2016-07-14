library(shiny)
library(ggplot2)
data("mtcars")
fit<-lm(mpg~wt,data=mtcars)
pred<-function(wt) predict(fit, data.frame(wt=wt), interval="predict")
data1<-mtcars[mtcars$disp<196.3,]
data2<-mtcars[-(mtcars$disp<196.3),]
fit1<-lm(mpg~wt,data=data1)
fit2<-lm(mpg~wt,data=data2)
pred1<-function(wt,disp) if (disp==1) {
    predict(fit1, data.frame(wt=wt), interval="predict")
  } else {
    predict(fit2, data.frame(wt=wt), interval="predict")
  }
  

shinyServer(
  function(input, output) {
    output$inputValue <- renderPrint({input$wt})
    output$prediction1 <- renderPrint({pred(input$wt)[1]})
    output$prediction2 <- renderPrint({paste(c("["),pred(input$wt)[2],c(";"),
       pred(input$wt)[3],c("]"))})
    output$prediction3 <- renderPrint({pred1(input$wt,input$disp)[1]})
    output$prediction4 <- renderPrint({paste(c("["),pred1(input$wt,input$disp)[2],c(";"),
                                               pred1(input$wt,input$disp)[3],c("]"))})
    output$myPlot<-renderPlot({
      ggplot(mtcars, aes(x = wt, y = mpg)) + 
        geom_point() +
        stat_smooth(method = "lm", col = "red")+
        geom_segment(aes(x = input$wt, y = pred(input$wt)[2],
            xend = input$wt, yend = pred(input$wt)[3], col= "Prediction interval"))
    })
  }
)