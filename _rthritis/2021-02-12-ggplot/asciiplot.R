library(magrittr)

linearScale <- function(x,
                        range = c(0, 1),
                        logarithmic = FALSE) {
  if (logarithmic)
    x <- log(x)
  domain <- x
  rmin <- range[1]
  rmax <- range[2]
  dmin <- min(domain, x)
  dmax <- max(domain, x)
  rmin + (x - dmin) * (rmax - rmin) / (dmax - dmin)
}

discreteScale <- function(x) {
  as.numeric(as.factor(x))
}

logScale <- function(x, ...) {
  linearScale(x, logarithmic = TRUE, ...)
}

asciiplot <- function(df, aes = NULL, geom = NULL) {
  stopifnot(is.data.frame(df))
  ascii <- structure(list(data = df), class = "asciiplot")
  ascii$aesthetics <- aes
  ascii$geometry <- geom
  ascii
}

print.asciiplot <- function(ap) {
  # ap = an asciiplot object, which is a list of parameters
  # data
  # aesthetics
  # geometry
  # scale
  # coordinates
  # statistics
  if (is.null(ap$data))
    stop("No data in plot")
  if (is.null(ap$statistics))
    ap$statistics <- function(x) x # Identity
  if (is.null(ap$scales))
    ap$scales <- list(x = linearScale, y = linearScale, shape = discreteScale)
  if (is.null(ap$geometry))
    warning("No geometry selected")
  if (is.null(ap$coord))
    ap$coord <- list(' ', 25, getOption('width') / 2)
  if (is.null(ap$aesthetics))
    stop("No aesthetics defined")
  "All tests complete"
  canvas <- do.call(matrix, ap$coord)
  x <- ap$scales$x(ap$data[, ap$aesthetics$x]) * (ncol(canvas) - 1) + 1
  y <-
    nrow(canvas) - ap$scales$y(ap$data[, ap$aesthetics$y]) * (nrow(canvas) - 1)
  if ("point" %in% ap$geometry) {
    canvas[cbind(y, x)] <- if (is.null(ap$aesthetics$shape)) 'O' else
      c('O', 'X', '@', '/',
        '|', '*', '-', '+',
        '.', '^', '#', '\\')[ap$scales$shape(ap$data[, ap$aesthetics$shape])]
  }
  render <- function(grid, hspace = ' ')
    apply(grid, 1, function(row) paste(row, collapse = hspace))
  writeLines(render(canvas), useBytes = TRUE)
}

## Example
# asciiplot(iris, aes=list(x='Sepal.Width', y='Sepal.Length', shape = 'Species'), geom='point')
