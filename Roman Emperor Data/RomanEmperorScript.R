#########Read in data
emperors <- read.csv("roman-emperors.csv")


########Clean Data
library(dplyr)

emperors <- select(emperors, -X, -Birth)


#standardize Life and Reign timestamps

emperors$Reign_Start <- gsub("T.*","",emperors$Reign_Start)
emperors$Reign_End <- gsub("T.*","",emperors$Reign_End)
emperors$Death <- gsub("T.*","",emperors$Death)

emperors$Reign_Start <- strptime(emperors$Reign_Start, "%Y-%m-%d")
emperors$Reign_End <- strptime(emperors$Reign_End, "%Y-%m-%d")
emperors$Death <- strptime(emperors$Death, "%Y-%m-%d")


#######EDA
library(sqldf)
library(ggplot2)

#Check to see if suicide has legit "cause"
suicides <- sqldf("SELECT *
                  FROM emperors
                  WHERE Cause = 'Suicide'") 

ggplot(emperors,aes(Dynasty)) +geom_bar(aes(fill=Cause))


#create function and plot to see if a certain century was particularly bloody 

Circumstances_of_Death <- function(circumstance){
  circumstance <- as.character(circumstance)
  
  if (circumstance == 'Assassination' | circumstance == 'Captivity' | circumstance=='Died in Battle' | circumstance == 'Execution' | circumstance == 'Suicide'){
    return('Violent')
  }else if (circumstance == 'Natural Causes'){
    return('Natural')
  }else{
    return(circumstance)
  }
}

emperors$Type_of_Death <- sapply(emperors$Cause,Circumstances_of_Death)

ggplot(emperors, aes(Reign_End, Name, color=Type_of_Death)) +geom_point(size=2)










