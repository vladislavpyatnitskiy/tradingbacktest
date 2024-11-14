lapply(c("quantmod", "timeSeries", "MuMIn"), require, character.only = T) # lib

options(na.action = "na.fail") 

reg.backtest <- function(x){
  
  y <- c(x, "BZ=F", "HG=F", "NG=F", "GC=F", "SB=F", "CT=F", "KC=F", "CC=F",
         "HE=F", "ZS=F", "ZR=F")
  
  p <- NULL # 4 scenarios: no dates, only start or end dates, both dates
  
  for (A in y){ p <- cbind(p, getSymbols(A, src="yahoo", auto.assign=F)[,4]) }
  
  p <- p[apply(p, 1, function(x) all(!is.na(x))),] # Get rid of NA
  
  if (isTRUE(grepl("-", x))){ x <- gsub("-", "", x) }
  if (isTRUE(grepl("=", x))){ x <- gsub("=", "", x) }
  
  colnames(p) <- c(x, "Brent", "Copper", "Gas", "Gold", "Sugar", "Cotton",
                   "Coffee", "Cocoa", "Hogs", "Soybeans", "Rice")
  
  p <- as.timeSeries(p) # Make it time series and display
  
  l <- NULL # Subset numeric data
  
  for (n in 1:ncol(p)){ if (isTRUE(is.numeric(p[,n]))){ l <- c(l, n) } }
  
  d <- p[,l] # Write a full regression model with all possible variables
  
  for (n in 2:(ncol(d))){ if (isTRUE(n == 2)){ f1 <- colnames(d)[1]
  
    s1 <- colnames(d)[2] # Write formulae of regression with all variables
    
    if (isTRUE(grepl(" ", f1))){ f1 <- sprintf("`%s`", f1) }
    
    if (isTRUE(grepl(" ", s1))){ s1 <- sprintf("`%s`", s1) }
    
    L <- sprintf("%s ~ %s", f1, s1) } else { h1 <- colnames(d)[n]
    
      if (isTRUE(grepl(" ", h1))){ h1 <- sprintf("`%s`", h1) }
    
      L <- sprintf("%s + %s", L, h1) } } # Join all variables
  
  D <- as.data.frame(dredge(lm(L, d))[1,]) # Run all regressions & Select best
  
  D <- colnames(D[,apply(D, 2, function(x) all(!is.na(x)))]) # Cut false values
  
  D <- D[c(2:(length(D) - 5))] # Select names of regression values
  
  r <- NULL # Run Optimal regression with valid variables
  
  for (n in 1:length(D)){ if (isTRUE(n == 1)){
    
    r <- sprintf("%s ~ %s",f1,D[1]) } else { r <- sprintf("%s + %s",r,D[n]) } }
  
  summary(lm(r, d)) # Display the most optimal regression model
}
reg.backtest("RUB=X")
