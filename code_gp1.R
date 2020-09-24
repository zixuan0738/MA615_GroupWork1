# MA615_GroupWork1
library(tidyverse)
library(lubridate)

url1 <- "https://www.ndbc.noaa.gov/view_text_file.php?filename=44013h"

url2 <- ".txt.gz&dir=data/historical/stdmet/"

years <- c(1987:2019)

urls <- str_c(url1, years, url2, sep = "")

filenames <- str_c("mr", years,sep ="")

#### read table
# 87-98
merge.data1 <-read_table2(urls[1],col_names = TRUE)
for (i in 2:12){
  new.data <- read_table2(urls[i],col_names = TRUE)
  merge.data1 <- rbind(merge.data1,new.data)
}
YY <- rep("19",nrow(merge.data1))
mm <- rep("00",nrow(merge.data1))
TIME <- str_c(YY,merge.data1$YY,merge.data1$MM,merge.data1$DD,merge.data1$hh,mm)
TIME <- ymd_hm(TIME)
merge.data1 <- merge.data1[,-c(1:4)]
merge.data1 <- cbind(TIME,merge.data1)

# 99
merge.data2 <-read_table2(urls[13],col_names = TRUE)
mm <- rep("00",nrow(merge.data2))
TIME <- str_c(merge.data2$YYYY,merge.data2$MM,merge.data2$DD,merge.data2$hh,mm)
TIME <- ymd_hm(TIME)
merge.data2 <- merge.data2[,-c(1:4)]
merge.data2 <- cbind(TIME,merge.data2)

# 00-04
merge.data3 <-read_table2(urls[14],col_names = TRUE)
for (i in 15:18){
  new.data <- read_table2(urls[i],col_names = TRUE)
  merge.data3 <- rbind(merge.data3,new.data)
}
mm <- rep("00",nrow(merge.data3))
TIME <- str_c(merge.data3$YYYY,merge.data3$MM,merge.data3$DD,merge.data3$hh,mm)
TIME <- ymd_hm(TIME)
merge.data3 <- merge.data3[,-c(1:4)]
merge.data3 <- cbind(TIME,merge.data3)


# 05-06
merge.data4 <-read_table2(urls[19],col_names = TRUE)
new.data <- read_table2(urls[20],col_names = TRUE)
merge.data4 <- rbind(merge.data4,new.data)
mm <- as.numeric(merge.data4$mm)
mean(mm)
TIME <- str_c(merge.data4$YYYY,merge.data4$MM,merge.data4$DD,merge.data4$hh,merge.data4$mm)
TIME <- ymd_hm(TIME)
merge.data4 <- merge.data4[,-c(1:5)]
merge.data4 <- cbind(TIME,merge.data4)


# 07-19 
merge.data5 <-read_table2(urls[21],col_names = TRUE)
merge.data5 <- merge.data5[-1,]
for (i in 22:33){
  new.data <- read_table2(urls[i],col_names = TRUE)
  new.data <- new.data[-1,]
  merge.data5 <- rbind(merge.data5,new.data)
}
mm <- as.numeric(merge.data5$mm)
mean(mm)
TIME <- str_c(merge.data5$`#YY`,merge.data5$MM,merge.data5$DD,merge.data5$hh,merge.data5$mm)
TIME <- ymd_hm(TIME)
merge.data5 <- merge.data5[,-c(1:5)]
merge.data5 <- cbind(TIME,merge.data5)

################################################################################
data_87_99 <- rbind(merge.data1,merge.data2)
data_00_06 <- rbind(merge.data3,merge.data4)
data_07_19 <- merge.data5

colnames(data_87_99)
colnames(data_00_06)
colnames(data_07_19)

names(data_87_99)[names(data_87_99)=="BAR"]="PRES"
names(data_00_06)[names(data_00_06)=="BAR"]="PRES"


TIDE <- rep(NA,nrow(data_87_99))
data_87_99<-cbind(data_87_99,TIDE)
WDIR <- rep(NA,nrow(data_87_99))
data_87_99<-cbind(data_87_99[,1:2],WDIR,data_87_99[,3:14])
WDIR <- rep(NA,nrow(data_00_06))
data_00_06<-cbind(data_00_06[,1:2],WDIR,data_00_06[,3:14])
WD <- rep(NA,nrow(data_07_19))
data_07_19<-cbind(data_07_19[,1:2],WD,data_07_19[,3:14])
data_07_19<-data_07_19[, colnames(data_07_19)[c(1,3,2,4:15)]]

data_87_19 <- rbind(data_87_99,data_00_06,data_07_19)

str(data_87_19)

for (i in 2:15){
  data_87_19[,i] <- as.numeric(data_87_19[,i])
  
}
str(data_87_19)

data_87_19[data_87_19==99] <- NA
data_87_19[data_87_19==999] <- NA
data_87_19[data_87_19==9999] <- NA