# working on colors and shapes starting with example

require(visNetwork, quietly = TRUE)
nodes <- data.frame(id = 1:10,
                    
                    # add labels on nodes
                    label = paste("Nodel", 1:10),
                    
                    # add groups on nodes 
                    group = c("GrA", "GrB"),
                    
                    # # size adding value
                    # value = rep(1,10),          
                    
                    # control shape of nodes
                    shape = c("square", "triangle", "box", "circle", "dot", "star",
                              "ellipse", "database", "text", "diamond"),
                    
                    # tooltip (html or character), when the mouse is above
                    title = paste0("<p><b>", 1:10,"</b><br>Node !</p>"),
                    
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

# Tip! taking look at data frame is very helpful to understand the parameters of nodes 
# So I need to save grant info to color them in the shape, I should assign a color for each grant
# tooltip ideas sounds interesting as well I suppose it uses a labels, Node is a connect point lets try


nodes <- data.frame(id = 1:5, group = c(rep("A", 2), rep("B", 3)))
edges <- data.frame(from = c(2,5,3,3), to = c(1,2,4,2))

visNetwork(nodes, edges, width = "100%") %>% 
  # darkblue square with shadow for group "A"
  visGroups(groupname = "A", color = "darkblue", shape = "square", 
            shadow = list(enabled = TRUE)) %>% 
  # red triangle for group "B"
  visGroups(groupname = "B", color = "red", shape = "triangle")  

