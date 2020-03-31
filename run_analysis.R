library(dplyr)
xtrain<-read.table("./train/X_train.txt")
ytrain<-read.table("./train/y_train.txt")
subtrain<-read.table("./train/subject_train.txt")
xtest<-read.table("./test/X_test.txt")
ytest<-read.table("./test/y_test.txt")
subtest<-read.table("./test/subject_test.txt")
features<-read.table("features.txt")
activitylabels<-read.table("activity_labels.txt")
colnames(xtrain)<-features[,2]
colnames(xtest)<-features[,2]
colnames(ytrain)<-"activityID"
colnames(ytest)<-"activityID"
colnames(subtrain)<-"subjectID"
colnames(subtest)<-"subjectID"
colnames(activitylabels)<-c("activityID","activityName")
training<-cbind(ytrain,subtrain,xtrain)
test<-cbind(ytest,subtest,xtest)
data<-rbind(training,test)
Names<-colnames(data)
mean_and_std = (grepl("activityID",Names)|grepl("subjectID",Names)|
                  grepl("mean..",Names)|grepl("std..",Names))
final_data<-data[,mean_and_std==TRUE]
final_data<-merge(final_data,activitylabels,by= "activityID")
final_data<-arrange(final_data,subjectID,activityID)
write.table(final_data,file = "Tidy_Data.txt")