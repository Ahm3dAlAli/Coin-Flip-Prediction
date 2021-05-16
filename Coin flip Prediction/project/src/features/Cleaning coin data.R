install.packages("data.table")
library(data.table)
library(readr)
samp_sub <- data.table(read_csv("project/volume/data/raw/samp_sub.csv"))
test_data<- data.table(read_csv("project/volume/data/raw/test_file.csv"))
train_data <- data.table(read_csv("project/volume/data/raw/train_file.csv"))

#################################################################################################
######################################################################################################
#fix data cleaning train set 
clean<-train_data
clean[,"id"]=NULL
cleanresult<-clean$result
clean[,"result"]=NULL
clean$Tail<-rowSums(clean)
clean$Head<-10-clean$Tail
clean[,c("V1","V2","V3","V4","V5","V6","V7","V8","V9","V10")]=NULL
clean$result<-cleanresult
clean$result<-ifelse(clean$result == 0,no="T",yes="H")

clean$result<-as.factor(clean$result)
write_csv(data.frame(clean),"project/volume/data/processed/clean_train_file.csv")
#######################################################################################################
#######################################################################################################
#Data cleaning test set 

result3<-test_data
result3[,"id"]=NULL
result3$Tail<-rowSums(result3)
result3$Head<-10-result3$Tail
result3[,c("V1","V2","V3","V4","V5","V6","V7","V8","V9","V10")]=NULL
write_csv(data.frame(result3),"project/volume/data/processed/clean_test_file.csv")


