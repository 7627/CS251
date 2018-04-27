rows <- 100 #500 trials
cols <- 500 #N=100
lambda <- 0.2
X <- rexp(rows*cols,lambda)
plot(data.frame(X=seq(1,rows*cols,1),Y=sort(X)),main="Initial data")

mat<-matrix(X,rows)

for(i in 1:5){
  col_i <- mat[,i]
  mu=mean(col_i)
  std=sd(col_i)
  cdf_main=paste("CDF of vector ",i,"\nMean=",mu," std=",std)
  pdf_main=paste("PDF of vector ",i,"\nMean=",mu," std=",std)
  cat(cdf_main,"\n",pdf_main,"\n")
  plot(ecdf(col_i),main=cdf_main)
  plot(density(col_i),main=pdf_main)
  #mtext("hello",side=1)
}

Z <-mean(mat[,1]) #calculating mean of Y1
for(i in 2:cols){
  col_i <- mat[,i]
  Z <-c(Z,mean(col_i))
}
myTable <- table(round(Z,digits=1))
plot(myTable,"h",xlab="Data",ylab="Frequency")
plot(ecdf(Z),main="CDF of Z")
plot(density(Z),main="PDF of Z")

cat("Mean(Z)=",mean(Z),"\n")
cat("std(Z)=",sd(Z),"\n")
