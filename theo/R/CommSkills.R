#!/usr/bin/env Rscript
library(stringi)
library(wordcloud)
library(RColorBrewer)
library(igraph)
library(ggplot2)
library(tm)
library(cluster)
library(FactoMineR)
library(plyr)
Sys.setlocale(category = "LC_ALL", locale = "English_United States.1252")
Sys.setenv(LANG = "en_US.UTF-8")


print("----word-graph");
k_cluster <- 11
lim = 40
k_cluster = round(k_cluster/log10(lim))
k_cluster = 11
comm_prob = 0.86

skillPal = c("#007ACC","#003399","#000099","#4713CC","#B66348","#95A338","#B17A53","#A83359","#AA0099","#EE9900","#CCAA00","#008888","#99BB99","#5A5aCC");

gAvCol <- 'red'
gWidth <- 12
gHeight <- 8
gRes <- 100
gFontSize  <- 18
gLabelSize  <- 5
pointSize <- 3
lineSize <- 2


skills <- as.matrix(read.csv("skills.csv",header=TRUE,check.names=FALSE,fileEncoding="UTF-8",row.names=1))
skills[is.na(skills)] <- 0
# remove columns (docs) with zeroes
#skills = skills[rowSums(skills)!=0,colSums(skills)!=0]
diag(skills) = 0
skills = skills + t(skills)
wc = rowSums(skills)
for(i in seq(1:length(colnames(skills)))){
	skills[i,i] = wc[[i]]
}
# word counts
# get those words above the 3rd quantile
#lim = quantile(wc, probs=comm_prob)
# get those words above the 3rd quantile
good <- skills
good = skills[wc > lim,wc > lim]
s_words <- read.csv("skills.csv",header=FALSE,nrows=1, skip=0)

adja_matrix <- good
diag(adja_matrix) <- 0
affi_matrix <- good

# Create a graph
gp_graph = graph.adjacency(adja_matrix, weighted=TRUE,
	#    mode=c("directed", "undirected", "max","min", "upper", "lower", "plus"),
    mode = "max",
    add.rownames=TRUE)


# coordinates for visualization
posi_matrix = layout.fruchterman.reingold(gp_graph, list(weightsA=E(gp_graph)$weight))
#posi_matrix = layout.drl(gp_graph, list(weightsA=E(gp_graph)$weight))
#posi_matrix = layout.spring(gp_graph, list(weightsA=E(gp_graph)$weight))

posi_matrix = cbind(V(gp_graph)$name, posi_matrix)


# create a data frame
gp_df = data.frame(posi_matrix, stringsAsFactors=FALSE)
names(gp_df) = c("word", "x", "y")
gp_df$x = as.numeric(gp_df$x)
gp_df$y = as.numeric(gp_df$y)

#Mx <- max(gp_df$x)
#mx <- min(gp_df$x)
#My <- max(gp_df$y)
#my <- min(gp_df$y)
#textplot(gp_df$x,gp_df$y,gp_df$word,xlim=c(mx,Mx),ylim=c(my,My))
#nvc <- wordlayout(gp_df$x,gp_df$y,gp_df$word)
#text(nvc[,1] + .5*nvc[,3],nvc[,2]+.5*nvc[,4],gp_df$word,cex=50:1/20)

# size effect
se = diag(affi_matrix) / max(diag(affi_matrix))
# plot
svg("CommSkills.svg",width=gWidth,height=gHeight)  
par(bg = "gray15")
with(gp_df, plot(x, y, type="n", xaxt="n", yaxt="n", xlab="", ylab="", bty="n"))
with(gp_df, text(x, y, labels=word, cex=log10(diag(affi_matrix)),
col=hsv(0.95, se, 1, alpha=se)))

# k-means with 7 clusters
words_km = kmeans(cbind(as.numeric(posi_matrix[,2]), as.numeric(posi_matrix[,3])), k_cluster)

# add frequencies and clusters in a data frame
w_size <- diag(affi_matrix)^(0.1)

gp_df = transform(gp_df, freq=w_size, cluster=as.factor(words_km$cluster))
row.names(gp_df) = 1:nrow(gp_df)
#gp_df$word <- t(s_words)
# graphic with ggplot

gp_words = ggplot(gp_df, aes(x=x, y=y)) +
geom_text(aes(size=freq, label=gp_df$word, alpha=.90, color=as.factor(cluster),angle=0)) +
labs(x="", y="") +
scale_size_continuous(breaks = c(10,20,30,40,50,60,70,80,90), range = c(5,12)) +
#scale_colour_manual(values=brewer.pal(8, "PuBu")) +
scale_colour_manual(values=skillPal) +
scale_x_continuous(breaks=c(min(gp_df$x), max(gp_df$x)), labels=c("","")) +
scale_y_continuous(breaks=c(min(gp_df$y), max(gp_df$y)), labels=c("","")) +
theme(panel.grid.major=element_blank(),
    legend.position="none",
    #panel.background=element_rect(fill="gray10", colour="gray10"),
    panel.background = element_rect(fill="transparent",colour=NA),
    panel.grid.minor=element_blank(),
    axis.ticks=element_blank(),
    title = element_text("Skills clustering"),
    plot.title = element_text(size=12))
plot(gp_words)
dev.off()

# save the image in pdf format
#ggsave(plot=gp_words, filename="Greenpeace_wordgraph.pdf", height=10, width=10)
