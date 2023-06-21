{
gROOT->Reset();
TCanvas *finestra = new TCanvas("finestra","finestra",1);
finestra->Divide(2,2);
int nBin = 1100;
float NaIZero = -27.0267;//-27.049;
float NaIFine = 2240.95;//2216.94;
float GeZero = -0.24;//0.0067;
float GeFine = 2207.27;//2209.325;
TFile * file = new TFile("Scatola.root","r");
TH1F * IstNaI = new TH1F("IstNaI","IstNaI",nBin,0,2200);
finestra->cd(1);
pjmca->Draw("ch2>>IstNaI");
//IstNaI= &IstooNaI;
IstNaI->SetLineColor(2);
IstNaI->Scale(1./1811.4);
IstNaI->GetXaxis()->Set(nBin,-27.049,2216.94);
IstNaI->GetXaxis()->SetRange(10,nBin);
TH1F * IstGe = new TH1F("IstGe","IstGe",nBin,0,2200);
finestra->cd(3);
pjmca->Draw("ch3>>IstGe");
//IstGe= &IstooGe;
IstGe->SetLineColor(2); 
IstGe->Scale(1./1814.4);
IstGe->GetXaxis()->Set(nBin,0.0067,2209.325);
IstGe->GetXaxis()->SetRange(10,nBin);
finestra->cd(1);
IstNaI->Draw();
finestra->cd(3);
IstGe->Draw();
TF1 * ffondoNaI = new TF1("ffondoNaI","pol8",55,1900);
TF1 * ffondoGe = new TF1("ffondoGe","pol8",55,1900);
IstNaI->Fit("ffondoNaI","R");
IstGe->Fit("ffondoGe","R");
TH1F * PulireNaI = new TH1F("PulireNaI","PulireNaI",nBin,0,2200);
TH1F * PulireGe = new TH1F("PulireGe","PulireGe",nBin,0,2200);
PulireNaI = (TH1F *)ffondoNaI->GetHistogram();
PulireGe  = (TH1F *)ffondoGe->GetHistogram();
PulireNaI->SetLineWidth(1);
PulireNaI->GetXaxis()->Set(nBin,-27.049,2240.95);//NaIZero,NaIFine);
PulireGe->SetLineWidth(1);
PulireGe->GetXaxis()->Set(nBin,-0.24,2207.27);//GeZero,GeFine);
TFile * file = new TFile("Autunnite.root","r");
finestra->cd(1);
TH1F * IstoNaI = new TH1F("IstoNaI","IstoNaI",nBin,0,2200);
TH1F * IstoGe = new TH1F("IstoGe","IstoGe",nBin,0,2200);
pjmca->Draw("ch2>>IstoNaI");
//IstoNaI= &IstooNaI;
IstoNaI->SetLineColor(4);
IstoNaI->Scale(1./1806.);
IstoNaI->GetXaxis()->Set(nBin,NaIZero,NaIFine);
IstoNaI->GetXaxis()->SetRange(10,nBin);
IstNaI->Draw("same");
finestra->cd(3);
pjmca->Draw("ch3>>IstoGe");
//IstoGe= &IstooGe;
IstoGe->SetLineColor(4);
IstoGe->Scale(1./1810.);
IstoGe->GetXaxis()->Set(nBin,GeZero,GeFine);
IstoGe->GetXaxis()->SetRange(10,nBin);
IstGe->Draw("same");
TFile * file = new TFile("Radon105.root","r");
finestra->cd(1);
TH1F * IstooNaI = new TH1F("IstooNaI","IstooNaI",nBin,0,2200);
TH1F * IstooGe = new TH1F("IstooGe","IstooGe",nBin,0,2200);
pjmca->Draw("ch2>>IstooNaI");
//IstoNaI= &IstooNaI;
IstooNaI->SetLineColor(6);
IstooNaI->Scale(1./1806.);
IstooNaI->GetXaxis()->Set(nBin,NaIZero,NaIFine);
IstooNaI->GetXaxis()->SetRange(10,nBin);
IstNaI->Draw("same");
IstoNaI->Draw("same");
finestra->cd(3);
pjmca->Draw("ch3>>IstooGe");
//IstoGe= &IstooGe;
IstooGe->SetLineColor(6);
IstooGe->Scale(1./1810.);
IstooGe->GetXaxis()->Set(nBin,GeZero,GeFine);
IstooGe->GetXaxis()->SetRange(10,nBin);
IstGe->Draw("same");
IstoGe->Draw("same");
TH1F * PulitoNaI = new TH1F("PulitoNaI","PulitoNaI",nBin,0,nBin);
TH1F * PulitoGe = new TH1F("PulitoGe","PulitoGe",nBin,0,nBin);
TH1F * PulitooNaI = new TH1F("PulitooNaI","PulitooNaI",nBin,0,nBin);
TH1F * PulitooGe = new TH1F("PulitooGe","PulitooGe",nBin,0,nBin);
for(int i=1,j=1;i<nBin;i++){
  PulitoNaI->Fill(i,(IstoNaI->GetBinContent(i)-PulireNaI->GetBinContent(i))/PulireNaI->GetBinContent(j));
  PulitoNaI->Fill(i,(IstooNaI->GetBinContent(i)-PulireNaI->GetBinContent(i))/PulireNaI->GetBinContent(j));

  if(i%(nBin/100)==0)j++;
}
finestra->cd(2);
PulitoNaI->SetLineColor(4);
PulitoNaI->GetXaxis()->Set(nBin,NaIZero,NaIFine);
PulitoNaI->GetXaxis()->SetRange(10,nBin);
PulitoNaI->Draw();
PulitooNaI->SetLineColor(6);
PulitooNaI->GetXaxis()->Set(nBin,NaIZero,NaIFine);
PulitooNaI->GetXaxis()->SetRange(10,nBin);
PulitooNaI->Draw("same");
for(int i=1,j=1;i<nBin;i++){
  PulitoGe->Fill(i,(IstoGe->GetBinContent(i)-PulireGe->GetBinContent(i))/PulireGe->GetBinContent(j));
  PulitooGe->Fill(i,(IstooGe->GetBinContent(i)-PulireGe->GetBinContent(i))/PulireGe->GetBinContent(j));

  if(i%(nBin/100)==0){
    j++;
  }

}
finestra->cd(4);
PulitoGe->SetLineColor(4);
PulitoGe->GetXaxis()->Set(nBin,GeZero,GeFine);
PulitoGe->GetXaxis()->SetRange(10,nBin);
PulitoGe->Draw();
PulitooGe->SetLineColor(6);
PulitooGe->GetXaxis()->Set(nBin,GeZero,GeFine);
PulitooGe->GetXaxis()->SetRange(10,nBin);
PulitooGe->Draw("same");
TCanvas *Nuova = new TCanvas("Nuova","Nuova",2);
Nuova->cd(1);
const int FineNaI=9;
float LimiNaI[FineNaI]={46,157,189,253,309,540,1058,1321,1656};
float LimsNaI[FineNaI]={94,189,253,309,373,651,1178,1472,1855};
const int FineGe=14;
float LimiGe[FineGe]={63,182,236,289,348,599,1112,1236,1377,1454,1507,1727,1761,1844};
float LimsGe[FineGe]={78,190,246,300,356,618,1125,1246,1385,1468,1515,1737,1772,1852};
for(int i=0;i<FineGe;i++){
  LimsGe[i]=LimiGe[i]+10;
}
Gauss *ConstNaI,*ConstGe;
ConstNaI = (Gauss *)malloc(20*sizeof(Gauss));
ConstGe = (Gauss *)malloc(20*sizeof(Gauss));
for(int i=0;i<FineNaI;i++){
  *(ConstNaI+i) = Interpola(LimiNaI[i],LimsNaI[i],PulitoNaI,PulireNaI);
 }
for(int i=0;i<FineGe;i++){
  *(ConstGe+i) = Interpola(LimiGe[i],LimsGe[i],PulitoGe,PulireGe);
}
Tabella = fopen("AutunniteNaI.tex","w");
fprintf(Tabella,"\\begin{tabular}{c c c c}\n \
\\hline\n \
\\multicolumn{4}{c}{Ioduro}\n\
\\hline\n \
&Constante&Centroide&$\sigma$\\\\\n \
\\hline\n");
for(int i=0;i<FineNaI;i++){
  fprintf(Tabella,"%d & %.3f& %.1f& %.3f\\\\\n",i,(ConstNaI+i)->uno,(ConstNaI+i)->due,(ConstNaI+i)->tre);
}
fprintf(Tabella,"\\hline\n \
\\end{tabular}\n");
fclose(Tabella);
Tabella = fopen("AutunniteGe.tex","w");
fprintf(Tabella,"\\begin{tabular}{c c c c}\n \
\\hline\n \
\\multicolumn{4}{c}{HGe}\\\\ \n\
\\hline\n \
&Constante&Centroide&$\sigma$\\\\\n \
\\hline \n");
for(int i=0;i<FineGe;i++){
  fprintf(Tabella,"%d & %.3f& %.1f& %.3f\\\\\n",i,(ConstGe+i)->uno,(ConstGe+i)->due,(ConstGe+i)->tre);
}
fprintf(Tabella,"\\hline\n \
\\end{tabular}\n");
fclose(Tabella);


printf("Te ve be te `e!\n");
}
