

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
# myData <- head(myData,500)
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


nodes <- data.frame(id = 1:10,
                    
                    # add labels on nodes
                    label = paste("Node", LETTERS[seq( from = 1, to = 10 )]),
                    
                    # add groups on nodes 
                    group = c("GrA", "GrB"),
                    
                    # size adding value
                    value = 1:10,          
                    
                    # control shape of nodes
                    shape = c("square", "triangle", "box", "circle", "dot", "star",
                              "ellipse", "database", "text", "diamond"),
                    
                    # tooltip (html or character), when the mouse is above
                    title = paste0("<p><b>", LETTERS[seq( from = 1, to = 10 )],"</b><br>Node !</p>"),
                    
                    # color
                    color = c("darkred", "grey", "orange", "darkblue", "purple"),
                    
                    # shadow
                    shadow = c(FALSE, TRUE, FALSE, TRUE, TRUE))             

# head(nodes)
# id  label group value    shape                     title    color shadow
#  1 Node 1   GrA     1   square <p><b>1</b><br>Node !</p>  darkred  FALSE
#  2 Node 2   GrB     2 triangle <p><b>2</b><br>Node !</p>     grey   TRUE

edges <- data.frame(from = c(1,2,5,7,8,10), to = c(9,3,1,6,4,7))


visNetwork(nodes, edges, height = "500px", width = "100%")





