#install.packages("PerformanceAnalytics")
#library(PerformanceAnalytics)

#load arkk and brkb data from the day arkk started training, 
arkk <- read.csv(".\\ARKK.csv")
brkb <- read.csv(".\\BRK-B.csv")
#remove everything except adj.close
arkk <- arkk[-c(2,3,4,5,7)]#subset(arkk, select=-c(Volume))
brkb <- brkb[-c(2,3,4,5,7)]

#merge the close price together, make date the index
both <- merge(x=arkk,y=brkb,by="Date")
rownames(both) <- both$Date
both <- both[c(-1)] #remove date as a column to reduce redundancy

#rename columns to improve readability
names(both)[names(both) == "Adj.Close.x"] <- "ARKK"
names(both)[names(both) == "Adj.Close.y"] <- "BRKB"

#calculate time series return using Performance Analytics PAckage
returns = na.omit(Return.calculate(both))


#calculate corelation
cor(returns$ARKK,returns$BRKB)
#0.4376523 not too bad, decent diversification #####