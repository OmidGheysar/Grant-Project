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
g_mst <- mst(net)
plot(mst(net))
compg.edges <- as.data.frame(get.edgelist(g_mst))
compg.df <- as.data.frame(list(Vertex=V(compg), Community=fccommunity, Hubscore=hubscore, Authscore=authscore), stringsAsFactors=FALSE)



g <- make_(ring(10),
           with_vertex_(name = letters[1:10], color = "red"),
           with_edge_(weight = 1:10, color = "green")
)
a <- as_long_data_frame(g_mst)
