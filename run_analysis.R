library(qdap)
  
  ## reads the activity labels file, 
  ## and sets the "Act.Labels" name to the column
  Act.Labels<-read.table("UCI HAR Dataset/activity_labels.txt", sep="")
  names(Act.Labels)<-c("V1","Act.Labels")
  
  ## reads the features labels file, 
  ## cleans the lables from bad characters ( - and , )
  ## and sets the "Features.Labels" name to the column
  Features.Labels<-read.table("UCI HAR Dataset/features.txt", sep="")
  Features.Labels$V2<-gsub("-",".",Features.Labels$V2)
  Features.Labels$V2<-gsub(",",".",Features.Labels$V2)
  names(Features.Labels)<-c("V1","Features.Labels")
  
  ## reads the test and training Labels files, 
  ## binds the lists into a single one 
  ## sets the "Labels" name to the column
  ## and clears memory of no longer needed objects
  T.Labels<-read.table("UCI HAR Dataset/test/y_test.txt", sep="")
  Tr.Labels<-read.table("UCI HAR Dataset/train/y_train.txt", sep="")
  Labels<-rbind(T.Labels,Tr.Labels)
  names(Labels)<-"Labels"
  rm(T.Labels,Tr.Labels)
  
  ## sets the character description of the activities per record, 
  ## and clears memory of no longer needed objects 
  Activity<-lookup(Labels,Act.Labels)
  rm(Labels,Act.Labels)
  
  ## reads the test and training data files, 
  ## binds the tables into a single one 
  ## assigns the names of the columns from  the "Features.Labels"
  ## and clears memory of no longer needed objects
  T.Set<-read.table("UCI HAR Dataset/test/X_test.txt", sep="")
  Tr.Set<-read.table("UCI HAR Dataset/train/X_train.txt", sep="")
  Set<-rbind(T.Set,Tr.Set)
  names(Set)<-Features.Labels$Features.Labels
  rm(Features.Labels)
  
  ## reads the test and training subject identity files, 
  ## binds the lists into a single one 
  ## sets the "Subjects" name to the column
  ## and clears memory of no longer needed objects
  T.Subject<-read.table("UCI HAR Dataset/test/subject_test.txt", sep="")
  Tr.Subject<-read.table("UCI HAR Dataset/train/subject_train.txt", sep="")
  Subject<-rbind(T.Subject,Tr.Subject)
  names(Subject)<-"Subject"
  rm(T.Subject,Tr.Subject,T.Set,Tr.Set)
  
  ##binds the data into a single data.table with the 
  ##subject identity and activity descriptive in the first columns
  ## and clears memory of no longer needed objects
  Step4<-cbind(Subject,Activity,Set)
  rm(Subject,Activity,Set)
  
  ## crates table with only mean and std features 
  ## cleans descriptions of features
  ## creates new tidy data with averages of means and stds
  Step5<-Step4[,c(1,2,grep("std\\(|mean\\(",names(Step4),))]
  names(Step5)<-gsub("tBody","AvTimeBody",names(Step5))
  names(Step5)<-gsub("tGrav","AvTimeGrav",names(Step5))
  names(Step5)<-gsub("fBody","AvFilteredBody",names(Step5))
  names(Step5)<-gsub("fGrav","AvFilteredGrav",names(Step5))
  names(Step5)<-gsub("\\(\\)","",names(Step5))
  names(Step5)<-gsub("BodyBody","Body",names(Step5))
  Step5<-aggregate(.~Subject+Activity,Step5,mean)
  
  ## writes tidy data into file "TidyData.txt"
  write.table(Step5,file="TidyData.txt",append=FALSE,quote=FALSE,row.names=FALSE)
