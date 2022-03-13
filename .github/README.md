
# dyntaper  -  Using a dynamic tree stem profile model

<!-- badges: start -->
<!-- badges: end -->

An *R* package that implements the model of García (2015).

The main functions are *taper()*, which calculates diameters at specified height levels up the tree, its inverse *hlevel()*, which gives the height level for a given diameter, and *volume()*, which computes the volume between two height levels.

For a tutorial, see the [vignette](dyntaper.pdf).

## Installation

You can install dyntaper like so:

``` r
remotes::install_github("ogarciav/dyntaper", build_vignettes = TRUE)
```

## Example

``` r
library(dyntaper)
dfir <- c(2.569, 0, 1.042, 0.3012, -1)  # params. for D.fir in B.C.
height <- 32; dbh <- 24;  k <- 0.956  # k is a bark conversion factor
# Plot a taper curve (inside-bark diameter over height levels):
curve(
  taper(h, height, k*dbh, dfir, 1.3),  # 1.3 m is the breast height
from = 0, to = 32, xname = "h")
# Height level for a diameter of 10 cm (i.b.):
(h10 <- hlevel(10, height, k*dbh, dfir, 1.3))
# Volume from a 30 cm stump to a 10 cm diameter limit:
volume(0.3, h10, height, k*dbh, dfir, 1.3, 100)
```
## References

García, O. (2015) "Dynamic modelling of tree form". *MCFNS 7*, 9–15.
  (http://mcfns.net/index.php/Journal/article/view/MCFNS7.1_2).
  
Koirala, A., Montes, C. R., Bullock, B. P. and Wagle, B. H. (2021) "Developing
  taper equations for planted teak (*Tectona grandis* L. f.) trees of
  central lowland Nepal". *Trees, Forests and People 5*.
  (https://doi.org/10.1016/j.tfp.2021.100103).
