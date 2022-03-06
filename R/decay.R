#' Decay function delta
#'
#' Calculates \eqn{(max{1 - p*x, 0})^(1/p)}, or its limit \eqn{exp(-x)}
#'   when \eqn{p} tends to 0.
#'
#' @param x   Input value(s), possibly a vector.
#' @param p   Parameter.
#'
#' @return    Decay function value(s).
#' @export
#'
#' @details   Perhaps overkill, but uses \code{log1p()} function for better
#'              accuracy than the more obvious formula.
#' @examples
#'    decay(2, 0) == exp(-2)
#'    decay(1.5, 0.5)
#'    decay(2.5, 0.5)
#'    decay(2.5, -0.5)
#'    for(p in seq(1, -1, -0.5)) curve(decay(x, p), 0, 3, add=(p != 1))
#'
decay <- function(x, p){
  stopifnot(length(p) == 1) # sanity check
  if(abs(p) < 1e-300) exp(-x)
  else{
    suppressWarnings( # trap NaN's message
      v <- exp(log1p(-p * x) / p) # "same" as (1 - p*x)^(1/p)
    )
    v[is.nan(v)] <- 0  # when 1 - p*x <= 0
    return(v)
  }
}

#' Integral of decay function.
#'
#' @param x   Input value(s), possibly a vector.
#' @param p   Parameter.
#'
#' @return    Integral of the decay function between 0 and x.
#' @export
#'
#' @examples
#'    Id(2, 0)
#'    Id(1.5,0.5)
#'    Id(2.5, 0.5)
#'    Id(2.5, -0.5)
#'    for(p in seq(1, -1, -0.5)) curve(Id(x, p), 0, 3, add=(p != 1))
#'
Id <- function(x, p){
  if(abs(p + 1) < 1e-8) log1p(pmax(x, -1))
  else (1 - decay((p + 1) * x, p / (p + 1))) / (p + 1)
}

#' Double integral of decay function.
#'
#' @param x   Input value(s), possibly a vector.
#' @param p   Parameter.
#'
#' @return    Iterated integral of the decay function between 0 and x,
#'                that is, the integral of Id(x, p).
#' @export
#' @examples
#'    Idd(2, 0)
#'    Idd(1.5,0.5)
#'    Idd(2.5, -1)
#'    Idd(2.5, -0.5)
#'    for(p in seq(1, -1, -0.5)) curve(Idd(x, p), 0, 3, add=(p != 1))
#'
Idd <- function(x, p){
  if(abs(p + 1) < 1e-8){  # p = -1 (approx)
       suppressWarnings(v <- (x + 1) * log1p(x) - x)  # ignore NaN's
       v[is.nan(v)] <- Inf  # x <= -1
       v[x == -1] <- 1  # just in case
  }
  else v <- (x - Id((p + 1) * x, p / (p + 1)) / (p + 1)) / (p + 1)
  return(v)
}
