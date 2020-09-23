# MA615_GroupWork1
library(tidyverse)

url1 <- "https://www.ndbc.noaa.gov/view_text_file.php?filename=44013h"

url2 <- ".txt.gz&dir=data/historical/stdmet/"

years <- c(1987:2019)

urls <- str_c(url1, years, url2, sep = "")

filenames <- str_c("mr", years,sep ="")

merge.data1 <-read_table2(urls[1],col_names = TRUE)
for (i in 2:12){
  new.data <- read_table2(urls[i],col_names = TRUE)
  merge.data1 <- rbind(merge.data1,new.data)
}

merge.data2 <-read_table2(urls[13],col_names = TRUE)
merge.data3 <-read_table2(urls[14],col_names = TRUE)
for (i in 15:18){
  new.data <- read_table2(urls[i],col_names = TRUE)
  merge.data3 <- rbind(merge.data3,new.data)
}
merge.data4 <-read_table2(urls[19],col_names = TRUE)
new.data <- read_table2(urls[20],col_names = TRUE)
merge.data4 <- rbind(merge.data4,new.data)
merge.data5 <-read_table2(urls[21],col_names = TRUE)
merge.data5 <- merge.data5[-1,]
for (i in 22:33){
  new.data <- read_table2(urls[i],col_names = TRUE)
  new.data <- new.data[-1,]
  merge.data5 <- rbind(merge.data5,new.data)
}
