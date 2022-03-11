
# dyntaper  -  Using a dynamic tree stem profile model

<!-- badges: start -->
<!-- badges: end -->

An *R* package that implements the model of García (2015).

The main functions are *taper()*, which calculates diameters at specified height levels up the tree, its inverse *hlevel()*, which gives the height level for a given diameter, and *volume()*, which computes the volume between two height levels.

For a tutorial, see the [vignette](https://github.com/ogarciav/dyntaper/blob/master/doc/dyntaper.pdf).

## Installation

You can install dyntaper like so:

``` r
install.packages("devtools")
devtools::install_github("ogarciav/dyntaper")
```

## Example

This plots a diameter profile for a tree with a total height of 32 m, and a dbh of 24 cm (breast height 1.3 m):

``` r
library(dyntaper)
prms <- c(2.569, 0, 1.042, 0.3012, -1)  # parameters
curve(
  taper(h=x, H=32, D=24, b=prms, bh=1.3),
from=0, to=32)
```
## References

García, O. (2015) "Dynamic modelling of tree form". *MCFNS 7*, 9–15.
  (http://mcfns.net/index.php/Journal/article/view/MCFNS7.1_2).
  
Koirala, A., Montes, C. R., Bullock, B. P. and Wagle, B. H. (2021) "Developing
  taper equations for planted teak (*Tectona grandis* L. f.) trees of
  central lowland Nepal". *Trees, Forests and People 5*.
  (https://doi.org/10.1016/j.tfp.2021.100103).
