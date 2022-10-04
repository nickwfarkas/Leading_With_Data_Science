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

problem3a(iris)
problem3b(iris)
problem3c(iris)



