library(timeSeries) # Library

reg.df <- function(x, y){ # Actual Data Frame vs Expected by Regression
  
  D <- y[,1]
  
  x <- as.data.frame(x$coefficients[,1]) # Regression coefficients
  
  r <- rownames(x)[-1] # Row names without intercept value
  
  g <- x[1,] # Intercept Value
  
  x <- as.data.frame(x[-1,]) # Reduce first column
  
  a <- rownames(y)
  rownames(x) <- r # Change row names to one without first row name
  
  L <- NULL
  
  for (n in 1:nrow(y)){ s <- t(as.data.frame(as.data.frame(y[n,])[,-1])) 
  
    s <- as.data.frame(s[order(row.names(s)), ])
    
    L <- c(L, s) } # Sum with intercept
    
  L <- list(L)
  
  H <- NULL
  
  for (m in 1:length(L[[1]])){ d <- data.frame(x, as.data.frame(L[[1]][m]))
  
    d$var <- d[,1] * d[,2] # Sum Product of two columns
    
    H <- rbind.data.frame(H, sum(d[,3]) + g) }
    
  rownames(H) <- a
  
  H <- as.timeSeries(H)
  
  df <- cbind.data.frame(D, H)
  
  colnames(df) <- c(sprintf("Actual %s", colnames(D)),
                    sprintf("Expected %s", colnames(D)))
  as.timeSeries(df)
}
reg.df(df.for.backtest, backtest.df) # Test
