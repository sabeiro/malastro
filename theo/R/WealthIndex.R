library(memisc)
require(stats)
Agri <- as.data.set(spss.system.file('Data/AgriNewVar.sav'))
NSet <- length(Agri$Id);

EstimateValue <- function(CodedNum){
  NRooms <- floor(CodedNum/100000000);
  HUse     <- floor(CodedNum/10000000) - 10*NRooms;
  HRoof    <- floor(CodedNum/1000000) - 100*NRooms - 10*HUse;
  HFloor   <- floor(CodedNum/100000) - 1000*NRooms - 100*HUse - 10*HRoof;
  HWalls   <- floor(CodedNum/10000) - 10000*NRooms - 1000*HUse - 100*HRoof - 10*HFloor;
  HElect   <- floor(CodedNum/1000) - 100000*NRooms - 10000*HUse - 1000*HRoof - 100*HFloor - 10*HWalls;
  HValue   <- floor(CodedNum/100) - 1000000*NRooms - 100000*HUse - 10000*HRoof - 1000*HFloor - 100*HWalls - 10*HElect;
  HTime   <- floor(CodedNum/10) - 10000000*NRooms - 1000000*HUse - 100000*HRoof - 10000*HFloor - 1000*HWalls - 100*HElect - 10*HValue;
  Res <- NRooms*(HFloor + HRoof + HWalls);
  return(Res);
}

WealthIdx1 <- EstimateValue(Agri$H1Value) +  EstimateValue(Agri$H2Value) +  EstimateValue(Agri$H3Value) +  EstimateValue(Agri$H4Value) +  EstimateValue(Agri$H5Value) +  EstimateValue(Agri$H6Value);



ColCode <- c("#cc4c19","#334c99","#cc1966","#33b34c","#4c33cc","lightblue", "mistyrose","lightcyan", "lavender"),
);
NHist <- 75;
#IdxHist <- hist(WealthIdx1,breaks=NHist);
IdxHist <- table(cut(WealthIdx1,b=NHist))
jpeg("Fig/IdxDistr.jpg");
barplot(IdxHist);
dev.off();
CumIdx <- IdxHist;
CumIdx[1] <- IdxHist[1];
for (row in 2:NHist) {
  CumIdx[row] <- CumIdx[row-1] + IdxHist[row];
 }
jpeg("Fig/CumulativeProb.jpg");
barplot(CumIdx,main="cumulative distribution of wealth",xlab="wealth",ylab="cumulative counts");
dev.off();


Classes1 <- numeric(NSet)
for (row in 1:NSet) {
  Classes1[row] <- 1;
  if(WealthIdx1[row] >= 22 & WealthIdx1[row] < 50) {Classes1[row] <- 2}
  if(WealthIdx1[row] >= 50 ) { Classes1[row] <- 3}
 }
Classes1 <- factor(Classes1,levels = c(1,2,3),labels = c("low", "mid", "high")) 
hist(Classes1);
Count <- table(Classes1);
jpeg("Fig/WealthDistribution.jpg");
barplot(Count,main="distribution of wealth",xlab="wealth",ylab="counts",col=ColCode);
dev.off();
jpeg("Fig/WealthDistributionPie.jpg");
XLab <- c(paste("low ",round(Count[1]/349*100),"%",sep=""),paste("mid ",round(Count[2]/349*100),"%",sep=""),paste("high ",round(Count[3]/349*100),"%",sep=""));
library("plotrix", lib.loc="~/share/R/")
pie3D(Count,main="distribution of wealth",labels=XLab)
#pie(Count,main="distribution of wealth",col=ColCode,labels=XLab);
dev.off();


VarName <- c("NMember","Migration","LandSizeTrad","LandSizeHired","LandSizeTitle","NCow","NGoat","NPig","NChicken","NHouse","ToiletKind","NMobile","NMaize","NPotato","NWheat","NBean","NPea","NMchicha","NCabbage","NSpinach","NTomato");


library("gmodels", lib.loc="~/share/R/")
for(v in 1:length(VarName)){
  print(VarName[v]);
  #Res <- DivideSample(Agri,VarName[v],Classes1,NSet);
#  Res <- type.convert(Agri[[ VarName[v] ]], na.strings = "NA", as.is = FALSE, dec = ".");
  Res <- Agri[[ VarName[v] ]];
  RHist <- table(Res);
  NLab <- length(RHist);
  if(NLab >= 4){
    VMin <- floor(min(Res));
    VMax <- max(Res);
    NLab <- 4;
    VDelta <- (VMax-VMin)/NLab;
    Points <- c(VMin,VDelta*(1:NLab));
    Res <- (cut(Agri[[ VarName[v] ]],breaks=Points));
    RHist <- table(Res);
    NLab <- length(RHist);
  }
  CTable <- CrossTable(Res,Classes1);
  NLab <- min(NLab,length(CTable$prop.row)/3);
  QDist <- matrix(ncol=3,nrow=NLab);
  for( d in 1:NLab){
    #QDist[d,] <- c(CTable$prop.row[d,1],CTable$prop.row[d,2],CTable$prop.row[d,3]);
    #QDist[d,] <- c(CTable$prop.tbl[d,1],CTable$prop.tbl[d,2],CTable$prop.tbl[d,3]);
    QDist[d,] <- c(100.*CTable$prop.col[d,1],100.*CTable$prop.col[d,2],100.*CTable$prop.col[d,3]);
  }
  colnames(QDist) <- c("low","mid","high");
  rownames(QDist) <- rownames(CTable$prop.col);
  FName <- paste("Fig/",VarName[v],".jpg",sep="");
  PName <- paste("distribution of",VarName[v]);
  YName <- paste("percentage of",VarName[v]);
  jpeg(FName);
  barplot(QDist,main=PName,xlab="wealth",ylab=YName,legend.text=TRUE,space=.1,args.legend=list(x="topright"),xlim=c(0,.8),width=.19);
  dev.off();
}

