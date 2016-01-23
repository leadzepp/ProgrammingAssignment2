## The following functions provide a way of caching the inverse of a given
## matrix. In programs that perform consecutive readings of immutable large
## matrices this greatly improves performance.

## Usage example:
## > mat <- makeCacheMatrix(matrix(rnorm(8*8),8,8))
## > round(mat$get() %*% cacheSolve(mat))

## makeCacheMatrix receives an object of class matrix and returns an object
## which contains the matrix itself enriched with getters and setters for
## updating the matrix and its inverse. The returned object is used by
## cacheSolve as its input parameter.

makeCacheMatrix <- function(x = matrix()) {
      invX <- NULL
      set <- function(y) {
            x <<- y
            invX <<- NULL
      }
      get <- function()
            x
      setInv <- function(inv)
            invX <<- inv
      getInv <- function()
            invX
      list(
            set = set, get = get,
            setInv = setInv,
            getInv = getInv
      )
}


## cacheSolve receives a "special matrix" x created by makeCacheMatrix
## and returns the inverse matrix of x.

cacheSolve <- function(x, ...) {
      ## Return a matrix that is the inverse of 'x'
      
      invX <- x$getInv()
      if (!is.null(invX)) {
            message("getting cached data")
            return(invX)
      }
      data <- x$get()
      invX <- solve(data, ...)
      x$setInv(invX)
      invX
}
