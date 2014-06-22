library(shiny)

SampleSize <- function(conf,err) {
        c <- 1-(1-conf/100)/2
        e <- err/100
        z <- qnorm(c) 
        p <- 0.5
        round( z^2*p*(1-p)/e^2, digits=0)
}

shinyServer(
        function(input, output) {
            
                output$oid1 <- renderPrint({input$id1})
                output$oid2 <- renderPrint({input$id2})
                output$size <- renderPrint({SampleSize(input$id1, input$id2)})
                
        }
)


