
library(shiny)

data(swiss)
library(ggplot2); library(gridExtra)

eyfn <- function (y, x2) resid(lm(y ~ x2, data = swiss))
ex1fn <- function(x1, x2) resid(lm(x1 ~ x2, data = swiss))
fitfn <- function(y, x1, x2) lm(y ~ x1 + x2, data = swiss)

shinyServer(function(input, output) {
    
    pt1 <- reactive({
        if (!input$p1) return(NULL)
        
            yl <- substring(input$yvar, 7)
            x1l <- substring(input$x1var, 7)
            x2l <- substring(input$x2var, 7)
        
            g1 <- ggplot(swiss, aes(y = eval(parse(text=input$yvar)), 
                                    x = eval(parse(text=input$x1var)), colour = eval(parse(text=input$x2var))))
            g1 <- g1 + geom_point(colour="grey50", size = 5) + geom_smooth(method = lm, se = TRUE, colour = "black") 
            g1 <- g1 + geom_point(size = 4) 
            g1 <- g1 + ylab(paste("y =", yl, sep = " "))
            g1 <- g1 + xlab(paste("x1 =", x1l, sep = " "))
            g1 <- g1 + scale_colour_gradient(name  = paste("x2 =", x2l, sep = " "))
            g1 <- g1 + ggtitle("Plot for unajusted effect")
            g1
        
    })
    
    pt2 <- reactive({
        if (!input$p2) return(NULL)
        
            y <- eval(parse(text=input$yvar))
            x1 <- eval(parse(text=input$x1var))
            x2 <- eval(parse(text=input$x2var))
            
            ey <- eyfn(y, x2)
            ex1 <- ex1fn(x1, x2)
            
            g2 <- ggplot(swiss, aes(y = ey, x = ex1, colour = x2))
            g2 <- g2 + geom_point(colour="grey50", size = 5) + geom_smooth(method = lm, se = FALSE, colour = "black") + geom_point(size = 4) 
            g2 <- g2 + ylab("resid(lm(y ~ x2))")
            g2 <- g2 + xlab("resid(lm(x1 ~ x2))")
            g2 <- g2 + ggtitle("Residual Plot (adjusted for x2-variable)")
            g2
        
    })
    
    output$msg <- renderPrint({
        
        if (!input$p1 & !input$p2) print("How boring! No plot chosen.")
    })
    
    output$plot <- renderPlot({
       
        ptlist <- list(pt1(), pt2())
        to_delete <- !sapply(ptlist, is.null)
        
        ptlist <- ptlist[to_delete]
        if (length(ptlist)==0) return(NULL)
        
        grid.arrange(grobs=ptlist, ncol=length(ptlist))
        
    })

    output$coef <- renderPrint({
        
        y <- eval(parse(text=input$yvar))
        x1 <- eval(parse(text=input$x1var))
        x2 <- eval(parse(text=input$x2var))
        fit <- fitfn(y, x1, x2)
        coefficients(fit)

    })
    
    output$model <- renderPrint({
        yl <- substring(input$yvar, 7)
        if(yl == "Fertility") {
            fit <- lm(Fertility ~ ., data = swiss); summary(fit)
        }  else if (yl == "Agriculture") {
            fit <- lm(Agriculture ~ ., data = swiss); summary(fit)
        }  else if (yl == "Examination") {
            fit <- lm(Examination ~ ., data = swiss); summary(fit)
        } else if (yl == "Education") {
            fit <- lm(Examination ~ ., data = swiss); summary(fit)
        } else if (yl == "Catholic") {
            fit <- lm(Examination ~ ., data = swiss); summary(fit)
          } else {
            fit <- lm(Infant.Mortality ~ ., data = swiss); summary(fit)
     }
   })
})
