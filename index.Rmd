---
title       : Course Project - Shiny Application and Reproducible Pitch
subtitle    : Developing Data Products
author      : Mariano Silva
job         : Dataminer
framework   : io2012        # {io2012, html5slides, shower, dzslides, ...}
highlighter : highlight.js  # {highlight.js, prettify, highlight}
hitheme     : tomorrow      # 
widgets     : []            # {mathjax, quiz, bootstrap}
mode        : selfcontained # {standalone, draft}
knit        : slidify::knit2slides
---

## Summary

This documentation is to support my shiny application developed for the
Developing Data Products' course project.

You can see my shiny application running in the following link:

https://mhsilvav.shinyapps.io/ms-shiny-app/

Also, you can see server.R and ui.R in my github repository:

https://github.com/mhsilvav/DDP_CourseProject/

--- 

## Context

Basically my shiny application is a simple application that solves the computation of the representative sample size from a population. The sample size is an important feature of any empirical study in which the goal is to make inferences about a population from a sample.

So, with this shiny application, the formula below provide the sample size needed under the requirement of population proportion interval estimate at certain confidence level <code>(1-a)</code>, margin of error <code>e</code>, and planned proportion estimate <code>p</code>. Here, <code>z</code> is the <code>100(1-a)</code> percentile of the standard normal distribution.

n = z<sup>2</sup> * p * (1−p) / e<sup>2</sup>


So, the problem is solved using a 50% planned proportion estimate, and finding the sample size needed to achieve certain % margin of error at certain % confidence level. 

--- 

## My shiny application

My shiny application consists of two files:

- ui.R
- server.R

In server.R we will use a function to get the percentile of the normal distribution at the upper tail. 
Therefore, z is given by qnorm() command.


--- 

## ui.R

```
library(shiny)
shinyUI(pageWithSidebar(
        headerPanel("Sample Size Calculator"),
        sidebarPanel(
                helpText("This calculator .....",
                         "Please fill the parameters below in order to get the
                         sample size you would need:"),
                numericInput('id1','Confidence level (%):', 95, min=90, max=99.9, step=0.1),
                numericInput('id2','Margin of error (%):', 5, min=1, max=100, step=1)
        ),
        mainPanel(
                h3('Sample Size'),
                h4('Confidence level:'), verbatimTextOutput("oid1"),
                h4('Margin of error:'), verbatimTextOutput("oid2"),
                h4('Recommended sample size:'), verbatimTextOutput("size")
        )
))

```

--- 

## server.R

```
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
```
