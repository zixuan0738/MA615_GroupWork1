# MA615_GroupWork1
library(tidyverse)

url1 <- "https://www.ndbc.noaa.gov/view_text_file.php?filename=44013h"
url2 <- ".txt.gz&dir=data/historical/stdmet/"

  years <- c(1987:2019)

urls <- str_c(url1, years, url2, sep = "")

filenames <- str_c("mr", years,sep ="")

#read_table("https://www.ndbc.noaa.gov/view_text_file.php?filename=44013h2010.txt.gz&dir=data/historical/stdmet/", col_names = TRUE)

