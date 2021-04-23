# install.packages("ggpubr")
library(ggpubr)
library(dplyr)
library(ggplot2)
grant <- read.csv(file = 'grant.csv')


grant$Title <- as.factor(grant$Title)

levels(grant$Title)[levels(grant$Title)==unique(grant$Title)[1]] = "CANMOD"
levels(grant$Title)[levels(grant$Title)==unique(grant$Title)[2]] = "MfPH"
levels(grant$Title)[levels(grant$Title)==unique(grant$Title)[3]] = "OMNI"
levels(grant$Title)[levels(grant$Title)==unique(grant$Title)[4]] = "OSN"
levels(grant$Title)[levels(grant$Title)==unique(grant$Title)[5]] = "SMfMEID"
grant$Title <- as.character(grant$Title)

titles <- unique(grant$Title)
filterResultMan <- NULL
filterResultWom <- NULL
a <- NULL
for (i in seq(1,length(titles))){
  filterResultMan<- dim (grant %>% filter(Title == titles [i]) %>% filter(Gender == "Male"))[1]
  a <- rbind(a,c(titles[i],"Male",filterResultMan))
  filterResultWom<- dim (grant %>% filter(Title == titles [i]) %>% filter(Gender == "Female"))[1]
  a <- rbind(a,c(titles[i],"Female",filterResultWom))
}
myData <- as.data.frame(a)
myData$V3 <- as.numeric(myData$V3)

df2 <- data.frame(Gender=myData$V2,
                 Grant=myData$V1,
                 numPeople=myData$V3)
p <- 0
p <- ggbarplot(df2, "Grant", "numPeople",
               fill = "Gender", color = "Gender",
               label = TRUE, lab.col = "white", lab.pos = "in")

p <- p + xlab("Name of Grant")
p <- p + ylab("Number of people")
p




length(unique(grant$Location))
grant$Location <- as.factor(grant$Location)
class(grant$Location)
Locations <- unique(grant$Location)
titles <- unique(grant$Title)

a <- NULL
for (i in seq(1,length(titles))){
  for(j in seq(1,11)){
    num <- dim (grant %>% filter(Title == titles [i]) %>% filter(Location == Locations[j]))[1]
    a <- rbind(a,c(titles[i],as.character(Locations[j]),num))
  }
}

# filterResultMan<- grant %>% filter(Title == titles [1]) %>% filter(Location == Locations[1])

myData <- as.data.frame(a)
myData$V3 <- as.numeric(myData$V3)

df2 <- data.frame(Grant=myData$V1,
                  Location=myData$V2,
                  numPeople=myData$V3)
p <- 0
p <- ggbarplot(df2, "Grant", "numPeople",
               fill = "Location", color = "Location",
               label = FALSE, lab.col = "white")

p <- p + xlab("Name of Grant")
p <- p + ylab("Number of people")
p


