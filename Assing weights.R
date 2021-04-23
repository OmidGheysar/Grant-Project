

library(dplyr)
library(randomcoloR)
# read the data
require(visNetwork, quietly = TRUE)
grant <- read.csv(file = 'grant.csv')
require(visNetwork, quietly = TRUE)

# Within-province graph -----------------------------------------------------------------
a <- NULL
size <- length(grant[[1]])
for (row in 1:size){
  for (col in 3:7){
    if (grant[[col]][row]==1){
      print(c(row,col))
      for(j in (1:size)[-row]){
        if (grant[[col]][j]==1){
          print(j)
          weight <- 1
          if(grant[[9]][row]==grant[[9]][j]){
            weight <- 2
          }
          if(grant[[8]][row]==grant[[8]][j]){
            weight <- 3
          }
          a <- rbind(a,c(grant[[1]][row],grant[[1]][j],grant[[2]][j],weight))
          
        }
      }
    }
  }
}

myData <- as.data.frame(a)
titles <- unique(grant$Title)
myData$V3 <- as.factor(myData$V3)
levels(myData$V3)[levels(myData$V3)==titles[1]] = "blue"
levels(myData$V3)[levels(myData$V3)==titles[2]] = "purple"
levels(myData$V3)[levels(myData$V3)==titles[3]] = "orange"
levels(myData$V3)[levels(myData$V3)==titles[4]] = "green"
levels(myData$V3)[levels(myData$V3)==titles[5]] = "yellow"
# myData <- head(myData,1000)
a <- cbind(grant$Name.of.Awardee,grant$Gender)
set <- as.data.frame(a)
uniset <- unique(set)
nodes <- data.frame(id = uniset$V1, group = uniset$V2)
edges <- data.frame(from = myData$V1, to = myData$V2, color=myData$V3)

# nodes data.frame for legend
lnodes <- data.frame(label = c(titles[1], titles[2],titles[3],"One Society Network",titles[5]),
                     shape = c( "square"), color = c("blue", "purple","orange","green","yellow"),            
                     font.size =10,
                     title = "Informations", id = 1:5)

visNetwork(nodes, edges, main = "Within-grant graph", height = "800px", width = "100%") %>%
  visLegend( addNodes = lnodes, useGroups = FALSE)%>% 
  visGroups(groupname = "Male", color = "white", shape = "square", 
            shadow = list(enabled = TRUE)) %>% 
  visGroups(groupname = "Female", color = "black", shape = "triangle")


target <- c("Erica Moodie", "Alexandra Schmidt")
filterResut <- grant %>% filter(Name.of.Awardee %in% target)

# filterMyData <- myData %>% filter(V1=="Caroline Colijn") %>% filter(V2=="Daniel Coombs") 

filterUv <- grant %>% filter(Institution==grant$Institution[1])
filterMyData <- myData %>% filter(V1==filterUv[[1]][3]) %>% filter(V2==filterUv[[1]][4]) 

# filter(grant, Name.of.Awardee=="James Colliander")


