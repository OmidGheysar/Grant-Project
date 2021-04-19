install.packages("ggpubr")

library(dplyr)
library(ggplot2)
grant <- read.csv(file = 'grant.csv')

titles <- unique(grant$Title)
grant$Title <- as.factor(grant$Title)

levels(grant$Title)[levels(grant$Title)==titles[1]] = "CANMOD"
levels(grant$Title)[levels(grant$Title)==titles[2]] = "MfPH"
levels(grant$Title)[levels(grant$Title)==titles[3]] = "OMNI"
levels(grant$Title)[levels(grant$Title)==titles[4]] = "OSN"
levels(grant$Title)[levels(grant$Title)==titles[5]] = "SMfMEID"
grant$Title <- as.character(grant$Title)


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





