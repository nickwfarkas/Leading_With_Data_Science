problem3a <- function(data){
  print("Basic Description:")
  cat(paste("No of Data Points: ",nrow(data),"\n"))
  cat(paste("No of Data Features: ",ncol(data),"\n"))
  cat(paste("No of Response Classes: ",length(levels(data$Species))))
}

problem3a(iris)

problem3b <- function(data){
  print("Mean:")
  sapply(iris[,1:(ncol(iris)-1)],mean)
  print("Median:")
  sapply(iris[,1:(ncol(iris)-1)],median)
  print("Mode:")
  sapply(iris[,1:(ncol(iris)-1)],sd)
  print("Minimum:")
  sapply(iris[,1:(ncol(iris)-1)],min)
  print("Maximum:")
  sapply(iris[,1:(ncol(iris)-1)],max)
}



plot(iris[,1:2],
     pch=c("W","L"),
     col=c("red","blue"),
     main="Sepal Petal Width vs Sepal Petal Length",
     ylab="Width",
     xlab="Length",
     )
legend("topright",
       c("Length","Width"),
       fill=c("blue","red")
)

