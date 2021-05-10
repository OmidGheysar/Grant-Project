

library(dplyr)
library(randomcoloR)
# read the data
require(visNetwork, quietly = TRUE)
grant <- read.csv(file = 'grant.csv')
require(visNetwork, quietly = TRUE)


degree <- data.frame(name = unique(grant$Name.of.Awardee), degree = rep(0,155))
# which(degree$name =="Caroline Colijn")
# degree[[2]][7] <- 1


assignDegree <- function(degree, enterName1, enterName2) {
  degree[[2]][which(degree$name ==enterName1)] <- 1
  degree[[2]][which(degree$name ==enterName2)] <- 1
  return(degree)
}

zeroDegree <- function(degree,enterName1) {
  if(degree[[2]][which(degree$name ==enterName1)] == 0){
    return(0)
  }
  return(1)
}

inNeighbor <- function(myData, enterGrant ,enterName){
  filteringV1 <- filter(myData,V1==enterName)
  filteringV2 <- filter(myData,V2==enterName)
  filtering <- rbind(filteringV1,filteringV2)
  if(enterGrant %in% filtering$V3){
    return(T)
  }
  return(F)
}

# Within-province graph -----------------------------------------------------------------

a <- data.frame(matrix(ncol = 3, nrow = 0))
colnames(a) <- c("V1", "V2", "V3")
size <- length(grant[[1]])
for (row in 1:size){
  for (col in 3:7){
    if (grant[[col]][row]==1){
      # print(c(row,col))
      for(j in (1:size)[-row]){
        if (grant[[col]][j]==1){
          # print(j)
          if(dim(a)[1]==0){
            a <- rbind(a,c(grant[[1]][row],grant[[1]][j],grant[[2]][j]))
            degree <- assignDegree(degree, grant[[1]][row],grant[[1]][j])
          }else{
            colnames(a) <- c("V1", "V2", "V3")
            checkReverse <- a %>% filter(V1==grant[[1]][j]) %>% filter(V2==grant[[1]][row])
            if(dim (checkReverse)[1]==0){
              if(zeroDegree(degree,grant[[1]][row])+zeroDegree(degree,grant[[1]][j]) <= 1 | !inNeighbor(as.data.frame(a), grant[[2]][row] ,grant[[1]][row])){
                a <- rbind(a,c(grant[[1]][row],grant[[1]][j],grant[[2]][j]))
                degree <- assignDegree(degree, grant[[1]][row],grant[[1]][j])
                print(degree[[2]][which(degree$name =="Sherilee Harper")])
                # print(degree)
                if(grant[[1]][row]=="Sherilee Harper"| grant[[1]][j]=="Sherilee Harper"){
                  print("yes this is here")
                  b <- 12312
                }
              }
            }
          }
          
        }
      }
    }
  }
}

myData <- as.data.frame(a)
## set the seed to make your partition reproducible
# set.seed(123)
# smp_size <- floor(0.9 * nrow(myData))
# train_ind <- sample(seq_len(nrow(myData)), size = smp_size)
# myData <- myData[train_ind, ]


titles <- unique(grant$Title)
myData$V3 <- as.factor(myData$V3)
levels(myData$V3)[levels(myData$V3)==titles[1]] = "blue"
levels(myData$V3)[levels(myData$V3)==titles[2]] = "purple"
levels(myData$V3)[levels(myData$V3)==titles[3]] = "orange"
levels(myData$V3)[levels(myData$V3)==titles[4]] = "green"
levels(myData$V3)[levels(myData$V3)==titles[5]] = "yellow"
# myData <- head(myData,500)
a <- cbind(grant$Name.of.Awardee,grant$Gender,grant$Location)
set <- as.data.frame(a)
uniset <- unique(set)
nodes <- data.frame(id = uniset$V1,
                    # add labels on nodes
                    label = paste(uniset$V1),
                    # tooltip (html or character), when the mouse is above
                    title = paste0("<p><b>", uniset$V1),
                    group = uniset$V3)
edges <- data.frame(from = myData$V1, to = myData$V2, color=myData$V3)

# nodes data.frame for legend
lnodes <- data.frame(label = c(titles[1], titles[2],titles[3],"One Society Network",titles[5]),
                     shape = c( "square"), color = c("blue", "purple","orange","green","yellow"),            
                     font.size =10,
                     title = "Informations", id = 1:5)

visNetwork(nodes, edges, main = "Within-grant graph", height = "800px", width = "100%") %>%
  visLegend( addNodes = lnodes, useGroups = TRUE)








