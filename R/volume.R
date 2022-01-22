#' Volume between two height levels.
#'
#' @param h1,h2   The two height levels.
#' @param H       Tree total height.
#' @param D       Tree diameter at breast height.
#' @param b       Vector with the 5 parameters.
#' @param BH      Breast height. Typically 1.2, 1.3 or 1.4 m, or 4.5 ft.
#' @param RHD     Ratio between the height and diameter units. E.g., 100
#'                    for m and cm, or 12 for feet and inches.
#'
#' @return    Volume between \code{h1} and \code{h2}.
#' @export
#'
#' @examples
#'     b <- c(2.569, 0, 1.042, 0.3012, -1)  # parameters
#'     volume(0, 32, 32, 24, b, 1.3, 100)  # total volume
#'     h15 <- hlevel(15, 32, 24, b, 1.3, FALSE)  # height for diameter 15
#'     volume(0.3, h15, 32, 24, b, 1.3, 100)  # volume between stump and h15
#'
volume <- function(h1, h2, H, D, b, BH, RHD){
  Is <- function(h, H, b){ # indefinite integral of unscaled() area
    H * h - h^2 / 2 + b[1]^2 * Idd((H - h) / b[1], b[2]) + b[3] * b[4] *
      ((H - h) * Id(h / b[4], b[5]) + b[4] * Idd(h / b[4], b[5]))
  }
  h1 <- min(max(h1, 0), H) # force to within the stem, if necessary
  h2 <- min(max(h2, 0), H)
  (1 / RHD^2) * pi * (D / 2)^2 * abs(Is(h2, H, b) - Is(h1, H, b)) /
    unscaled(BH, H, b)
}
