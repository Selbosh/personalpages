Anscombe's quartet
==================

[From Wikipedia](https://en.wikipedia.org/wiki/Anscombe%27s_quartet)

Introduction
------------

**Anscombe's quartet** comprises four data sets that have nearly identical _simple descriptive statistics_, yet have very different _distributions_ and appear very different when graphed.

Each dataset consists of eleven $(x,y)$ points.
They were constructed in 1973 by the statistician Francis Anscombe to demonstrate both the importance of graphing data before analysing it and the effect of outliers and other influential observations on statistical properties. He described the article as being intended to counter the impression among statisticians that "numerical calculations are exact, but graphs are rough."[^1]

![Plot of Anscombe's quartet](https://upload.wikimedia.org/wikipedia/commons/thumb/e/ec/Anscombe%27s_quartet_3.svg/1920px-Anscombe%27s_quartet_3.svg.png)

Here are the data in a single table:

| x1| x2| x3| x4|    y1|   y2|    y3|    y4|
|--:|--:|--:|--:|-----:|----:|-----:|-----:|
| 10| 10| 10|  8|  8.04| 9.14|  7.46|  6.58|
|  8|  8|  8|  8|  6.95| 8.14|  6.77|  5.76|
| 13| 13| 13|  8|  7.58| 8.74| 12.74|  7.71|
|  9|  9|  9|  8|  8.81| 8.77|  7.11|  8.84|
| 11| 11| 11|  8|  8.33| 9.26|  7.81|  8.47|
| 14| 14| 14|  8|  9.96| 8.10|  8.84|  7.04|
|  6|  6|  6|  8|  7.24| 6.13|  6.08|  5.25|
|  4|  4|  4| 19|  4.26| 3.10|  5.39| 12.50|
| 12| 12| 12|  8| 10.84| 9.13|  8.15|  5.56|
|  7|  7|  7|  8|  4.82| 7.26|  6.42|  7.91|
|  5|  5|  5|  8|  5.68| 4.74|  5.73|  6.89|

Anscombe's quartet dataset is built into R and can be accessed using the command

```r
data(anscombe)
```

A linear regression model of $y$ on \(x\) might take the form
\[
y_i = \beta_0 + \beta_1 x_i + \epsilon_i,
\]
where \(\epsilon \sim \mathcal{N}(0, \sigma^2)\).

### References

[^1]: Anscombe, F. J. (1973). "Graphs in Statistical Analysis". *American Statistician*. 27 (1): 17–-21. doi:10.1080/00031305.1973.10478966.
