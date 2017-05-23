#Swiss-Data UI
library(shiny)

shinyUI(
    pageWithSidebar(
        headerPanel("Swiss Data"),
        sidebarPanel(
            h4("Choose Variables"),
            selectInput("yvar", "Choose y-Variable",
                        c("Fertility" = "swiss$Fertility",
                          "Agriculture" = "swiss$Agriculture", 
                          "Examination" = "swiss$Examination", 
                          "Education" = "swiss$Education", 
                          "Catholic" = "swiss$Catholic", 
                          "Infant Mortality" = "swiss$Infant.Mortality"), selected = "swiss$Fertility"),
            
            selectInput("x1var", "Choose first x-Variable",
                        c("Fertility" = "swiss$Fertility",
                          "Agriculture" = "swiss$Agriculture", 
                          "Examination" = "swiss$Examination", 
                          "Education" = "swiss$Education", 
                          "Catholic" = "swiss$Catholic", 
                          "Infant Mortality" = "swiss$Infant.Mortality"), selected = "swiss$Agriculture"),
            
            selectInput("x2var", "Choose second x-(color-)Variable",
                        c("Fertility" = "swiss$Fertility",
                          "Agriculture" = "swiss$Agriculture", 
                          "Examination" = "swiss$Examination", 
                          "Education" = "swiss$Education", 
                          "Catholic" = "swiss$Catholic", 
                          "Infant Mortality" = "swiss$Infant.Mortality"), selected = "swiss$Examination"),
            
            checkboxInput("p1", "Show plot for unajusted effect", value = T),
            checkboxInput("p2", "Show residual plot", value = T),
            h5("Uncheck both plots for map of French speaking region of Switzerland."),
            submitButton('Submit')
        ),
        
        mainPanel(
            tabsetPanel(type = "tabs",
                        tabPanel("Plots", br(),
                                 verbatimTextOutput("msg"),
                                 plotOutput("plot"),
                                 h5("Coefficients"),
                                 verbatimTextOutput("coef")),   
                        tabPanel("Summary", br(),
                                 h4("Summary of Model With All Variables"),
                                 verbatimTextOutput("model")),
                        tabPanel("Documentation", br(),
                                 h4("Context"),
                                 h5("In the context of multivariate regression, the so-called Simpson's Paradox points out, that unadjusted and adjusted effects can be the reverse of each other. In other words, the apparent relationship between X and Y may change when accounting for Z. Note, however, that this effect is in fact not at all a paradox but the logical consequence of multivariate regression depending on the compound impact of different regressors."),
                                 h5("The Swiss Data App visualizes this connection. It allows for playing around with different sets of output and regressor variables."),
                                 h5("The Swiss dataset is a data frame with 47 observations on 6 variables (each of which is in percent). The data come from each of the French-speaking provinces of Switzerland at about 1888."),
                                 h4("Functionality"),
                                 h5("You can choose the y and two x variables from the six variables of the dataset"),
                                 h6("* Fertility: a common standardized fertility measure" , br(), "* Agriculture: percent of males involved in agriculture as occupation" , br(), "* Examination: percent draftees receiving highest on army examination" , br(), "* Education: percent education beyond primary school for draftees" , br(), "* Catholic: percent catholic (as opposed to protestant)" , br(), "* Infant.Mortality: live births who live less than 1 year"),
                                 h6("(More details on ", a("stat.ethz", href="https://stat.ethz.ch/R-manual/R-devel/library/datasets/html/swiss.html", target="_blank"), ")."),
                                 h5("The app renders two plots: one for the unadjusted effect and a residual plot adjusting both the y and the x1 variable by taking the residual after having regressed x2. This gives the correct relationship between x1 and y."),
                                 h5("Additionally, the app prints the summary of the full linear regression including all variables."),
                                 h4("Reference"),
                                 h5("The app was inspired by the Book Regression Models for Data Science In R by Brian Caffo, pp. 59-62, published 2015-08-05 on ", a("leanpub", href="http://leanpub.com/regmods", target="_blank"), ".")
                 )
            )        
        )    
    )
)    


