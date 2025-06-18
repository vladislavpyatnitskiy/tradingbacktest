# Trading Backtest

[![R](https://img.shields.io/badge/R-4.x-blue.svg)](https://www.r-project.org/)
![GitHub last commit](https://img.shields.io/github/last-commit/vladislavpyatnitskiy/tradingbacktest.svg)

Welcome to the repository! Here you can find R scripts for statistical arbitrage.

Find factors that have the impact on financial instruments and find profitable opportunities.
```
[[1]]

Call:
lm(formula = r, data = d)

Residuals:
     Min       1Q   Median       3Q      Max 
-27.2466  -4.6936   0.5838   4.9901  21.7797 

Coefficients:
              Estimate Std. Error t value Pr(>|t|)    
(Intercept) -8.8678846  1.1900923  -7.451 1.29e-13 ***
Brent       -0.1162974  0.0165850  -7.012 3.06e-12 ***
Cocoa       -0.0013329  0.0001739  -7.664 2.62e-14 ***
Coffee      -0.1602130  0.0062071 -25.811  < 2e-16 ***
Copper      19.6144036  0.5590797  35.083  < 2e-16 ***
Cotton       0.4357240  0.0178247  24.445  < 2e-16 ***
Gas         -0.9244687  0.2025644  -4.564 5.28e-06 ***
Gold         0.0057905  0.0009586   6.040 1.79e-09 ***
Hogs        -0.0405336  0.0149006  -2.720  0.00657 ** 
Rice        -0.0053640  0.0009742  -5.506 4.07e-08 ***
Rouble       0.2467475  0.0224000  11.016  < 2e-16 ***
Soybeans    -0.0324147  0.0017036 -19.027  < 2e-16 ***
Sugar        0.6515883  0.0631133  10.324  < 2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 6.923 on 2325 degrees of freedom
Multiple R-squared:  0.7806,	Adjusted R-squared:  0.7795 
F-statistic: 689.5 on 12 and 2325 DF,  p-value: < 2.2e-16


[[2]]
[1] "Fair price is 37.28"    "Current Price 31.275"   "Potential Upside: 18 %"
```
