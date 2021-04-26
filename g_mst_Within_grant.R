
library(dplyr)
library(randomcoloR)
# read the data
require(visNetwork, quietly = TRUE)
grant <- read.csv(file = 'grant.csv')
require(visNetwork, quietly = TRUE)

# Within-province graph -----------------------------------------------------------------

a <- data.frame(matrix(ncol = 4, nrow = 0))
colnames(a) <- c("V1", "V2", "V3")
size <- length(grant[[1]])
for (row in 1:size){
  for (col in 3:7){
    if (grant[[col]][row]==1){
      print(c(row,col))
      for(j in (1:size)[-row]){
        if (grant[[col]][j]==1){
          print(j)
          if(dim(a)[1]==0){
            a <- rbind(a,c(grant[[1]][row],grant[[1]][j],grant[[2]][j],3))
          }else{
            colnames(a) <- c("V1", "V2", "V3","V4")
            checkReverse <- a %>% filter(V1==grant[[1]][j]) %>% filter(V2==grant[[1]][row])
            if(dim (checkReverse)[1]==0){
              # a <- rbind(a,c(grant[[1]][row],grant[[1]][j],grant[[2]][j]))
              weight <- 3
              if(grant[[9]][row]==grant[[9]][j]){
                weight <- 1
              }
              if(grant[[8]][row]==grant[[8]][j]){
                weight <- 2
              }
              a <- rbind(a,c(grant[[1]][row],grant[[1]][j],grant[[2]][j],weight))
              
              # ----------------------------------------------------------
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
save_data <- myData
myData <- head(myData,300)
a <- cbind(grant$Name.of.Awardee,grant$Gender)
set <- as.data.frame(a)
uniset <- unique(set)
nodes <- data.frame(id = uniset$V1,
                    # add labels on nodes
                    label = paste(uniset$V1),
                    # tooltip (html or character), when the mouse is above
                    title = paste0("<p><b>", uniset$V1),
                    group = uniset$V2)
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







# uniset = unique(myData$V1)
nodes=cbind('id'=uniset$V1)
# test <- unique(c(unique(myData$V1),unique(myData$V2)))
# nodes = cbind('id'=test)


myData$V3 <- as.character(myData$V3)
links=cbind('from'=myData$V1,
            'to'=myData$V2,
            'type'= myData$V3)

links

library(igraph)
net = graph_from_data_frame(links,vertices = nodes,directed = FALSE)
plot(net)
myWeights <- as.numeric(myData$V4)
g_mst <- mst(net,weights = rep(1,300),directed = FALSE)
plot(g_mst)
# plot(mst(net,myData$V4))
# compg.edges <- as.data.frame(get.edgelist(g_mst))
# myData <- compg.edges
a <- as_long_data_frame(g_mst)
colnames(a) <- c("V1", "V2", "V3","V4","V5")
myData <- data.frame(V1=a$V4,V2=a$V5,V3=a$V3)
colnames(myData) <- c("V1", "V2", "V3")

