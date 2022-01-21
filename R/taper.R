#' Tree taper (or profile) equation.
#'
#' Returns the diameter or cross-sectional area at one or more hight levels.
#'
#' @param h     Height level(s), possibly a vector.
#' @param H     Tree total height.
#' @param D     Tree diameter at breast height.
#' @param b     Vector with the 5 parameters.
#' @param BH    Breast height. Typically 1.2, 1.3 or 1.4 m, or 4.5 ft.
#' @param area  If TRUE, returns cross-sectional areas, otherwise returns
#'                diameters.
#'
#' @return  Diameter(s) at level(s) '\code{h}' if '\code{area}' is FALSE (default),
#'            otherwise cross-sectional area(s).
#' @export
#'
#' @examples
#'   curve(taper(x, 32, 24, c(2.569, 0, 1.042, 0.3012, -1), 1.3, FALSE), 0, 32)
#'
taper <- function(h, H, D, b, BH, area){
  r <- unscaled(h, H, b) / unscaled(BH, H, b) # relative area
  if(area) pi * (D / 2)^2 * r  # area at level h
  else D * sqrt(r)  # diameter at level h
}

#' Unscaled curve of cross-sectional area vs height level.
#'
#' @param h     Height level(s), possibly a vector.
#' @param H     Tree total height.
#' @param b     Vector with the 5 parameters.
#'
#' @return  Value(s) proportional to the area(s) at the level(s) \code{h}.
#' @export
#'
#' @examples
#'     unscaled(16, 32, c(2.569, 0, 1.042, 0.3012, -1))
#'
unscaled <- function(h, H, b){
  H - h - b[1] * Id((H - h) / b[1], b[2])
    + b[3] * (H - h) * decay(h / b[4], b[5])
}

