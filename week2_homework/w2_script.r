#################################################
### Introduction to Applied Network Research ####
### Week 2: Data Formats and Import/Export   ####
#################################################

## This script teaches you how to import network data 
## from .csv files and .graphml files (two of the formats
## in which you can store relational data)


## first of all, it is good practice to clean your working environment
## since we want to start with a 'clean slate'
## (to execute code place the cursor on the command line 
## and press ctrl+enter)

rm(list = ls())

## load the igraph library (which you installed last week)

library(igraph)


## place the files mentioned in handout #2 in your working directory;
## what follows is my path (yours will look different): 



### Loading data ####

nodes<-read.csv("week2_nodes_table.csv", header=T)
nodes
head(nodes)

edges<-read.csv("week2_edges_table.csv", header=T)
edges
head(edges)


### Rearranging data ####

## here we create the network from the information contained
## in the csv files

## this creates the ties:
g1<-graph_from_edgelist(as.matrix(edges[,1:2]), directed = FALSE)
summary(g1)

## this gives names to the nodes:
V(g1)$name<-as.character(nodes$Label)


## to plot the network:
plot(g1)


## this looks better:

par(mar=c(0,0,0,0))
plot(g1,vertex.size=5, 
     vertex.label.cex=0.6, vertex.label.color="black",
     layout=layout.fruchterman.reingold)

## for an interactive visualization:
tkplot(g1,vertex.size=5, 
       vertex.label.cex=0.6, vertex.label.color="black",
       layout=layout.fruchterman.reingold)



### Importing .graphml file ####

## a faster way to import the data is to use the file
## you exported from Gephi (see handout #2): 

g2<-read_graph("trump_network.csv.graphml", format="graphml")

summary(g2)

plot(g2,vertex.size=5, 
     vertex.label.cex=0.6, vertex.label.color="black",
     layout=layout.fruchterman.reingold)


## for an explanation of what the command summary does, check this help file:
?summary.igraph


#### Export the visualization ####
## this will save a .png file in yout working directory

png(filename="w2_TrumpWorld.png", width=1600,height=1400)
plot(g2,vertex.size=5, 
     vertex.label.cex=1, vertex.label.color="black",
     layout=layout.fruchterman.reingold)
dev.off()



#### Save your objects ####
## before you exit this session, you can save the objects you created:

save(g1,g2,file="w2_networks.RData")