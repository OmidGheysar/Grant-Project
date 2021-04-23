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



# x <- c(1,2,3,4)
# y <- c(2,3,4,5)
# 
# setdiff(x, y)
# 
# m <- matrix(1:20, ncol = 4) 
# colnames(m) <- letters[1:4]
# 
# subset(m, m[,4] == 16,m[,3]==11)
# df <- data.frame(matrix(ncol = 3, nrow = 0))
# x <- c("name", "age", "gender")
# colnames(df) <- x


# data(mtcars)

## 75% of the sample size
smp_size <- floor(0.75 * nrow(myData))

## set the seed to make your partition reproducible
set.seed(123)
train_ind <- sample(seq_len(nrow(myData)), size = smp_size)
myData <- myData[train_ind, ]








