# Trading Backtest

[![R](https://img.shields.io/badge/R-4.x-blue.svg)](https://www.r-project.org/)
![GitHub last commit](https://img.shields.io/github/last-commit/vladislavpyatnitskiy/tradingbacktest.svg)

Welcome to the repository! Here you can find R scripts for statistical arbitrage.

Find factors that have the impact on financial instruments and find profitable opportunities.
```
$Regression
$Regression$BISVP

Call:
lm(formula = r, data = d)

Residuals:
    Min      1Q  Median      3Q     Max 
-5.2376 -0.7499 -0.1232  0.6927  6.4799 

Coefficients:
              Estimate Std. Error t value Pr(>|t|)    
(Intercept) -9.955e+00  2.230e-01 -44.648  < 2e-16 ***
Brent        8.194e-03  3.146e-03   2.604  0.00927 ** 
Cocoa        7.454e-05  3.115e-05   2.393  0.01679 *  
Coffee      -2.165e-02  1.194e-03 -18.131  < 2e-16 ***
Copper       5.162e-01  1.013e-01   5.095 3.79e-07 ***
Gas         -1.710e-01  3.708e-02  -4.613 4.20e-06 ***
Gold         2.888e-03  1.589e-04  18.179  < 2e-16 ***
Rice         3.187e-03  1.902e-04  16.760  < 2e-16 ***
Rouble       7.164e-02  4.214e-03  16.999  < 2e-16 ***
Soybeans     7.122e-04  3.034e-04   2.348  0.01899 *  
Sugar        2.266e-01  1.296e-02  17.487  < 2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 1.373 on 2089 degrees of freedom
Multiple R-squared:  0.8375,	Adjusted R-squared:  0.8367 
F-statistic:  1077 on 10 and 2089 DF,  p-value: < 2.2e-16


$Regression$LKOH

Call:
lm(formula = r, data = d)

Residuals:
    Min      1Q  Median      3Q     Max 
-2775.0  -414.9   -62.8   382.4  4090.7 

Coefficients:
              Estimate Std. Error t value Pr(>|t|)    
(Intercept) -1.995e+03  8.215e+01 -24.290  < 2e-16 ***
Brent        1.389e+01  1.013e+00  13.714  < 2e-16 ***
Cocoa       -3.914e-02  1.173e-02  -3.335  0.00086 ***
Coffee      -8.087e+00  4.329e-01 -18.682  < 2e-16 ***
Copper       7.762e+02  3.304e+01  23.495  < 2e-16 ***
Cotton       5.421e+00  7.827e-01   6.926 5.07e-12 ***
Gas          9.817e+01  9.595e+00  10.232  < 2e-16 ***
Gold         1.084e+00  6.152e-02  17.620  < 2e-16 ***
Hogs        -6.470e+00  9.767e-01  -6.625 3.97e-11 ***
Rouble       7.067e+01  9.762e-01  72.394  < 2e-16 ***
Soybeans    -1.610e+00  9.153e-02 -17.592  < 2e-16 ***
Sugar       -3.152e+01  3.513e+00  -8.970  < 2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 681.5 on 3756 degrees of freedom
Multiple R-squared:  0.8792,	Adjusted R-squared:  0.8788 
F-statistic:  2485 on 11 and 3756 DF,  p-value: < 2.2e-16



$`Data Frame`
      Fair Price Current Price Change %
BISVP       9.76          9.07     7.33
LKOH     7255.18       6026.50    18.55
```
