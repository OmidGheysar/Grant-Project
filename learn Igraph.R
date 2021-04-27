nodes=cbind('id'=c('Fermenters','Methanogens','carbs','CO2','H2','other','CH4','H2O'),
            'type'=c(rep('Microbe',2),rep('nonBio',6)))
nodes

links=cbind('from'=c('carbs',rep('Fermenters',3),rep('Methanogens',2),'CO2','H2'),
            'to'=c('Fermenters','other','CO2','H2','CH4','H2O',rep('Methanogens',2)),
            'type'=c('uptake',rep('output',5),rep('jhkjh',2)),
            'weight'=rep(1,8))
links

library(igraph)
net = graph_from_data_frame(links,vertices = nodes,directed = T)
plot(net)
g_mst <- mst(net, weights = 1:8)
plot(mst(net))
compg.edges <- as.data.frame(get.edgelist(g_mst))
# compg.df <- as.data.frame(list(Vertex=V(compg), Community=fccommunity, Hubscore=hubscore, Authscore=authscore), stringsAsFactors=FALSE)



g <- make_(ring(10),
           with_vertex_(name = letters[1:10], color = "red"),
           with_edge_(weight = 1:10, color = "green")
)
a <- as_long_data_frame(g_mst)

# install.packages("opttrees"
nodes <- c('Fermenters','Methanogens','carbs','CO2','H2','other','CH4','H2O')
links=cbind('from'=c('carbs',rep('Fermenters',3),rep('Methanogens',2),'CO2','H2'),
            'to'=c('Fermenters','other','CO2','H2','CH4','H2O',rep('Methanogens',2)))
DF <- data.frame(links, weights= 1:8)

arcMatrix <- data.matrix(DF)



# Graph
# install.packages("optrees")
library(optrees)
nodes <- 1:7
arcs <- matrix(c(1,2,2, 1,3,15, 1,4,3, 2,3,1, 2,4,9, 3,4,1),
               ncol = 3, byrow = TRUE)

# Minimum cost spanning tree with several algorithms
tree <- getMinimumSpanningTree( nodes, arcMatrix, algorithm = "Prim")
tree1 <- getMinimumSpanningTree(as.numeric(factor(nodes)), arcMatrix, algorithm = "Kruskal")
getMinimumSpanningTree(nodes, arcs, algorithm = "Boruvka")

network <- as.data.frame(tree[[2]])

data <- c("red","blue","green","red","yellow", "red", "blue")
factor_data <- factor(data)
num_data <- as.numeric(factor_data)
levels(factor_data)[num_data]

head(myData,100)
factor_data <- factor(myData$V1)
num_data <- as.numeric(factor_data)
levels(factor_data)[num_data]

identifiers <- c(DF$from,DF$to)
factor_data <- factor(identifiers)
length(as.numeric(factor(identifiers)))
allVector <- as.numeric(factor(identifiers))
size = length(as.numeric(factor(identifiers)))
improvedEdges <- data.frame('from'=allVector[1:(size/2)],'to'=allVector[(size/2+1):size],'weights'=1:8)
improvedEdgesReal <- data.frame('from'=levels(factor_data)[allVector[1:(size/2)]],
                                'to'=levels(factor_data)[allVector[(size/2+1):size]],'weights'=1:8)
arcs <- as.matrix(improvedEdges)

tree1 <- getMinimumSpanningTree(as.numeric(factor(nodes)), arcs, algorithm = "Kruskal")
levels(factor_data)[allVector]





