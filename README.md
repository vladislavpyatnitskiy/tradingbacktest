# Trading Backtest

[![R](https://img.shields.io/badge/R-4.x-blue.svg)](https://www.r-project.org/)
![GitHub last commit](https://img.shields.io/github/last-commit/vladislavpyatnitskiy/tradingbacktest.svg)

Welcome to the repository! Here you can find R scripts for statistical arbitrage.

Find factors that have the impact on financial instruments and find profitable opportunities.

For Instruments available via Yahoo! Finance:
```
$Regression
$Regression$XOM

Call:
lm(formula = r, data = d)

Residuals:
    Min      1Q  Median      3Q     Max 
-43.172  -7.679   1.312   7.234  47.167 

Coefficients:
              Estimate Std. Error t value Pr(>|t|)    
(Intercept) 36.0491281  1.4078279  25.606  < 2e-16 ***
Brent        0.5767861  0.0173964  33.156  < 2e-16 ***
Cocoa        0.0037099  0.0001997  18.581  < 2e-16 ***
Coffee       0.1146894  0.0074904  15.311  < 2e-16 ***
Copper      -6.5245118  0.5541692 -11.774  < 2e-16 ***
Cotton      -0.2776988  0.0129921 -21.374  < 2e-16 ***
Gas         -0.2498377  0.1712093  -1.459  0.14458    
Gold        -0.0140115  0.0010149 -13.806  < 2e-16 ***
Hogs         0.0500330  0.0166764   3.000  0.00271 ** 
Rice        -0.0036154  0.0012276  -2.945  0.00325 ** 
Rouble       0.4307849  0.0154253  27.927  < 2e-16 ***
Soybeans     0.0071155  0.0016366   4.348 1.41e-05 ***
Sugar        0.3830150  0.0597562   6.410 1.63e-10 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 11.64 on 3938 degrees of freedom
Multiple R-squared:  0.5766,	Adjusted R-squared:  0.5753 
F-statistic: 446.8 on 12 and 3938 DF,  p-value: < 2.2e-16


$Regression$AMZN

Call:
lm(formula = r, data = d)

Residuals:
    Min      1Q  Median      3Q     Max 
-91.775 -11.812  -0.309  12.193  87.046 

Coefficients:
              Estimate Std. Error t value Pr(>|t|)    
(Intercept) -1.368e+02  2.239e+00 -61.097  < 2e-16 ***
Brent       -4.536e-01  2.766e-02 -16.396  < 2e-16 ***
Cocoa        5.868e-04  3.175e-04   1.848  0.06466 .  
Coffee      -2.551e-01  1.191e-02 -21.412  < 2e-16 ***
Copper       2.168e+01  8.813e-01  24.605  < 2e-16 ***
Cotton       3.073e-01  2.066e-02  14.873  < 2e-16 ***
Gas          6.203e+00  2.723e-01  22.784  < 2e-16 ***
Gold         7.140e-02  1.614e-03  44.237  < 2e-16 ***
Hogs         1.002e-01  2.652e-02   3.779  0.00016 ***
Rice         8.625e-03  1.952e-03   4.418 1.02e-05 ***
Rouble       1.497e+00  2.453e-02  61.020  < 2e-16 ***
Soybeans    -1.977e-02  2.603e-03  -7.597 3.76e-14 ***
Sugar       -1.572e+00  9.503e-02 -16.540  < 2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 18.52 on 3938 degrees of freedom
Multiple R-squared:  0.9253,	Adjusted R-squared:  0.9251 
F-statistic:  4067 on 12 and 3938 DF,  p-value: < 2.2e-16



$`Data Frame`
     Fair Price Current Price Change (%) Number of Obs. Adjusted R^2
XOM       76.09        110.64     -37.44           3951    0.5752618
AMZN     282.66        214.47      27.61           3951    0.9250992
```
For Russian Financial Instruments:
```
$Regression
$Regression$NVTK

Call:
lm(formula = r, data = d)

Residuals:
    Min      1Q  Median      3Q     Max 
-560.25 -116.72  -15.16   95.95 1379.85 

Coefficients:
              Estimate Std. Error t value Pr(>|t|)    
(Intercept) -608.21252   28.98365 -20.985  < 2e-16 ***
Brent          3.51860    0.39373   8.937  < 2e-16 ***
Cocoa         -0.04668    0.00388 -12.031  < 2e-16 ***
Coffee         0.31171    0.10879   2.865  0.00420 ** 
Copper       188.75052    9.46032  19.952  < 2e-16 ***
Cotton         3.62806    0.37629   9.642  < 2e-16 ***
Dollar        21.90706    0.46868  46.742  < 2e-16 ***
Hogs           1.02384    0.34529   2.965  0.00305 ** 
Rate         -45.71042    1.60355 -28.506  < 2e-16 ***
Rice          -0.07711    0.02348  -3.284  0.00104 ** 
Soybeans      -0.56434    0.04077 -13.842  < 2e-16 ***
Sugar          9.73869    1.50812   6.457 1.27e-10 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 177.7 on 2597 degrees of freedom
Multiple R-squared:  0.7815,	Adjusted R-squared:  0.7806 
F-statistic: 844.6 on 11 and 2597 DF,  p-value: < 2.2e-16


$Regression$GAZP

Call:
lm(formula = r, data = d)

Residuals:
    Min      1Q  Median      3Q     Max 
-79.480 -26.103  -4.083  17.237 120.493 

Coefficients:
             Estimate Std. Error t value Pr(>|t|)    
(Intercept) 44.669778   6.249800   7.147 1.16e-12 ***
Brent       -0.370199   0.076618  -4.832 1.44e-06 ***
Cocoa       -0.003890   0.000817  -4.762 2.03e-06 ***
Coffee       0.316405   0.027482  11.513  < 2e-16 ***
Copper      21.295343   2.594211   8.209 3.57e-16 ***
Cotton       1.486323   0.085422  17.400  < 2e-16 ***
Dollar       1.439619   0.111153  12.952  < 2e-16 ***
Gold        -0.033564   0.003174 -10.576  < 2e-16 ***
Hogs         0.335789   0.074527   4.506 6.93e-06 ***
Rate        -7.308891   0.324913 -22.495  < 2e-16 ***
Soybeans    -0.039670   0.007829  -5.067 4.35e-07 ***
Sugar       -1.297698   0.316516  -4.100 4.27e-05 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 36.25 on 2445 degrees of freedom
Multiple R-squared:  0.551,	Adjusted R-squared:  0.549 
F-statistic: 272.8 on 11 and 2445 DF,  p-value: < 2.2e-16



$`Data Frame`
     Fair Price Current Price Change (%) Number of Obs. Adjusted R^2
NVTK    1325.42       1162.90      13.08           2609         0.78
GAZP     109.31        126.18     -14.35           2457         0.55

$Date
[1] "2026-02-17"
```
