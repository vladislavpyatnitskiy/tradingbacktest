lapply(c("quantmod", "timeSeries"), require, character.only = T) # lib

df.backtest <- function(x){
  
  y <- c(x, "BZ=F", "HG=F", "NG=F", "GC=F", "SB=F", "CT=F", "KC=F", "CC=F",
         "HE=F", "ZS=F", "ZR=F")
  
  p <- NULL # 4 scenarios: no dates, only start or end dates, both dates
  
  for (A in y){ p <- cbind(p, getSymbols(A, src="yahoo", auto.assign=F)[,4]) }
  
  p <- p[apply(p, 1, function(x) all(!is.na(x))),] # Get rid of NA
  
  if (isTRUE(grepl("-", x))){ x <- gsub("-", "", x) }
  if (isTRUE(grepl("=", x))){ x <- gsub("=", "", x) }
  
  colnames(p) <- c(x, "Brent", "Copper", "Gas", "Gold", "Sugar", "Cotton",
                   "Coffee", "Cocoa", "Hogs", "Soybeans", "Rice")
  
  as.timeSeries(p) # Make it time series and display
}
df.backtest("RUB=X")
