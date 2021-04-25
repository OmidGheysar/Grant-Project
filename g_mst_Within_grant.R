
library(dplyr)
library(randomcoloR)
# read the data
require(visNetwork, quietly = TRUE)
grant <- read.csv(file = 'grant.csv')
require(visNetwork, quietly = TRUE)

# Within-province graph -----------------------------------------------------------------

a <- data.frame(matrix(ncol = 3, nrow = 0))
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
            a <- rbind(a,c(grant[[1]][row],grant[[1]][j],grant[[2]][j]))
          }else{
            colnames(a) <- c("V1", "V2", "V3")
            checkReverse <- a %>% filter(V1==grant[[1]][j]) %>% filter(V2==grant[[1]][row])
            if(dim (checkReverse)[1]==0){
              a <- rbind(a,c(grant[[1]][row],grant[[1]][j],grant[[2]][j]))
            }
          }
          
        }
      }
    }
  }
}

myData <- as.data.frame(a)
## set the seed to make your partition reproducible
set.seed(123)
smp_size <- floor(0.9 * nrow(myData))
train_ind <- sample(seq_len(nrow(myData)), size = smp_size)
myData <- myData[train_ind, ]


titles <- unique(grant$Title)
myData$V3 <- as.factor(myData$V3)
levels(myData$V3)[levels(myData$V3)==titles[1]] = "blue"
levels(myData$V3)[levels(myData$V3)==titles[2]] = "purple"
levels(myData$V3)[levels(myData$V3)==titles[3]] = "orange"
levels(myData$V3)[levels(myData$V3)==titles[4]] = "green"
levels(myData$V3)[levels(myData$V3)==titles[5]] = "yellow"
myData <- head(myData,500)
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






# nodes=cbind('id'=c('Fermenters','Methanogens','carbs','CO2','H2','other','CH4','H2O'),
#             'type'=c(rep('Microbe',2),rep('nonBio',6)))
nodes=cbind('id'=uniset$V1)
nodes

# links=cbind('from'=c('carbs',rep('Fermenters',3),rep('Methanogens',2),'CO2','H2'),
#             'to'=c('Fermenters','other','CO2','H2','CH4','H2O',rep('Methanogens',2)),
#             'type'=c('uptake',rep('output',5),rep('uptake',2)),
#             'weight'=rep(1,8))
myData$V3 <- as.character(myData$V3)
links=cbind('from'=myData$V1,
            'to'=myData$V2,
            'type'= myData$V3)

links

library(igraph)
net = graph_from_data_frame(links,vertices = nodes,directed = T)
plot(net)
g_mst <- mst(net)
plot(mst(net))
compg.edges <- as.data.frame(get.edgelist(g_mst))
myData <- compg.edges
a <- as_long_data_frame(g_mst)


