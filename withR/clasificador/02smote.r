require(DMwR)
# must set ydata as factor and has to be placed at the end!!!!!!!!
data =  read.table('creditosForSPSS_clean.csv', sep=',', header=T)

train <- sample(nrow(data), floor(nrow(data) * 0.66)) 
training <- data[train, ] 
validation <- data[-train, ] 
remove (train)   # remove data to free up space 

write.csv(training, 'witout_smote_training.csv');

training$clase <- as.factor(training$clase)
data <- SMOTE(clase ~ ., training
                ,k = 70
                ,perc.over = 7000,perc.under=100)
table(data$clase)
write.csv(data, 'smote_training.csv');
write.csv(validation, 'witout_smote_validation.csv');

#1 over: 900 under = 400 k = 9 
#2 over: 7000 under = 200 k = 70
