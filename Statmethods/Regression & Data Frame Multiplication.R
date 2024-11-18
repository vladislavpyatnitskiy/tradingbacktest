reg.mult <- function(x, y){ # Multiply Regression values with data frame 
  
  x <- as.data.frame(x$coefficients[,1]) # Regression coefficients
  
  r <- rownames(x)[-1] # Row names without intercept value
  
  g <- x[1,] # Intercept Value
  
  y <- as.data.frame(y[nrow(y),])[,-1] # Select last observation
  
  x <- as.data.frame(x[-1,]) # Reduce first column
  
  rownames(x) <- r # Change row names to one without first row name
  
  y <- t(as.data.frame(y)) # Transpose
  
  y <- as.data.frame(y[order(row.names(y)), ]) # Order alphabetically
  
  l <- data.frame(x, y) # Join 
  
  l$var <- l[,1] * l[,2] # Sum Product of two columns
  
  sum(l[,3]) + g # Sum with intercept
}
reg.mult(df.for.backtest, backtest.df) # Test
