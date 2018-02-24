#Read in data
emperors <- read.csv("roman-emperors.csv")


#EDA and Clean Data
library(dplyr)
library(sqldf)
library(ggplot2)

emperors <- select(emperors, -Verif, -Image)

#Check to see if suicide has legit "cause"
suicides <- sqldf("SELECT *
FROM emperors
                  WHERE Cause = 'Suicide'") 

ggplot(emperors,aes(Dynasty)) +geom_bar(aes(fill=Cause))

emperors <- rename(emperors,Full_Name=Full.Name,Birth_City=Birth.City,Birth_Province=Birth.Province,Reign_Start=Reign.Start,Reign_End=Reign.End)
