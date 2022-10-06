problem3a <- function(data){
  print("Basic Description:")
  cat(paste("No of Data Points: ",nrow(data),"\n"))
  cat(paste("No of Data Features: ",ncol(data),"\n"))
  cat(paste("No of Response Classes: ",length(levels(data$Species))))
}

problem3b <- function(data){
  limit <- ncol(data)-1
  print("Mean:")
  print(sapply(data[,1:limit],mean))
  print("Median:")
  print(sapply(data[,1:limit],median))
  print("Mode:")
  print(sapply(data[,1:limit],sd))
  print("Minimum:")
  print(sapply(data[,1:limit],min))
  print("Maximum:")
  print(sapply(data[,1:limit],max))
}

problem3c <- function(data){
  plot(data[,1:2],
       pch=c("W","L"),
       col=c("red","blue"),
       main="Sepal Petal Width vs Sepal Petal Length",
       ylab="Width (cm)",
       xlab="Length (cm)",
  )
  legend("topright",
         c("Length","Width"),
         fill=c("blue","red")
  )
}

d1 <- function(s){
  (1-s)/s
}

d2 <- function(s){
  -log(s)
}

problem4 <- function(){
  curve(d1, col = 1)
  curve(d2, col = 2, add = TRUE)
}

# d1 and d2 become more similar ad s -> infinity

#
#The value of logm/df will be the maximum value 
#The value of logm/df will be 0

#Problem 6
#a
x <- c(0,1,0,1,0,1,0,1,0,1)
y <- c(0,1,0,0,0,1,1,0,0,0)
hamming.distance <- sum(xor(x, y))
jaccard.distance <- sum(!xor(x, y))

SMC <- function(x,y){
  hamming.distance <- sum(xor(x, y))
  length(x) - hamming.distance
}

#b
SMC(x,y)

#c
# The equations are similar Cosine measure just takes only unique values while jaccard takes the whole sample


# Problem 7

cosine <- function(x,y){
  sum(x*y)/length(x)
}
cor(x,y)
euclidean.distance <- function(x, y) sqrt(sum((x - y)^2))

problem3a(iris)
problem3b(iris)
problem3c(iris)
problem4()




