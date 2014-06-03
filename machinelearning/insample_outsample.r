
library(kernlab)
data(spam)
set.seed(333)
smallSpam <- spam[sample(dim(spam)[1], size=10),]
spamLabel <- (smallSpam$type=="spam") *1 +1
plot(smallSpam$capitalAve, col=spamLabel)


rule1 <- function(x) {
  prediction <- rep(NA, length(x))
  prediction[x > 2.7] <- 'spam'
  prediction[x < 2.40] <- 'nonspam'
  prediction[x >= 2.40  & x <= 2.45] <- 'spam'
  prediction[x > 2.45  & x <= 2.70] <- 'nonspam'
  return(prediction)
}

table (rule1(smallSpam$capitalAve), smallSpam$type)
