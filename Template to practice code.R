
nodes <- data.frame(id = 1:4)
edges <- data.frame(from = c(1,2), to = c(2,3), group = c("B", "A", "B","D"))

# default, on group
visNetwork(nodes, edges, main = "A really simple example", width = "100%")

# default, on group
visNetwork(nodes, edges, width = "100%") %>%
  visGroups(groupname = "A", color = "red") %>%
  visGroups(groupname = "B", color = "lightblue") %>%
  visLegend()


# nodes data.frame for legend
lnodes <- data.frame(label = c("Group A is here", "Group B is sorte"),
                     shape = c( "ellipse"), color = c("red", "lightblue"),
                     title = "Informations", id = 1:2)

# edges data.frame for legend
ledges <- data.frame(color = c("lightblue", "red"),
                     label = c("reverse", "depends"), arrows =c("to", "from"))

visNetwork(nodes, edges, width = "100%") %>%
  visGroups(groupname = "this is example", color = "red") %>%
  visGroups(groupname = "B", color = "lightblue") %>%
  visLegend(addEdges = ledges, addNodes = lnodes, useGroups = FALSE)


nodes <- data.frame(id = 1:3, group = c("B", "A", "B"))
edges <- data.frame(from = c(1,2), to = c(2,3))

visNetwork(nodes, edges) %>%
  addFontAwesome() %>%
  visLegend(addNodes = list(
    list(label = "OMNI", shape = "icon", 
         icon = list(code = "f0c0", size = 25)),
    list(label = "User", shape = "icon", 
         icon = list(code = "f007", size = 10, color = "red"))), 
    useGroups = FALSE)


barplot(1:20, col=rainbow(20))
# Use heat.colors
barplot(1:10, col=heat.colors(10))


library(RColorBrewer)
brewer.pal(n = 8, name = "Dark2")

display.brewer.all()
display.brewer.pal(n = 16, name = 'Dark2')


library(randomcoloR)
n <- 30
palette <- distinctColorPalette(n)

pie(rep(1, n), col=palette)


temp <- c(5,7,6,4,8)
barplot(temp, col="#c00000", main="#c00000")

barplot(temp, col=as.character(palette[10]), main="#c00000")

