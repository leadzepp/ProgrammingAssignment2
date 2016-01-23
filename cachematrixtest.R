## Correctness test
mat <- makeCacheMatrix(matrix(rnorm(8*8),8,8))
invmat <- cacheSolve(mat)
identmat <- round(mat$get() %*% invmat)
print(identmat)

## Performance test
mat <- makeCacheMatrix(matrix(rnorm(2000*2000),2000,2000))
t <- proc.time()
invmat <- cacheSolve(mat)
print (proc.time() - t)
t <- proc.time()
invmat <- cacheSolve(mat)
print (proc.time() - t)