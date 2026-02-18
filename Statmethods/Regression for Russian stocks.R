lapply(c("quantmod", "timeSeries", "MuMIn", "moexer", "rvest"), require,
       character.only = T) # lib

options(na.action = "na.fail") 

rus.regression <- function(x){ # regression models and fair prices for stocks
  
  J <- NULL
  
  for (n in 1:length(x)){ # Get data of Russian stocks
    
    D = as.data.frame(get_candles(x[n],"2007-01-01",interval='daily')[,c(3,8)])
    
    D <- D[!duplicated(D),] # Remove duplicates
    
    D <- xts(D[,1], order.by = as.Date(D[,2])) # Move dates to row names
    
    D <- D[apply(D, 1, function(x) all(!is.na(x))),] # Get rid of NA
    
    colnames(D) <- x[n] # Put the tickers in data set
    
    D <- as.timeSeries(D) # Make it time series
    
    if (x[n] == "BELU"){ f <- which(rownames(D) == "2024-08-15")
    
    D[c(1:f),] <- D[c(1:f),]/8 } # Adjustments for Novabev stock
    
    message(
      sprintf(
        "%s is downloaded; %s from %s", 
        x[n], which(x == x[n]), length(x)
        )
      )
    
    if (is.null(J)){ J <- list(D) } else { J[[n]] <- D } }
  
  message("Stocks data has been downloaded successfully")
  
  y <- c(paste(c("BZ", "HG", "GC", "SB", "CT", "KC", "CC", "HE", "ZS",
                 "ZR"), "=F", sep = ""), "RUB=X") # tickers 
  
  p <- NULL # 4 scenarios: no dates, only start or end dates, both dates
  
  for (A in y){ p <- cbind(p, getSymbols(A, src="yahoo", auto.assign=F)[,4]) 
  
    message(
      sprintf(
        "%s is downloaded; %s from %s", 
        A, which(y == A), length(y)
      )
    )
  }
  
  message("Commodities data has been downloaded successfully")
  
  if (isTRUE(grepl("-", y))){ y <- gsub("-", "", y) }
  if (isTRUE(grepl("=", y))){ y <- gsub("=", "", y) }
  
  colnames(p) <- c("Brent", "Copper", "Gold", "Sugar", "Cotton",
                   "Coffee", "Cocoa", "Hogs", "Soybeans", "Rice", "Dollar")
  
  a <- as.timeSeries(p) # Make it time series and display
  
  cir <- function(s, e){
    
    if (as.Date(s, format = "%d.%m.%Y") < "2013-09-17") s = "17.09.2013"
    
    L <- sprintf(
      paste(
        "https://www.cbr.ru/eng/hd_base/KeyRate/",
        "?UniDbQuery.Posted=",
        "True&UniDbQuery.From=%s&UniDbQuery.To=%s",
        sep = ""),
      s, e)
    
    B <- read_html(L) %>% html_nodes('table') %>% html_nodes('tr') %>%
      html_nodes('td') %>% html_text() 
    
    v <- data.frame(
      B[seq(from = 1, to = length(B), by = 2)],
      B[seq(from = 2, to = length(B), by = 2)]
    )
    
    colnames(v) <- c("Date", "Interest Rate")
    
    v$Date <- as.Date(v$Date, format = "%d.%m.%Y")
    
    v <- v[order(v$Date, decreasing = F), ]
    
    dates <- v[,1]
    
    v <- as.data.frame(v[,-1])
    
    rownames(v) <- dates
    colnames(v) <- "Rate"
    
    for (n in 1:ncol(v)){ v[,n] <- as.numeric(v[,n]) }
    
    as.timeSeries(v)
  }
  
  cbr = cir("17.09.2013", as.Date(Sys.Date())) # Interest Rate Data
  
  message("Interest Rate data has been downloaded successfully")
  
  a <- as.timeSeries(cbind(a, cbr)) # Make it time series and display
  
  a <- a[apply(a, 1, function(x) all(!is.na(x))),] # Get rid of NA
  
  reg <- NULL
  df <- NULL
  
  for (i in 1:length(J)){ # Make optimal regression model for each stock
    
    p <- cbind(J[[i]], a) # Join
    
    p <- p[apply(p, 1, function(x) all(!is.na(x))),] # Get rid of NA
    
    l <- NULL # Subset numeric data
    
    for (n in 1:ncol(p)){ if (isTRUE(is.numeric(p[,n]))){ l <- c(l, n) } }
    
        d <- p[,l] # Write a full regression model with all possible variables
        
        for (n in 2:(ncol(d))){ if (isTRUE(n == 2)){ f1 <- colnames(d)[1]
        
            s1 <- colnames(d)[2] # formulae of regression with all variables
            
            if (isTRUE(grepl(" ", f1))){ f1 <- sprintf("`%s`", f1) }
            
            if (isTRUE(grepl(" ", s1))){ s1 <- sprintf("`%s`", s1) }
            
            L <- sprintf("%s ~ %s", f1, s1) } else { h1 <- colnames(d)[n]
            
            if (isTRUE(grepl(" ", h1))){ h1 <- sprintf("`%s`", h1) }
            
            L <- sprintf("%s + %s", L, h1) } } # Join all variables
            
    D <- as.data.frame(dredge(lm(L, d))[1,]) #Run all regressions & Select best
    
    D <- colnames(D[,apply(D,2,function(x) all(!is.na(x)))]) # Cut false values
    
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
    
    pot_return = round(log(round(sum(l[,3]) + g, 2) / p[nrow(p), 1]), 4) * 100
    
    if (is.null(reg)){ reg <- list(R) } else { reg[[i]] <- R } 
    
    g <- cbind.data.frame(
      round(sum(l[,3]) + g, 2),
      p[nrow(p), 1],
      pot_return,
      nrow(p),
      round(R[[9]], 2)
    )
    
    colnames(g) <- c(
      "Fair Price", "Current Price", "Change (%)", "Number of Obs.",
      "Adjusted R^2"
    )
    
    rownames(g) <- x[i]
    
    df <- rbind.data.frame(df, g) # Merge rows to data frame
  }
  df <- df[order(-df$`Change (%)`), ] # Sort by price change level
  
  # Add regressions, data frame and date to list
  nested_list <- list(reg, df, rownames(a)[nrow(a)]) 
  
  names(nested_list[[1]]) <- x # Assign tickers
  
  names(nested_list) <- c("Regression", "Data Frame", "Date") # Names
  
  nested_list # Display
}
rus.regression(c("BISVP", "LKOH"))
