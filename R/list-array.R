
#' A 2d-array which can contain lists as cell objects
#'
#' The \code{list_array} class is subsettable like a matrix, but can contain
#' lists or any other random objects as cell elements. This is convenient in
#' cases where there is a natural 2d arrangement, but in each a position one
#' wants to add more than a single number or character.
#'
#' @param l A list.
#' @param nrow,ncol Number of rows / columns of list array.
#' @example inst/examples/listarray-example.R
#' @export
#'
list_array <- function(l = NA, nrow, ncol)
{
  # auto-wrap objects which have other than a list class
  # into a list. This way you can pass e.g. a dataframe
  # and it will be wrapped
  if (any(class(l) != "list"))
    l <- list(l)

  # recycle number of list
  n <- nrow * ncol
  l <- rep_len(l, n)

  # create list array structure
  la <- list(list = l,
             nrow= nrow,
             ncol = ncol)
  class(la) <- "list_array"
  la
}


#' @export
#' @keywords internal
dim.list_array <- function(x, ...)
{
  c(x$nrow, x$ncol)
}


#' @export
#' @keywords internal
"dim<-.list_array" <- function(x, value)
{
  x$nrow <- value[1L]
  x$ncol <- value[2L]
  x
}


#' @export
#' @keywords internal
nrow.list_array <- function(x, ...)
{
  dim(x)[1L]
}


#' @export
#' @keywords internal
ncol.list_array <- function(x, ...)
{
  dim(x)[2L]
}


#' @export
#' @keywords internal
print.list_array <- function(x, ...)
{
  nr <- nrow(x)
  nc <- ncol(x)

  cat("\n", nr,"x", nc, "list array")
  cat("\n\n")
  m <- matrix(x$list, nr, nc)
  print(m)
}


# calculate list index position from i
# and j array position
list_array_index <- function(x, i, j)
{
  nr <- nrow(x)
  nc <- ncol(x)
  i + (j - 1) * nr
}


#' @export
#' @keywords internal
"[.list_array" <- function(x, i, j)
{
  index <- list_array_index(x, i, j)
  x$list[[index]]
}


#' @export
#' @keywords internal
"[<-.list_array" <- function(x, i, j, value, ...)
{
  index <- list_array_index(x, i, j)
  x$list[[index]] <- value
  x
}



