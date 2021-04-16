# install.packages("visNetwork")
# 
# # can have new features in development version 
# devtools::install_github("datastorm-open/visNetwork")
# 
require(visNetwork, quietly = TRUE)
# minimal example
nodes <- data.frame(id = letters[seq( from = 1, to = 20 )])
edges <- data.frame(from = letters[seq( from = 1, to = 10 )], to = letters[seq( from = 11, to = 20 )])
visNetwork(nodes, edges, width = "100%")


# visDocumentation()
# vignette("Introduction-to-visNetwork") # with CRAN version
# # shiny example
# shiny::runApp(system.file("shiny", package = "visNetwork"))

grant <- read.csv(file = 'grant.csv')
head(grant)
library(dplyr)
filterResut <- grant %>% filter(Title == "CANMOD: Canadian Network for Modelling Infectious Disease")
filter(starwars, species == "CANMOD: Canadian Network for Modelling Infectious Disease")

nodes <- data.frame(id = c(unique(grant$Name.of.Awardee),unique(grant$Title)) )
edges <- data.frame(from = filterResut$Name.of.Awardee, to = filterResut$Title)
visNetwork(nodes, edges, width = "100%")

names(grant)[3:7]

for(i in names(grant)[3:7]){
  print(grant[[i]][1])
}

grant[[3]][41]
grant[[3]][42]

grant[[1]][41]
grant[[1]][42]

a <- NULL
exclude <- c(4, 6, 8)
for(j in (1:length(grant[[1]]))[-exclude]){
  if (grant[[7]][j]==1){
    print(j)
    a <- rbind(a,c(j,4))
  }
}
myData <- as.data.frame(a)
myData$V1
myData$V2

for(i in names(grant)[3:7]){
  print(grant[[i]])
  for(j in (1:length(grant[[1]]))[-exclude]){
    if (grant[[i]][j]==1){
      print(j)
      a <- rbind(a,c(j,4))
    }
  }
}


for(i in names(grant)[3:7]){
  print(grant[[i]])
  if(grant[i]==1)
  for(j in (1:length(grant[[1]]))[-exclude]){
    if (grant[[i]][j]==1){
      print(j)
      a <- rbind(a,c(j,4))
    }
  }
}

a <- NULL
size <- length(grant[[1]])
for (row in 1:size){
  for (col in 3:7){
    a <- rbind(a,c(row,col))
    if (grant[[col]][row]==1){
      print(c(row,col))
      # a <- rbind(a,c(j,4))
    }
    
  }
}


a <- NULL
size <- length(grant[[1]])
for (row in 1:size){
  for (col in 3:7){
    # a <- rbind(a,c(row,col))
    if (grant[[col]][row]==1){
      print(c(row,col))
      # a <- rbind(a,c(j,4))
      
      for(j in (1:size)[-row]){
        if (grant[[col]][j]==1){
          print(j)
          a <- rbind(a,c(grant[[1]][row],grant[[1]][j]))
        }
      }
    }
  }
}

myData <- as.data.frame(a)

nodes <- data.frame(id = c(unique(grant$Name.of.Awardee)) )
edges <- data.frame(from = myData$V1, to = myData$V2)
visNetwork(nodes, edges, width = "100%")

names(grant)[9]
a <- NULL
for (row in 1:size){
  for (subrow in (1:size)[-row]){
    # print(grant[[9]][subrow])
    if(grant[[9]][row]==grant[[9]][subrow]&&grant[[1]][row]!=grant[[1]][subrow]){
      # print("Ok")
      a <- rbind(a,c(grant[[1]][row],grant[[1]][subrow]))
    }
  }
}
myData <- as.data.frame(a)


