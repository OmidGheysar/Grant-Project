# install.packages("visNetwork")
# 
# # can have new features in development version 
# devtools::install_github("datastorm-open/visNetwork")
# 
# require(visNetwork, quietly = TRUE)
# # minimal example
# nodes <- data.frame(id = letters[seq( from = 1, to = 20 )])
# edges <- data.frame(from = letters[seq( from = 1, to = 10 )], to = letters[seq( from = 11, to = 20 )])
# visNetwork(nodes, edges, width = "100%")


# visDocumentation()
# vignette("Introduction-to-visNetwork") # with CRAN version
# # shiny example
# shiny::runApp(system.file("shiny", package = "visNetwork"))

# grant <- read.csv(file = 'grant.csv')
# head(grant)
# library(dplyr)
# filterResut <- grant %>% filter(Title == "CANMOD: Canadian Network for Modelling Infectious Disease")
# filter(starwars, species == "CANMOD: Canadian Network for Modelling Infectious Disease")
# 
# nodes <- data.frame(id = c(unique(grant$Name.of.Awardee),unique(grant$Title)) )
# edges <- data.frame(from = filterResut$Name.of.Awardee, to = filterResut$Title)
# visNetwork(nodes, edges, width = "100%")
# 
# names(grant)[3:7]
# 
# for(i in names(grant)[3:7]){
#   print(grant[[i]][1])
# }
# 
# grant[[3]][41]
# grant[[3]][42]
# 
# grant[[1]][41]
# grant[[1]][42]
# 
# a <- NULL
# exclude <- c(4, 6, 8)
# for(j in (1:length(grant[[1]]))[-exclude]){
#   if (grant[[7]][j]==1){
#     print(j)
#     a <- rbind(a,c(j,4))
#   }
# }
# myData <- as.data.frame(a)
# myData$V1
# myData$V2
# 
# for(i in names(grant)[3:7]){
#   print(grant[[i]])
#   for(j in (1:length(grant[[1]]))[-exclude]){
#     if (grant[[i]][j]==1){
#       print(j)
#       a <- rbind(a,c(j,4))
#     }
#   }
# }
# 
# 
# for(i in names(grant)[3:7]){
#   print(grant[[i]])
#   if(grant[i]==1)
#   for(j in (1:length(grant[[1]]))[-exclude]){
#     if (grant[[i]][j]==1){
#       print(j)
#       a <- rbind(a,c(j,4))
#     }
#   }
# }
# 
# a <- NULL
# size <- length(grant[[1]])
# for (row in 1:size){
#   for (col in 3:7){
#     a <- rbind(a,c(row,col))
#     if (grant[[col]][row]==1){
#       print(c(row,col))
#       # a <- rbind(a,c(j,4))
#     }
#     
#   }
# }

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
          a <- rbind(a,c(grant[[1]][row],grant[[1]][j],grant[[2]][j]))
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

# Within-province graph -----------------------------------------------------------------
set.seed(12)
names(grant)[9]
a <- NULL
size <- length(grant[[1]])
for (row in 1:size){
  for (subrow in (1:size)[-row]){
    if(grant[[9]][row]==grant[[9]][subrow]&&grant[[1]][row]!=grant[[1]][subrow]){
      a <- rbind(a,c(grant[[1]][row],grant[[1]][subrow],grant[[9]][row]))
      
    }
  }
}
myData <- as.data.frame(a)
myData <- head(myData,500)
myData <- unique(myData)
titles <- unique(grant$Location)
myData$V3 <- as.factor(myData$V3)
palette <- distinctColorPalette(length(titles))
for (i in seq(1,length(titles))){
  levels(myData[[3]])[levels(myData[[3]])==titles[i]] = as.character(palette[i])
  print(i)
}

a <- cbind(grant$Name.of.Awardee,grant$Gender)
set <- as.data.frame(a)
uniset <- unique(set)
nodes <- data.frame(id = uniset$V1, group = uniset$V2)
edges <- data.frame(from = myData$V1, to = myData$V2, color=myData$V3)

# nodes data.frame for legend
lnodes <- data.frame(label = c(titles),
                     shape = c( "square"), color = palette,            
                     font.size =10,
                     title = "Informations", id = 1:length(titles))
visNetwork(nodes, edges, main = "Within-province graph", height = "800px", width = "100%") %>% 
  visGroups(groupname = "Male", color = "darkblue", shape = "square",
            shadow = list(enabled = TRUE)) %>%
  visGroups(groupname = "Female", color = "red", shape = "triangle") %>% 
  visLegend( addNodes = lnodes, useGroups = FALSE)%>% 
  visGroups(groupname = "Male", color = "darkblue", shape = "square", 
            shadow = list(enabled = TRUE)) %>% 
  visGroups(groupname = "Female", color = "red", shape = "triangle")


# Within-university graph -----------------------------------------------------------------
names(grant)[8]
a <- NULL
size <- length(grant[[1]])
for (row in 1:size){
  for (subrow in (1:size)[-row]){
    if(grant[[8]][row]==grant[[8]][subrow]&&grant[[1]][row]!=grant[[1]][subrow]){
      a <- rbind(a,c(grant[[1]][row],grant[[1]][subrow],grant[[9]][row]))
    }
  }
}
myData <- as.data.frame(a)
myData <- unique(myData)
# myData <- unique(myData)

a <- cbind(grant$Name.of.Awardee,grant$Gender)
set <- as.data.frame(a)
uniset <- unique(set)
nodes <- data.frame(id = uniset$V1, group = uniset$V2)
edges <- data.frame(from = myData$V1, to = myData$V2)
# visNetwork(nodes, edges, width = "100%")


visNetwork(nodes, edges,main = "Within-universities graph", height = "900px", width = "100%") %>% 
  visGroups(groupname = "Male", color = "darkblue", shape = "square", 
            shadow = list(enabled = TRUE)) %>% 
  visGroups(groupname = "Female", color = "red", shape = "triangle") %>% 
  visGroups(groupname = "A", color = "red") %>%
  visGroups(groupname = "B", color = "lightblue") %>%
  visLegend(width = 0.1, position = "right", main = "Group")








