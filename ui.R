library(shiny)
shinyUI(pageWithSidebar(
        headerPanel("Sample Size Calculator"),
        
        sidebarPanel(
                helpText("This calculator provides the sample size needed under the requirement of population proportion interval estimate at certain confidence level, margin of error, and 50% planned proportion estimate.",
                         "Please fill the parameters below in order to get the sample size you would need:"),
                
                numericInput('id1','Confidence level (%):', 95, min=90, max=99.9, step=0.1),
                numericInput('id2','Margin of error (%):', 5, min=1, max=100, step=1)
        ),
        mainPanel(
                h3('Sample Size'),
                h4('Confidence level:'),
                verbatimTextOutput("oid1"),
                h4('Margin of error:'),
                verbatimTextOutput("oid2"),
                h4('Recommended sample size:'),
                verbatimTextOutput("size")
       
        )
))
