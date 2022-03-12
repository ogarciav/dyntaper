#' @details
#' The main functions relevant to the user are
#' \itemize{
#'   \item \code{\link{taper}}: Calculates diameters or cross-sectional areas
#'     for given height levels.
#'   \item \code{\link{hlevel}}: Calculates the height level for a given
#'     diameter or cross-sectional area.
#'   \item \code{\link{volume}}: Calculates the volume between two given height
#'     levels.
#' }
#' The package includes a small example dataset, \code{\link{brink}}.
#'
#' For a tutorial, see the vignette: \code{vignette("dyntaper", package="dyntaper")}.
#'
#' @examples
#'    dfir <- c(2.569, 0, 1.042, 0.3012, -1)  # params. for D.fir in B.C.
#'    height <- 32; dbh <- 24;  k <- 0.956  # k is a bark conversion factor
#'    # Plot a taper curve (inside-bark diameter over height levels):
#'    curve(
#'      taper(h, height, k*dbh, dfir, 1.3),  # 1.3 m is the breast height
#'    from = 0, to = 32, xname = "h")
#'    # Height level for a diameter of 10 cm (i.b.):
#'    (h10 <- hlevel(10, height, k*dbh, dfir, 1.3))
#'    # Volume from a 30 cm stump to a 10 cm diameter limit:
#'    volume(0.3, h10, height, k*dbh, dfir, 1.3, 100)
#'
#' @references
#' García, O. (2015) "Dynamic modelling of tree form". \emph{Mathematical
#'   and Computational Forestry & Natural-Resource Sciences (MCFNS) 7}(1), 9–15.
#'   (\url{http://mcfns.net/index.php/Journal/article/view/MCFNS7.1_2}).
#'
#' Koirala, A., Montes, C. R., Bullock, B. P. and Wagle, B. H. (2021) "Developing
#'   taper equations for planted teak (\emph{Tectona grandis} L. f.) trees of
#'   central lowland Nepal". \emph{Trees, Forests and People 5}.
#'   (\url{https://doi.org/10.1016/j.tfp.2021.100103}).
#'
#' @keywords internal
"_PACKAGE"

## usethis namespace: start
## usethis namespace: end
NULL
