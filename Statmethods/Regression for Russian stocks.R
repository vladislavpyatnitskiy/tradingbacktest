lapply(c("quantmod", "timeSeries", "MuMIn", "moexer", "rvest"), require,
       character.only = T) # lib

options(na.action = "na.fail") 

# regression models and fair prices for stocks
rus.regression <- function(x, dataframe=F){ 
  
  redom = list(
    c("AGRO", "RAGR"), c("CIAN", "CNRU"), c("HHRU", "HEAD"), c("FIVE", "X5"),
    c("FIXP", "FIXR"), c("YNDX", "YDEX"))
  
  from = "2007-01-01"
  
  J <- NULL
  R <- NULL
  
  for (n in 1:length(x)){
    
    if (any(sapply(redom, function(redom_item) x[n] %in% redom_item))){
      
      f <- which(sapply(redom, function(redom_item) x[n] %in% redom_item))
      
      for (k in 1:length(redom[[f]])){
        
        a = as.data.frame(
          get_candles(redom[[f]][k], from=from, interval='daily')[,c(3,8)]
        )
        
        if (k == 2){ 
          
          message(
            sprintf(
              "%s is downloaded; %s from %s", x[n], which(x == x[n]), length(x)
            )
          )
        }
        
        a <- a[!duplicated(a),] # Remove duplicates
        
        a <- xts(a[, 1], order.by = as.Date(a[, 2]))
        
        if (x[n] == "AGRO") a <- a / 7.01
        if (x[n] == "FIXP") a <- a / 100     
        
        colnames(a) <- redom[[f]][2]
        
        if (is.null(R)) R <- data.frame(a) else R <- rbind.data.frame(R, a)
      }
    } else {
      
      a = as.data.frame(get_candles(x[n], from=from, interval='daily')[,c(3,8)])
      
      message(
        sprintf(
          "%s is downloaded; %s from %s", 
          x[n], which(x == x[n]), length(x)
        )
      )
      
      a <- a[!duplicated(a),] # Remove duplicates
      
      a <- xts(a[, 1], order.by = as.Date(a[, 2]))
      
      colnames(a) <- x[n]
      
      R <- data.frame(a) 
    }
    
    R <- as.timeSeries(R) # Make it time series
    
    if (x[n] == "BELU"){ j <- which(rownames(R) == "2024-08-15")
    
    R[c(1:j),] <- R[c(1:j),]/8 } # Adjustments for Novabev stock
    
    if (is.null(J)) J <- list(R) else J[[n]] <- R 
    R <- NULL  # Reset R for next iteration
  }
  
  message("Stocks data has been downloaded successfully (1/6)")
  
  smartlab.values <- function(x){ # Current prices for ticker from Smart-Lab
    
    # Retrieve data
    f <- read_html("https://smart-lab.ru/q/shares/") %>% 
      html_nodes('table') %>% html_nodes('tr') %>% html_nodes('td') 
    
    l <- NULL
    
    for (n in 1:length(f)){ # Derive ticker and price data
      
      if (
        isTRUE(f[n] %>% html_attr('class') == "trades-table__ticker") |
        isTRUE(f[n] %>% html_attr('class') == "trades-table__price")
      ){
        
        l <- c(l, f[n] %>% html_text())
      }
    }
    
    D <- data.frame(
      l[seq(from = 1, to = length(l), by = 2)],
      l[seq(from = 2, to = length(l), by = 2)]
    ) # organise into data frame
    
    colnames(D) <- c("Ticker", "Prices") # Assign column names
    
    ticker_names <- D[,1] # Assign tickers to new variable
    
    D <- subset(D, select = -c(1)) # Reduce excess column
    
    rownames(D) <- ticker_names # Assign tickers as row names
    
    for (n in 1:ncol(D)){ D[,n] <- round(as.numeric(D[,n]), 4) } # Numeric
    
    D <- D[x,] # Display
    
    names(D) <- x
    
    D
  }
  s_values <- smartlab.values(x)
  
  message("Current stocks data has been downloaded successfully (2/6)")
  
  y <- c(paste(c("BZ", "HG", "GC", "SB", "CT", "KC", "CC", "LE", "ZS",
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
    
  message("Commodities data has been downloaded successfully (3/6)")
  
  if (isTRUE(grepl("-", y))){ y <- gsub("-", "", y) }
  if (isTRUE(grepl("=", y))){ y <- gsub("=", "", y) }
  
  colnames(p) <- c("Brent", "Copper", "Gold", "Sugar", "Cotton",
                   "Coffee", "Cocoa", "Cattle", "Soybeans", "Rice", "Dollar")
  
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
  
  message("Interest Rate data has been downloaded successfully (4/6)")
  
  rouble.yahoo <- function(){
    
    p <- read_html("https://finance.yahoo.com/quote/RUB=X/") %>%
      html_nodes('section') %>% html_nodes('div') %>% html_nodes('span') %>% 
      html_text() %>% .[1]
    
    as.numeric(gsub(" ", "", p))
  }
  rouble_df <- rouble.yahoo()
  
  message("Rouble data has been downloaded successfully (5/6)")
  
  commodities.yahoo2 <- function(){ # Data Frame with Commodity values
    
    p1 <- read_html("https://finance.yahoo.com/commodities/") %>% 
      html_nodes('table') %>% html_nodes('tr') %>% html_nodes('td') %>% 
      html_nodes('div') # Read HTML
    
    p <- p1 %>% html_nodes('span') %>% html_text() # Extract names 
    
    v <- as.numeric(gsub(",", "", p[seq(from = 3, to = length(p), by = 3)]))
    
    tickers <- gsub(" ", "", p[seq(from = 1, to = length(p), by = 3)]) #Tickers
    
    names(v) <- tickers
    
    v <- v[paste(c(
          "BZ", "HG", "GC", "SB", "CT", "KC", "CC", "LE", "ZS","ZR"
          ), "=F", sep = "")]
    
    v["ZR=F"] = v["ZR=F"] / 100
    
    v <- c(v, as.numeric(rouble_df), as.numeric(cbr[nrow(cbr),]))
    
    df <- as.data.frame(v) # merge names with values
    
    rownames(df) <- c(
      "Brent", "Copper", "Gold", "Sugar", "Cotton", "Coffee", "Cocoa", 
      "Cattle", "Soybeans", "Rice", "Dollar", "Rate")
    
    colnames(df) <- c("Points") # Column names
    
    for (n in 1:ncol(df)){ df[,n] <- as.numeric(df[,n]) } # Make data numeric
    
    df
  }
  commodities_df <- commodities.yahoo2() # Test
  
  message("Live commodity data has been downloaded successfully (6/6)")
  
  a <- as.timeSeries(cbind(a, cbr)) # Make it time series and display
  
  a <- a[apply(a, 1, function(x) all(!is.na(x))),] # Get rid of NA
  
  names_factors <- c(
    "Brent", "Copper", "Gold", "Sugar", "Cotton", "Coffee", "Cocoa", "Cattle", 
    "Soybeans", "Rice", "Dollar", "Rate")
  
  names_factors <- sort(names_factors)
  
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
    
    if (dataframe){ # Last Observations from data frame
      
      v <- as.data.frame(a[nrow(a),]) # Select last observation
      
      v <- t(as.data.frame(v)) } # Transpose
      
    else { v <- commodities_df } # Values from current values
    
    S <- as.data.frame(S[-1,]) # Reduce first column
    
    rownames(S) <- r # Change row names to one without first row name
    
    v <- as.data.frame(v[order(row.names(v)), ]) # Order alphabetically
    
    rownames(v) <- names_factors
    
    v <- v[c(rownames(S)),]
    
    v <- as.data.frame(v)
    
    rownames(v) <- rownames(S)
    
    l <- data.frame(S, v) # Join 
    
    l$var <- l[,1] * l[,2] # Sum Product of two columns
    
    s_v <- s_values[i]
    
    pot_return = round(
      log(
        (sum(l[,3]) + g) / s_v
        ), 4
      ) * 100
    
    if (is.null(reg)){ reg <- list(R) } else { reg[[i]] <- R } 
    
    g <- cbind.data.frame(
      round(sum(l[,3]) + g, 4),
      s_values[i],
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
  
  names(nested_list) <- c(
    "Regression", "Data Frame", "Last Date of Data Frame Observation"
    ) # Names
  
  nested_list # Display
}
rus.regression(c("BISVP", "LKOH"))
