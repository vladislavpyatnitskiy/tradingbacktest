# Trading Backtest

[![R](https://img.shields.io/badge/R-4.x-blue.svg)](https://www.r-project.org/)
![GitHub last commit](https://img.shields.io/github/last-commit/vladislavpyatnitskiy/tradingbacktest.svg)

Welcome to the repository! Here you can find R scripts for statistical arbitrage.

Find factors that have the impact on financial instruments and find profitable opportunities.
```
$Regression
$Regression$MRKV

Call:
lm(formula = r, data = d)

Residuals:
      Min        1Q    Median        3Q       Max 
-0.043560 -0.013364 -0.000031  0.010644  0.051519 

Coefficients:
              Estimate Std. Error t value Pr(>|t|)    
(Intercept)  9.712e-02  2.658e-03  36.541  < 2e-16 ***
Brent        6.699e-04  4.000e-05  16.748  < 2e-16 ***
Cocoa       -4.573e-06  3.886e-07 -11.768  < 2e-16 ***
Coffee      -2.961e-04  1.454e-05 -20.360  < 2e-16 ***
Copper       1.701e-02  1.355e-03  12.554  < 2e-16 ***
Cotton       5.373e-04  4.314e-05  12.452  < 2e-16 ***
Gas         -2.533e-03  5.056e-04  -5.009 5.88e-07 ***
Gold         5.204e-05  1.963e-06  26.512  < 2e-16 ***
Hogs        -2.444e-04  3.734e-05  -6.545 7.23e-11 ***
Rice        -2.873e-05  2.429e-06 -11.827  < 2e-16 ***
Soybeans    -1.104e-04  4.378e-06 -25.212  < 2e-16 ***
Sugar       -7.840e-04  1.524e-04  -5.145 2.90e-07 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 0.01811 on 2386 degrees of freedom
Multiple R-squared:  0.6416,	Adjusted R-squared:  0.6399 
F-statistic: 388.3 on 11 and 2386 DF,  p-value: < 2.2e-16


$Regression$BELU

Call:
lm(formula = r, data = d)

Residuals:
    Min      1Q  Median      3Q     Max 
-279.56  -35.58    0.01   34.54  466.16 

Coefficients:
              Estimate Std. Error t value Pr(>|t|)    
(Intercept) -9.531e+02  1.742e+01 -54.718  < 2e-16 ***
Brent        4.411e-01  1.613e-01   2.735  0.00631 ** 
Cocoa        7.357e-03  1.626e-03   4.525 6.47e-06 ***
Coffee      -2.854e-01  4.898e-02  -5.826 6.77e-09 ***
Copper       8.904e+01  5.325e+00  16.722  < 2e-16 ***
Gas         -5.046e+00  1.770e+00  -2.851  0.00441 ** 
Hogs         9.696e-01  1.598e-01   6.066 1.62e-09 ***
Rice         2.190e-01  1.061e-02  20.637  < 2e-16 ***
Rouble       5.296e+00  2.527e-01  20.955  < 2e-16 ***
Soybeans    -1.449e-01  1.743e-02  -8.317  < 2e-16 ***
Sugar        2.092e+01  8.354e-01  25.046  < 2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 61.54 on 1682 degrees of freedom
Multiple R-squared:  0.9268,	Adjusted R-squared:  0.9263 
F-statistic:  2128 on 10 and 1682 DF,  p-value: < 2.2e-16



$`Data Frame`
     Fair Price Current Price Change (%) Number of Obs. Adjusted R^2
MRKV       0.13        0.1229       5.62           2398    0.6399308
BELU     421.16      379.4000      10.44           1693    0.9263181
```
