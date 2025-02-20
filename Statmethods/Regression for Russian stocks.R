lapply(c("quantmod", "timeSeries", "MuMIn", "rvest"), require,
       character.only = T) # lib

options(na.action = "na.fail") 

rus.regression <- function(x){
  
  y <- read_html(x) %>% html_nodes('body') %>% html_nodes('p') %>% html_text()
  
  d <- unlist(strsplit(as.character(gsub('["\r"]', '',
                                         strsplit(toString(y),
                                                  "\\n")[[1]])),"\\,"))
  
  D <- data.frame(d[seq(from = 1, to = length(d), by = 6)],
                  d[seq(from = 5, to = length(d), by = 6)])
  
  D <- D[-1,] # Eliminate excessive row
  
  dates <- D[,1] # Subtract dates from main data frame
  
  D <- as.data.frame(as.numeric(D[,-1])) #
  
  rownames(D) <- dates # Assign dates as row names
  
  D <- as.timeSeries(D) # Make data time series
  
  w <- unlist(strsplit(as.character(x), "D1"))[2] # Clean URL for ticker 
  w <- strsplit(toString(strsplit(toString(as.character(w)),
                                  "\\/")[[1]][2]), "\\_")[[1]][1]  
  
  colnames(D) <- c(w) # Assign Column name
  
  y <- c("BZ=F", "HG=F", "NG=F", "GC=F", "SB=F", "CT=F", "KC=F", "CC=F",
         "HE=F", "ZS=F", "ZR=F")
  
  p <- NULL # 4 scenarios: no dates, only start or end dates, both dates
  
  for (A in y){ p <- cbind(p, getSymbols(A, src="yahoo", auto.assign=F)[,4]) }
  
  p <- p[apply(p, 1, function(x) all(!is.na(x))),] # Get rid of NA
  
  if (isTRUE(grepl("-", y))){ y <- gsub("-", "", y) }
  if (isTRUE(grepl("=", y))){ y <- gsub("=", "", y) }
  
  colnames(p) <- c("Brent", "Copper", "Gas", "Gold", "Sugar", "Cotton",
                   "Coffee", "Cocoa", "Hogs", "Soybeans", "Rice")
  
  a <- as.timeSeries(p) # Make it time series and display
  
  p <- cbind(D, a)
  
  p <- p[apply(p, 1, function(x) all(!is.na(x))),] # Get rid of NA
  
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
    
      r <- sprintf("%s ~ %s",f1,D[1]) } else {
      
      r <- sprintf("%s + %s",r,D[n]) } }
  
  R <- summary(lm(r, d)) # Display the most optimal regression model
  
  S <- as.data.frame(R$coefficients[,1]) # Regression coefficients
  
  r <- rownames(S)[-1] # Row names without intercept value
  
  g <- S[1,] # Intercept Value
  
  v <- as.data.frame(a[nrow(a),]) # Select last observation
  
  S <- as.data.frame(S[-1,]) # Reduce first column
  
  rownames(S) <- r # Change row names to one without first row name
  
  v <- t(as.data.frame(v)) # Transpose
  
  v <- as.data.frame(v[order(row.names(v)), ]) # Order alphabetically
  
  v <- v[c(rownames(S)),]
  
  v <- as.data.frame(v)
  
  rownames(v) <- rownames(S)
  
  l <- data.frame(S, v) # Join 
  
  l$var <- l[,1] * l[,2] # Sum Product of two columns
  
  list(R, sprintf("The fair price is %s", round(sum(l[,3]) + g, 2)))
}
