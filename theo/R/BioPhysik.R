NStud <- 23;
NZettel <- 12;

Daja <- c(10,6,10,10,6,10,9,10,9,6,NA,NA);
Max <- c(9,5,8,10,5,7,7,NA,10,5,NA,NA);
Victor <- c(9,6,8,10,10,10,9,8,10,NA,5,NA);
Eduard <- c(9,6,NA,10,10,10,7,8,8,7,NA,NA);
Mathias <- c(9,NA,NA,10,NA,10,7,8,10,NA,5,2);
Dennis <- c(10,8,4,8,5,10,6,7,10,NA,9,NA);
Frank <- c(10,NA,8,7,NA,10,8,6,7,10,NA,4);
JanMirko <- c(10,NA,8,10,NA,NA,6,6,9,10,NA,NA);
AlexB <- c(4,10,8,10,7,NA,4,8,7,7,NA,NA);
AlexP <- c(4,9,8,10,7,NA,4,8,7,7,NA,NA);
Georg <- c(10,10,8,7,NA,10,6,6,7,7,NA,NA);
Christian <- c(10,10,10,7,NA,10,6,6,7,3,NA,NA);
Benjamin <- c(10,10,8,10,NA,8,6,6,7,10,7,4);
JanThiart <- c(10,8,10,10,6,10,7,0000,NA,6,8,NA);
AnnKathrin <- c(10,8,10,8,6,10,NA,10,10,NA,4,NA);
Jelena <- c(10,6,8,NA,6,10,6,9,9,5,NA,NA);
Aike <- c(10,8,10,8,6,NA,9,10,9,6,NA,NA);
AlexR <- c(4,3,5,10,8,NA,6,10,9,7,NA,NA);
Kolja <- c(6,5,8,8,6,10,8,NA,8,NA,7,NA);
Johannes <- c(6,8,10,8,6,10,NA,NA,7,7,10,4);
Anne <- c(10,10,10,10,8,8,8,10,10,9,6,10);
Enrico <- c(0,6,8,10,NA,10,9,10,8,9,8,8);
Peter <- c(0,10,8,10,10,10,8,NA,NA,10,10,NA);

Studenten <- data.frame(Daja,Max,Victor,Eduard,Mathias,
			Dennis,Frank,JanMirko,AlexB,AlexP,
			Georg,Christian,Benjamin,JanThiart,
			AnnKathrin,Jelena,Aike,AlexR,Kolja,
			Johannes,Anne,Enrico,Peter);

Zulassung <- array(0,NStud);
for(i in 1:NStud){
      Zulassung[i] = sum(Studenten [!is.na(Studenten[,i]),i]);
      if(Zulassung[i] < 60) Studenten[,i];
}
sum(Studenten $ Daja);
Positiv <- Studenten[!is.na(Studenten )];
mean(Positiv);
var(Positiv);
jpeg("Positiv.jpg");
hist(Positiv);
dev.off();
jpeg("Studenten.jpg");
boxplot(Daja[Daja>0],Max[Max>0],Victor[Victor>0],Eduard[Eduard>0],
	Mathias[Mathias>0],Dennis[Dennis>0],Frank[Frank>0],
	JanMirko[JanMirko>0],AlexB[AlexB>0],AlexP[AlexP>0],
	Georg[Georg>0],Christian[Christian>0],Benjamin[Benjamin>0],
	JanThiart[JanThiart>0],AnnKathrin[AnnKathrin>0],Jelena[Jelena>0],
	Aike[Aike>0],AlexR[AlexR>0],Kolja[Kolja>0],
	Johannes[Johannes>0],Anne[Anne>0],Enrico[Enrico>0],Peter[Peter>0]);
dev.off();
jpeg("Zettel.jpg");
boxplot( t(Studenten) );
dev.off();







#Studenten <- matrix(0,NStud,NZettel);
#rownames(Studenten) <- c("Daja","Max","Victor","Eduard","Mathias","Dennis","Frank","JanMirko","AlexB","AlexP","Georg","Christian","Benjamin","JanThiart","AnnKathrin","Jelena","Aike","AlexR","Kolja","Johannes","Anne","Enrico","Peter");
