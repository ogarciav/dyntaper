#' Height level for given diameter or area.
#'
#' Find the height level at which the tree reaches a given diameter (if
#'     \code{area == FALSE}, default) or a given cross-sectional area (if \code{area == TRUE}).
#'     That is, the inverse of \code{profile()}, except that a vector argument
#'     is not allowed.
#'
#' @param da    The given diameter or area.
#' @param H     Tree total height.
#' @param D     Tree diameter at breast height.
#' @param b     Vector with the 5 parameters.
#' @param BH    Breast height. Typically 1.2, 1.3 or 1.4 m, or 4.5 ft.
#' @param area  If TRUE, '\code{da}' is a cross-sectional area, otherwise a
#'                diameter.
#'
#' @return      Height level corresponding to '\code{sa}', if any, otherwise \code{NA}.
#' @export
#' @importFrom stats uniroot
#'
#' @examples
#'    b <- c(2.569, 0, 1.042, 0.3012, -1)  # parameters
#'     hlevel(15, 32, 24, b, 1.3, FALSE)  # height where the diameter is 15
#'     hlevel(24, 32, 24, b, 1.3, FALSE)  # breast height
#'     hlevel(35, 32, 24, b, 1.3, FALSE)  # height where the diameter is 35
#'
hlevel <- function(da, H, D, b, BH, area){
  f <- function(h, da, H, D, b, BH, area){ # find zero of this over h
    da - taper(h, H, D, b, BH, area)
  }
  stopifnot(length(da) == 1) # vector not allowed
  if(sign(f(0, da, H, D, b, BH, area)) == sign(f(H, da, H, D, b, BH, area)))
    return(NA) # or NaN?
  uniroot(f, c(0, H), da, H, D, b, BH, area, f.upper = da)$root
}
