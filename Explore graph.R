
###  Digital Humanities code ###
library(dplyr)

nodes <- read.csv("C:/Python Scripts/aitana_nodes.csv",
                  header=TRUE, encoding = "UTF-8")
node_names <- nodes$name


# Remove the last column (country)
nodes <- nodes %>% select(-country)

edges <- read.csv("C:/Python Scripts/aitana_edges.csv",
                  header=TRUE, encoding = "UTF-8")

print(length(node_names))


library(igraph)

G = graph.data.frame(edges, directed = F,vertices = nodes)
#And what happened now? Have basic info output ...
G

density <- graph.density(G)
print(paste("Network density:", format(density,digits = 4)))

diameter <- diameter(subgraph)
print(paste("Diameter of subgraph:", diameter))

degree.G <- degree(G)
head(degree.G)

G <- set_vertex_attr(G, "degree", index = V(G), degree.G)
print(paste("Largest degree:", sort(degree.G,decreasing = T)[1]))
#print out the 20 largest nodes w.r.t. degree
sort(degree.G,decreasing = T)[1:20]

eigen_centrality.G <- eigen_centrality(G)
betweenness_centrality.G <- betweenness(G,normalized = T)
G <- set_vertex_attr(G, "eigen_centrality",
                     index = V(G), eigen_centrality.G$vector)
G <- set_vertex_attr(G, "betweenness_centrality",
                     index = V(G), betweenness_centrality.G)
#print out the 10 largest nodes w.r.t. eigenvector degree
sort(eigen_centrality.G$vector,decreasing = T)[1:10]

#print out the 10 largest nodes w.r.t. eigenvector degree
sort(betweenness_centrality.G,decreasing = T)[1:10]

c1 = cluster_fast_greedy(G)
G <- set_vertex_attr(G, "modularity", index = V(G), membership(c1))
