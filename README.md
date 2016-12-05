<!-- README.md is generated from README.Rmd. Please edit that file -->
**NOTE: This is a toy package created for expository purposes. It is not meant to actually be useful. If you want a package for factor handling, please see [forcats](https://cran.r-project.org/package=forcats).**

### foofactors

#### Factors

Factors are a very useful type of variable in R, but they can also drive you nuts. This package provides some helper functions for the care and feeding of factors.

#### Reorder

Reorder is a function to change the order of the levels in a factor variable. The method reorders the levels based on the values of the second variable, usually numeric.

### Installation

NOTE : ADD YOUR GITHUB REPO

``` r
devtools::install_github("HeshamMahrous/foofactors")
```

### Quick demo

#### Factors

Binding two factors via `fbind()`:

``` r
library(foofactors)
#> 
#> Attaching package: 'foofactors'
#> The following object is masked from 'package:stats':
#> 
#>     reorder
a <- factor(c("character", "hits", "your", "eyeballs"))
b <- factor(c("but", "integer", "where it", "counts"))
```

Simply catenating two factors leads to a result that most don't expect.

``` r
c(a, b)
#> [1] 1 3 4 2 1 3 4 2
```

The `fbind()` function glues two factors together and returns factor.

``` r
fbind(a, b)
#> [1] character hits      your      eyeballs  but       integer   where it 
#> [8] counts   
#> Levels: but character counts eyeballs hits integer where it your
```

Often we want a table of frequencies for the levels of a factor. The base `table()` function returns an object of class `table`, which can be inconvenient for downstream work. Processing with `as.data.frame()` can be helpful but it's a bit clunky.

``` r
set.seed(1234)
x <- factor(sample(letters[1:5], size = 100, replace = TRUE))
table(x)
#> x
#>  a  b  c  d  e 
#> 25 26 17 17 15
as.data.frame(table(x))
#>   x Freq
#> 1 a   25
#> 2 b   26
#> 3 c   17
#> 4 d   17
#> 5 e   15
```

The `freq_out()` function returns a frequency table as a well-named `tbl_df`:

``` r
freq_out(x)
#> # A tibble: 5 × 2
#>        x     n
#>   <fctr> <int>
#> 1      a    25
#> 2      b    26
#> 3      c    17
#> 4      d    17
#> 5      e    15
```

#### reorder

The `reorder` function returns the "scores" attribute which is the result of the function applied to the values of the second variable.

``` r
test_factors <- ordered(c("a","a","b","b","c","c","a","b","c","a","c","a"))
test_vals <- seq(1,12)
output_reorder <- reorder(test_factors, test_vals, mean)
```

The output of the function has the entries in the atomic vector in the same order as given in the input but the levels are sorted in descending order according to the value of scores.

``` r
attributes(output_reorder)$scores
#>    a    b    c 
#> 6.40 5.00 7.75
levels(test_factors)
#> [1] "a" "b" "c"
levels(output_reorder)
#> [1] "c" "a" "b"
```
