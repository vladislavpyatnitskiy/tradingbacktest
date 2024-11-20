library(timeSeries) # Library

reg.df <- function(x, y){ # Multiply Regression values with data frame 
  
  D <- y[,1] # Subset first column from main data set
  
  x <- as.data.frame(x$coefficients[,1]) # Regression coefficients
  
  r <- rownames(x)[-1] # Row names without intercept value
  
  g <- x[1,] # Intercept Value
  
  x <- as.data.frame(x[-1,]) # Reduce first column
  
  a <- rownames(y) # Subset row names with dates
  
  rownames(x) <- r # Change row names to one without first row name
  
  L <- NULL # Make data frame of observations to group of vectors
  
  for (n in 1:nrow(y)){ s <- t(as.data.frame(as.data.frame(y[n,])[,-1])) 
  
    L <- c(L, s <- as.data.frame(s[order(row.names(s)), ])) } 
    
  L <- list(L) # Convert group of vectors to nested list
  
  H <- NULL # Create Data Frame of Expected Values from Regression output
  
  for (m in 1:length(L[[1]])){ d <- data.frame(x, as.data.frame(L[[1]][m]))
  
    d$var <- d[,1] * d[,2] # Multiply column values
    
    H <- rbind.data.frame(H, sum(d[,3]) + g) } # Sum intercept with products
    
  rownames(H) <- a # Assign dates as row names
  
  df <- cbind.data.frame(D, as.timeSeries(H)) # Join
  
  colnames(df) <- c(sprintf("Actual %s", colnames(D)),
                    sprintf("Expected %s", colnames(D))) # Change column names
  as.timeSeries(df)
}
reg.df(df.for.backtest, backtest.df) # Test
