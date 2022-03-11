## ----setup, include=FALSE, cache=FALSE---------------------------
library(knitr)
opts_chunk$set(fig.align='center', # fig.show='hold',
dev='pdf', out.width='.6\\textwidth') # , highlight=FALSE)
options(width=67)

## ----------------------------------------------------------------
curve(pmin(x, 1), from=0, to=3)     # Pressler
curve(1 - exp(-x), 0, 3, add=TRUE)  # exponential
curve(x / (x + 1), 0, 3, add=TRUE)  # hyperbolic

## ----------------------------------------------------------------
library(dyntaper)
for(p in seq(1, -1, -0.5)) curve(decay(y, p), xname="y", from=0,
  to=3, add=(p != 1))

## ----------------------------------------------------------------
b <- c(2.569, 0, 1.042, 0.3012, -1)  # params. for Douglas fir in BC
curve(tbase(h, 32, b), from=0, to=32, xname="h")  # H = 32 meters

## ----------------------------------------------------------------
curve(
  taper(h, H=32, D=24, b=b, bh=1.3),
from=0, to=32, xname="h")

## ----------------------------------------------------------------
hlevel(15, H=32, D=24, b=b, bh=1.3)

## ----------------------------------------------------------------
h10 <- hlevel(10, 32, 24, b, 1.3)  # height for diameter 10
volume(h1=0.3, h2=h10, H=32, D=24, b=b, bh=1.3, rhd=100)

## ----------------------------------------------------------------
summary(brink)
library(lattice)
xyplot(dib ~ h, groups=Tree, data=brink, type="b")

## ----------------------------------------------------------------
Dib <- brink$dib[brink$h == 1.35]
Dob <- brink$Dob[brink$h == 1.35]
mean(Dib / Dob)

## ----------------------------------------------------------------
exp(mean(log(Dib) - log(Dob)))
k <- 0.908  # no practical difference, this should be  good enough

## ----------------------------------------------------------------
expexp <- nls(dib ~ taper(h, H, k*Dob, c(b1, 0, b3, b4, 0), 1.35),
              data=brink, start=c(b1=4, b3=1, b4=1))
summary(expexp)
AIC(expexp)  # Akaike's criterion

## ----------------------------------------------------------------
(full <- nls(dib ~ taper(h, H, k*Dob, c(b1, b2, b3, b4, b5), 1.35),
             data=brink, start=c(coef(expexp), b2=0, b5=0.1)))
AIC(full)

## ----------------------------------------------------------------
(hyplin <- nls(dib ~ taper(h, H, k*Dob, c(b1, -1, b3, b4, 1),
               1.35), data=brink, start=coef(expexp)))
AIC(hyplin)
bhl <- c(b1=2.225, b2=01, b3=0.2826, b4=1.087, b5=1)

## ----------------------------------------------------------------
n <- nrow(brink)  # number of measurements
totpairs <- n * (n - 1) / 2  # total pairs
(m <- table(brink$Tree))  # measurements per tree
corrpairs <- sum(m * (m - 1) / 2)  # pairs within trees
100 * corrpairs / totpairs  # % of possibly correlated pairs

## ----------------------------------------------------------------
with(brink,
  tapply(residuals(hyplin), list(
    DBH = cut(Dob, quantile(Dob, 0:3 / 3), include.lowest=TRUE),
    RelHt = cut(h / H, 3)
  ), mean)
)

## ----------------------------------------------------------------
with(brink,
  tapply(residuals(hyplin), list(
    DBH = cut(Dob, quantile(Dob, 0:3 / 3), include.lowest=TRUE),
    RelHt = cut(h / H, 3)
  ), function(x) sqrt(mean(x^2)))
)

## ----------------------------------------------------------------
gridify <- function(x, rows, cols, smmryfn, rbreaks, cbreaks){
  tapply(x, list(
    cut(rows, rbreaks, include.lowest=TRUE),
    cut(cols, cbreaks, include.lowest=TRUE)
  ), smmryfn)
}

