# taken from here: http://stackoverflow.com/questions/16396090/r-topic-modeling-lda-model-labeling-fuction
library(topicmodels)
data(AssociatedPress)
train <- AssociatedPress[1:100]
test <- AssociatedPress[101:150]

train.lda <- LDA(train,2)
test.topics <- posterior(train.lda,test)$topics
head(test.topics)

colnames(test.topics) <- apply(terms(train.lda,5),2,paste,collapse=",")
head(test.topics)
test.topics <- apply(test.topics,1,function(x) colnames(test.topics)[which.max(x)])
head(test.topics)
