library(MatchIt)

mydata <- read.csv("/app/data/merged_filtered.csv")

mydata$group <- NA
mydata$group[mydata$BS3_1 == 3.0 & mydata$BS12_47 == 1.0] <- 1
mydata$group[mydata$BS3_1 == 1.0 & mydata$BS12_47 == 8.0] <- 0

mydata <- mydata[!is.na(mydata$group), ]
