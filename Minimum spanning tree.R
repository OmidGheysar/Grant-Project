library(igraph)
library(nb2listw)
# install.packages("spdep")
library(spdep)
bh <- st_read(system.file("etc/shapes/bhicv.shp",
                          package="spdep")[1], quiet=TRUE)
st_crs(bh) <- "+proj=longlat +ellps=WGS84"
### data padronized
dpad <- data.frame(scale(as.data.frame(bh)[,5:8]))

### neighboorhod list 
bh.nb <- poly2nb(bh)

### calculing costs
lcosts <- nbcosts(bh.nb, dpad)

### making listw
nb.w <- nb2listw(bh.nb, lcosts, style="B")

### find a minimum spanning tree
system.time(mst.bh <- mstree(nb.w,5))
#>    user  system elapsed 
#>   0.002   0.000   0.001 
dim(mst.bh)
#> [1] 97  3
head(mst.bh)
#>      [,1] [,2]      [,3]
#> [1,]    5   12 1.2951120
#> [2,]   12   13 0.6141101
#> [3,]   13   11 0.7913745
#> [4,]   13    6 0.9775650
#> [5,]   11   31 0.9965625
#> [6,]   31   39 0.6915158
tail(mst.bh)
#>       [,1] [,2]      [,3]
#> [92,]   89   90 2.5743702
#> [93,]   26   56 2.6235317
#> [94,]   86   87 2.6471303
#> [95,]   87   72 0.7874461
#> [96,]   49   36 2.8743677
#> [97,]   24   25 3.4675168
### the mstree plot
par(mar=c(0,0,0,0))
plot(st_geometry(bh), border=gray(.5))
# plot(mst.bh, coordinates(as(bh, "Spatial")), col=2,
#      cex.lab=.6, cex.circles=0.035, fg="blue", add=TRUE)


word.list <- list(letters[1:4], letters[1:5], letters[1:2], letters[1:6])
n.obs <- sapply(word.list, length)
seq.max <- seq_len(max(n.obs))
mat <- t(sapply(word.list, "[", i = seq.max))


g <- sample_gnp(100, 3/100)
g_mst <- mst(g)



n <- 5
g <- make_full_graph(n)

# number of edges in an (undirected) full graph is (n2 - n) /2 but
# it is easier to just ask the graph how many edges it has - this
# is more portable if you change from make_full_graph
n_edge <- gsize(g)
g <- set_edge_attr(g, 'weight', value=runif(n_edge))
plot(g)

mst <-  minimum.spanning.tree(g)
