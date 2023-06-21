{
gROOT->Reset();
TCanvas *finestra = new TCanvas("finestra","finestra",1);
finestra->Divide(2,2);
finestra->SetFillColor(0);
finestra->cd(1);
finestra->GetPad(1)->SetFillColor(0);
finestra->GetPad(2)->SetFillColor(0);
finestra->GetPad(3)->SetFillColor(0);
finestra->GetPad(4)->SetFillColor(0);
int nBinNaI = 500;
int nBinGe= 2200;
int nBinPulNaI = 100;
int nBinPulGe= 100;
// float NaIZero = -27.0267;//-27.049;
// float NaIFine = 2240.95;//2216.94;
// float GeZero = -0.24;//0.0067;
// float GeFine = 2207.27;//2209.325;
float NaIZero = -31.620;
float NaIFine = 2227.9;
float GeZero = 3.5967;//0.0067;
float GeFine = 2197.0;//2209.325;
float RapGe = 0.3787;
float RapFunghi = 0.00157;
float RapCastagne=0.00351;
float RapIntonaco=0.000613;
float PicchiNaI[]={60,519,1272};
float EffiNaI[]={0.00028137,0.00027654,0.000079166};
float PicchiGe[] = {59.540,121.78,244.76,344.27,411.34,443.96,778.90,867.37,964.07,1085.9,1112.1,1408.0};
float EffiGe[] ={.00067888,.00086519,.00098536,.00071659,.00069620,.00059794,.00025551,.00024940,.00018641,.00014545,.00014499,.000096698};
float PesoFunghi = 0.051;
float PesoIntonaco = 0.3227;
float PesoMarroni = 0.2822;
//for(int i=0;i<12;i++)EffiGe[i]*=0.3787;
TH1F *EffNaI = new TH1F("EffNaI","EffNaI",2200,0,2200);
for(int i=0;i<3;i++)EffNaI->Fill(PicchiNaI[i],EffiNaI[i]);
TF1 * fEffNaI = new TF1("fEffNaI","landau",0,2200);
fEffNaI->SetLineWidth(1);
EffNaI->Fit("fEffNaI","R");
TH1F *EfficienzaNaI = new TH1F("EfficienzaNaI","EfficienzaNaI",nBinNaI,0,2200);
for(int i=0;i<nBinNaI;i++){
  EfficienzaNaI->Fill(((float)i+0.1)/((float)nBinNaI)*2200.,fEffNaI->Eval(((float)i+0.1)/((float)nBinNaI)*2200.));
}
EfficienzaNaI->SetLineWidth(1);
EfficienzaNaI->GetXaxis()->Set(nBinNaI,NaIZero,NaIFine);
TH1F *EffGe = new TH1F("EffGe","EffGe",2200,0,2200);
for(int i=0;i<12;i++)EffGe->Fill(PicchiGe[i],EffiGe[i]);
TF1 * fEffGe = new TF1("fEffGe","landau",0,2200);
fEffGe->SetLineWidth(1);
EffGe->Fit("fEffGe","R");
TH1F * EfficienzaGe = new TH1F("EfficienzaGe","EfficienzaGe",nBinGe,0,2200);
for(int i=0;i<nBinGe;i++){
  EfficienzaGe->Fill(((float)i+0.1)/((float)nBinGe)*2200.,fEffGe->Eval(((float)i+0.1)/((float)nBinGe)*2200.));
}
EfficienzaGe->SetLineWidth(1);
EfficienzaGe->GetXaxis()->Set(nBinGe,GeZero,GeFine);
// Carico file del fondo
TFile * file = new TFile("Fondo_27Nov06.root","r");
TH1F * IstFondoNaI = new TH1F("IstFondoNaI","IstFondoNaI",nBinNaI,0,2200);
pjmca->Draw("ch2>>IstFondoNaI");
//IstFondoNaI= &IstooNaI;
IstFondoNaI->SetLineColor(2);
IstFondoNaI->Scale(1./1662.0);
IstFondoNaI->GetXaxis()->Set(nBinNaI,-14.96,2108);
IstFondoNaI->GetXaxis()->SetRange(10,nBinNaI);
TH1F * IstFondoGe = new TH1F("IstFondoGe","IstFondoGe",nBinGe,0,2200);
pjmca->Draw("ch3>>IstFondoGe");
//IstFondoGe= &IstIntonacoGe;
IstFondoGe->SetLineColor(2);
IstFondoGe->Scale(1./1662.0);
IstFondoGe->GetXaxis()->Set(nBinGe,0.477,2089);
IstFondoGe->GetXaxis()->SetRange(10,nBinGe);
//
TFile * file = new TFile("Scatola.root","r");
TH1F * IstScatolaNaI = new TH1F("IstScatolaNaI","IstScatolaNaI",nBinNaI,0,2200);
finestra->cd(1);
pjmca->Draw("ch2>>IstScatolaNaI");
//IstScatolaNaI= &IstooNaI;
IstScatolaNaI->SetLineColor(2);
IstScatolaNaI->Scale(1./1811.4);
IstScatolaNaI->GetXaxis()->Set(nBinNaI,NaIZero,NaIFine);
IstScatolaNaI->GetXaxis()->SetRange(10,nBinNaI);
TH1F * IstScatolaGe = new TH1F("IstScatolaGe","IstScatolaGe",nBinGe,0,2200);
finestra->cd(3);
pjmca->Draw("ch3>>IstScatolaGe");
//IstScatolaGe= &IstIntonacoGe;
IstScatolaGe->SetLineColor(2);
IstScatolaGe->Scale(1./1956.4);
IstScatolaGe->GetXaxis()->Set(nBinGe,GeZero,GeFine);
IstScatolaGe->GetXaxis()->SetRange(10,nBinGe);
finestra->cd(1);
IstScatolaNaI->Draw();
finestra->cd(3);
IstScatolaGe->Draw();
TF1 * fFondoNaI = new TF1("fFondoNaI","landau",55,1900);
TF1 * fFondoGe = new TF1("fFondoGe","landau",55,1900);
IstScatolaNaI->Fit("fFondoNaI","R");
IstScatolaGe->Fit("fFondoGe","R");
TH1F * PulireNaI = new TH1F("PulireNaI","PulireNaI",nBinNaI,0,2200);
TH1F * PulireGe = new TH1F("PulireGe","PulireGe",nBinGe,0,2200);
for(int i=0;i<nBinNaI;i++){
  PulireNaI->Fill(((float)i+0.1)/((float)nBinNaI)*2200.,fFondoNaI->Eval(((float)i+0.1)/((float)nBinNaI)*2200.));
}
for(int i=0;i<nBinGe;i++){
  PulireGe->Fill(((float)i+0.1)/((float)nBinGe)*2200.,fFondoGe->Eval(((float)i+0.1)/((float)nBinGe)*2200.));
}
PulireNaI->SetLineWidth(1);
PulireNaI->GetXaxis()->Set(nBinNaI,NaIZero,NaIFine);//NaIZero,NaIFine);
PulireGe->SetLineWidth(1);
PulireGe->GetXaxis()->Set(nBinGe,NaIZero,NaIFine);//GeZero,GeFine);
//
TFile * file = new TFile("Funghetti_maledetti.root","r");
finestra->cd(1);
TH1F * IstFunghiNaI = new TH1F("IstFunghiNaI","IstFunghiNaI",nBinNaI,0,2200);
TH1F * IstFunghiGe = new TH1F("IstFunghiGe","IstFunghiGe",nBinGe,0,2200);
pjmca->Draw("ch2>>IstFunghiNaI");
//IstFunghiNaI= &IstIntonacoNaI;
IstFunghiNaI->SetLineColor(4);
IstFunghiNaI->Scale(1./1801.);
IstFunghiNaI->GetXaxis()->Set(nBinNaI,NaIZero,NaIFine);
IstFunghiNaI->GetXaxis()->SetRange(10,nBinNaI);
IstScatolaNaI->Draw("same");
finestra->cd(3);
pjmca->Draw("ch3>>IstFunghiGe");
//IstFunghiGe= &IstIntonacoGe;
IstFunghiGe->SetLineColor(4);
IstFunghiGe->Scale(1./1800.);
IstFunghiGe->GetXaxis()->Set(nBinGe,GeZero,GeFine);
IstFunghiGe->GetXaxis()->SetRange(10,nBinGe);
IstScatolaGe->Draw("same");
//
TFile * file = new TFile("Intonaco.root","r");
TH1F * IstIntonacoNaI = new TH1F("IstIntonacoNaI","IstIntonacoNaI",nBinNaI,0,2200);
TH1F * IstIntonacoGe = new TH1F("IstIntonacoGe","IstIntonacoGe",nBinGe,0,2200);
finestra->cd(1);
pjmca->Draw("ch2>>IstIntonacoNaI");
//IstoNaI= &IstIntonacoNaI;
IstIntonacoNaI->SetLineColor(6);
IstIntonacoNaI->Scale(1./1810.);
IstIntonacoNaI->GetXaxis()->Set(nBinNaI,NaIZero,NaIFine);
IstIntonacoNaI->GetXaxis()->SetRange(10,nBinNaI);
finestra->cd(3);
pjmca->Draw("ch3>>IstIntonacoGe");
//IstoGe= &IstIntonacoGe;
IstIntonacoGe->SetLineColor(6);
IstIntonacoGe->Scale(1./1801.);
IstIntonacoGe->GetXaxis()->Set(nBinGe,GeZero,GeFine);
IstIntonacoGe->GetXaxis()->SetRange(10,nBinGe);
//
TFile * file = new TFile("Marronata.root","r");
TH1F * IstMarroniNaI = new TH1F("IstMarroniNaI","IstMarroniNaI",nBinNaI,0,2200);
TH1F * IstMarroniGe = new TH1F("IstMarroniGe","IstMarroniGe",nBinGe,0,2200);
finestra->cd(1);
pjmca->Draw("ch2>>IstMarroniNaI");
//IstFunghiNaI= &IstIntonacoNaI;
IstMarroniNaI->SetLineColor(3);
IstMarroniNaI->Scale(1./1806.);
IstMarroniNaI->GetXaxis()->Set(nBinNaI,NaIZero,NaIFine);
IstMarroniNaI->GetXaxis()->SetRange(10,nBinNaI);
IstScatolaNaI->Draw("same");
IstFunghiNaI->Draw("same");
IstIntonacoNaI->Draw("same");
finestra->cd(3);
pjmca->Draw("ch3>>IstMarroniGe");
//IstFunghiGe= &IstIntonacoGe;
IstMarroniGe->SetLineColor(3);
IstMarroniGe->Scale(1./1801.);
IstMarroniGe->GetXaxis()->Set(nBinGe,GeZero,GeFine);
IstMarroniGe->GetXaxis()->SetRange(10,nBinGe);
IstScatolaGe->Draw("same");
IstFunghiGe->Draw("same");
IstIntonacoGe->Draw("same");
TH1F * PulFunghiNaI = new TH1F("PulFunghiNaI","PulFunghiNaI",nBinNaI,0,nBinNaI);
TH1F * PulFunghiGe = new TH1F("PulFunghiGe","PulFunghiGe",nBinGe,0,nBinGe);
TH1F * PulIntonacoNaI = new TH1F("PulIntonacoNaI","PulIntonacoNaI",nBinNaI,0,nBinNaI);
TH1F * PulIntonacoGe = new TH1F("PulIntonacoGe","PulIntonacoGe",nBinGe,0,nBinGe);
TH1F * PulMarroniNaI = new TH1F("PulMarroniNaI","PulMarroniNaI",nBinNaI,0,nBinNaI);
TH1F * PulMarroniGe = new TH1F("PulMarroniGe","PulMarroniGe",nBinGe,0,nBinGe);
TH1F * PulScatolaNaI = new TH1F("PulScatolaNaI","PulScatolaNaI",nBinNaI,0,nBinNaI);
TH1F * PulScatolaGe = new TH1F("PulScatolaGe","PulScatolaGe",nBinGe,0,nBinGe);
TH1F * PulFondoNaI = new TH1F("PulFondoNaI","PulFondoNaI",nBinNaI,0,nBinNaI);
TH1F * PulFondoGe = new TH1F("PulFondoGe","PulFondoGe",nBinGe,0,nBinGe);
for(int i=1,j=1;i<nBinNaI;i++){
  PulFunghiNaI->Fill(i,((IstFunghiNaI->GetBinContent(i)-PulireNaI->GetBinContent(i))/EfficienzaNaI->GetBinContent(i))*RapFunghi);
  PulIntonacoNaI->Fill(i,((IstIntonacoNaI->GetBinContent(i)-PulireNaI->GetBinContent(i))/EfficienzaNaI->GetBinContent(i))*RapIntonaco);
  PulMarroniNaI->Fill(i,((IstMarroniNaI->GetBinContent(i)-PulireNaI->GetBinContent(i))/EfficienzaNaI->GetBinContent(i))*RapCastagne);
  PulScatolaNaI->Fill(i,(IstScatolaNaI->GetBinContent(i)-PulireNaI->GetBinContent(i))/EfficienzaNaI->GetBinContent(i));
  PulFondoNaI->Fill(i,(IstFondoNaI->GetBinContent(i))/EfficienzaNaI->GetBinContent(i));
  if(i%(nBinNaI/100)==0)j++;
}
finestra->cd(2);
PulFunghiNaI->SetLineColor(4);
PulFunghiNaI->GetXaxis()->Set(nBinNaI,NaIZero,NaIFine);
PulFunghiNaI->GetXaxis()->SetRange(10,nBinNaI);
PulIntonacoNaI->SetLineColor(6);
PulIntonacoNaI->GetXaxis()->Set(nBinNaI,NaIZero,NaIFine);
PulIntonacoNaI->GetXaxis()->SetRange(10,nBinNaI);
PulMarroniNaI->SetLineColor(3);
PulMarroniNaI->GetXaxis()->Set(nBinNaI,NaIZero,NaIFine);
PulMarroniNaI->GetXaxis()->SetRange(10,nBinNaI);
PulScatolaNaI->SetLineColor(2);
PulScatolaNaI->GetXaxis()->Set(nBinNaI,NaIZero,NaIFine);
PulScatolaNaI->GetXaxis()->SetRange(10,nBinNaI);
PulFondoNaI->GetXaxis()->Set(nBinNaI,-14.96,2108);
PulFondoNaI->GetXaxis()->SetRange(10,nBinNaI);
PulIntonacoNaI->Draw();
PulFunghiNaI->Draw("same");
PulMarroniNaI->Draw("same");
//PulScatolaNaI->Draw("same");
for(int i=1,j=1;i<nBinGe;i++){
  PulFunghiGe->Fill(i,((IstFunghiGe->GetBinContent(i)-PulireGe->GetBinContent(i))/EfficienzaGe->GetBinContent(i))*RapGe);
  PulIntonacoGe->Fill(i,((IstIntonacoGe->GetBinContent(i)-PulireGe->GetBinContent(i))/EfficienzaGe->GetBinContent(i))*RapGe);
  PulMarroniGe->Fill(i,((IstMarroniGe->GetBinContent(i)-PulireGe->GetBinContent(i))/EfficienzaGe->GetBinContent(i))*RapGe);
  PulScatolaGe->Fill(i,(IstScatolaGe->GetBinContent(i)-PulireGe->GetBinContent(i))/EfficienzaGe->GetBinContent(i));
  PulFondoGe->Fill(i,(IstFondoGe->GetBinContent(i))/EfficienzaGe->GetBinContent(i));
  if(i%(nBinGe/100)==0){
    j++;
  }
}
finestra->cd(4);
PulFunghiGe->SetLineColor(4);
PulFunghiGe->GetXaxis()->Set(nBinGe,GeZero,GeFine);
PulFunghiGe->GetXaxis()->SetRange(10,nBinGe);
PulIntonacoGe->SetLineColor(6);
PulIntonacoGe->GetXaxis()->Set(nBinGe,GeZero,GeFine);
PulIntonacoGe->GetXaxis()->SetRange(10,nBinGe);
PulMarroniGe->SetLineColor(3);
PulMarroniGe->GetXaxis()->Set(nBinGe,GeZero,GeFine);
PulMarroniGe->GetXaxis()->SetRange(10,nBinGe);
PulScatolaGe->SetLineColor(2);
PulScatolaGe->GetXaxis()->Set(nBinGe,GeZero,GeFine);
PulScatolaGe->GetXaxis()->SetRange(10,nBinGe);
PulFondoGe->GetXaxis()->Set(nBinNaI,0.477,2089);
PulFondoGe->GetXaxis()->SetRange(10,nBinNaI);
PulIntonacoGe->Draw();
PulFunghiGe->Draw("same");
PulMarroniGe->Draw("same");
//PulScatolaGe->Draw("same");
TCanvas *Nuova = new TCanvas("Nuova","Nuova",2);
Nuova->cd(1);
const int FineNaI=1;
float LimiNaI[FineNaI]={1398};
float LimsNaI[FineNaI]={1564};
const int FineGe=1;
float LimiGe[FineGe]={1451};//1457
float LimsGe[FineGe]={1467};//1473
Gauss *ConstNaI,*ConstGe;
ConstNaI = (Gauss *)malloc(FineNaI*sizeof(Gauss));
ConstGe = (Gauss *)malloc(FineGe*sizeof(Gauss));
Gauss *ConsttNaI,*ConsttGe;
ConsttNaI = (Gauss *)malloc(FineNaI*sizeof(Gauss));
ConsttGe = (Gauss *)malloc(FineGe*sizeof(Gauss));
Gauss *ConsANaI,*ConsAGe;
ConsANaI = (Gauss *)malloc(FineNaI*sizeof(Gauss));
ConsAGe = (Gauss *)malloc(FineGe*sizeof(Gauss));
Gauss *ConsFNaI,*ConsFGe;
ConsFNaI = (Gauss *)malloc(FineNaI*sizeof(Gauss));
ConsFGe = (Gauss *)malloc(FineGe*sizeof(Gauss));
picco->SetLineWidth(1);
for(int i=0;i<FineNaI;i++){
  //  *(ConstNaI+i) = Interpola(LimiNaI[i],LimsNaI[i],IstFunghiNaI);
  *(ConstNaI+i) = Interpola(LimiNaI[i],LimsNaI[i],PulFunghiNaI);
  //  *(ConsttNaI+i) = Interpola(LimiNaI[i],LimsNaI[i],IstIntonacoNaI);
  *(ConsttNaI+i) = Interpola(LimiNaI[i],LimsNaI[i],PulIntonacoNaI);
  //  *(ConsANaI+i) = Interpola(LimiNaI[i],LimsNaI[i],IstMarroniNaI);
  *(ConsANaI+i) = Interpola(LimiNaI[i],LimsNaI[i],PulMarroniNaI);
  *(ConsFNaI+i) = Interpola(LimiNaI[i],LimsNaI[i],PulScatolaNaI);
}
for(int i=0;i<FineGe;i++){
  //  *(ConstGe+i) = Interpola(LimiGe[i],LimsGe[i],IstFunghiGe,fEffGe);
  *(ConstGe+i) = Interpola(LimiGe[i],LimsGe[i],PulFunghiGe);
  //  *(ConsttGe+i) = Interpola(LimiGe[i],LimsGe[i],IstIntonacoGe,fEffGe);
  *(ConsttGe+i) = Interpola(LimiGe[i],LimsGe[i],PulIntonacoGe);
  //  *(ConsAGe+i) = Interpola(LimiGe[i],LimsGe[i],IstMarroniGe,fEffGe);
  *(ConsAGe+i) = Interpola(LimiGe[i],LimsGe[i],PulMarroniGe);
  //  *(ConsAGe+i) = Interpola(LimiGe[i],LimsGe[i],IstMarroniGe,fEffGe);
  *(ConsFGe+i) = Interpola(LimiGe[i],LimsGe[i],PulScatolaGe);
}

Tabella = fopen("PotassioNaI.tex","w");
fprintf(Tabella,"\\begin{tabular}{|c|c|c|c|}\n\
\\hline\n \
\\multirow{2}{*}{Campione} & Attivit\\`a & Energia picco & $\\sigma$ \\\\ \n\
&(\\SI{}{Bq})& (\\SI{}{keV}) &  (\\SI{}{keV})\\\\ \n\
\\hline\n ");
fprintf(Tabella,"%s & %.1f & %.1f & %.1f \\\\ \n\
%s & %.1f & %.1f & %.1f \\\\ \n\
%s & %.1f & %.1f & %.1f \\\\ \n","Funghi",(ConstNaI)->uno,(ConstNaI)->due,(ConstNaI)->tre,"Intonaco",(ConsttNaI)->uno,(ConsttNaI)->due,(ConsttNaI)->tre,"Castagne",(ConsANaI)->uno,(ConsANaI)->due,(ConsANaI)->tre);
fprintf(Tabella,"\\hline\n \
\\end{tabular}\n");
fclose(Tabella);

Tabella = fopen("PotassioGe.tex","w");
fprintf(Tabella,"\\begin{tabular}{|c|c|c|c|}\n\
\\hline\n \
\\multirow{2}{*}{Campione} & Attivit\\`a & Energia picco & $\\sigma$ \\\\ \n\
&(\\SI{}{Bq})& (\\SI{}{keV}) &  (\\SI{}{keV})\\\\ \n\
\\hline\n ");
fprintf(Tabella,"%s & %.1f & %.1f & %.1f \\\\ \n\
%s & %.1f & %.1f & %.1f \\\\ \n\
%s & %.1f & %.1f & %.1f \\\\ \n","Funghi",(ConstGe)->uno,(ConstGe)->due,(ConstGe)->tre,"Intonaco",(ConsttGe)->uno,(ConsttGe)->due,(ConsttGe)->tre,"Castagne",(ConsAGe)->uno,(ConsAGe)->due,(ConsAGe)->tre);
fprintf(Tabella,"\\hline\n \
\\end{tabular}\n");
fclose(Tabella);

/*for(int i=0;i<FineGe;i++){
  fprintf(Tabella,"%d & %.3g&%.3g&%.3g & %.1f&%.1f&%.1f & %.3f&%.3f&%.3f\\\\\n",i,
 (ConstGe+i)->uno,(ConsAGe+i)->uno,(ConsttGe+i)->uno,
(ConstGe+i)->due,(ConsAGe+i)->due,(ConsttGe+i)->due,
(ConstGe+i)->tre,(ConsAGe+i)->tre,(ConsttGe+i)->tre);
}
*/

Tabella = fopen("AttivitaNaI.tex","w");
fprintf(Tabella,"\\begin{tabular}{|c|c|}\n\\hline\n\
%\\multicolumn{2}{|c|}{Attivit\\`a[Bq]}\\\\\n\
Campione & Attivit\\`a (\\SI{}{Bq})\\\\ \n\
\\hline \n\
Funghi   & %.3g\\\\\n\
Intonaco & %.3g\\\\\n\
Castagne & %.3g\\\\\n",PulFunghiNaI->GetSum(),PulIntonacoNaI->GetSum(),PulMarroniNaI->GetSum());
fprintf(Tabella,"\\hline\n \
\\end{tabular}\n");
fclose(Tabella);
Tabella = fopen("AttivitaGe.tex","w");
fprintf(Tabella,"\\begin{tabular}{|c|c|}\n\\hline\n\
%\\multicolumn{2}{|c|}{Attivit\\`a[Bq]}\\\\\n\
Campione & Attivit\\`a (\\SI{}{Bq})\\\\ \n\
\\hline \n\
Funghi   & %.3g\\\\\n\
Intonaco & %.3g\\\\\n\
Castagne & %.3g\\\\\n",PulFunghiGe->GetSum(),PulIntonacoGe->GetSum(),PulMarroniGe->GetSum());
fprintf(Tabella,"\\hline\n \
\\end{tabular}\n");
fclose(Tabella);

float inizio,fine,rappNaI,rappGe;
inizio=10.0;
fine=2100.0;
rappNaI=(nBinNaI/2200.);
  rappGe=(nBinGe/2200.);

Tabella = fopen("Attivita.tex","w");
fprintf(Tabella,"\\begin{tabular}{|c|c|c|}\n\\hline\n\
Campione & Attivit\\`a NaI(Tl) (\\SI{}{Bq}) & Attivit\\`a HPGe (\\SI{}{Bq})\\\\ \n\
\\hline \n\
Funghi   & %.3g & %.3g\\\\\n\
Intonaco & %.3g & %.3g\\\\\n\
Castagne & %.3g & %.3g\\\\\n",PulFunghiNaI->Integral(inizio*rappNaI,fine*rappNaI),PulFunghiGe->Integral(inizio*rappGe,fine*rappGe),PulIntonacoNaI->Integral(inizio*rappNaI,fine*rappNaI),PulIntonacoGe->Integral(inizio*rappGe,fine*rappGe),PulMarroniNaI->Integral(inizio*rappNaI,fine*rappNaI),PulMarroniGe->Integral(inizio*rappGe,fine*rappGe));
fprintf(Tabella,"\\hline\n \
\\end{tabular}\n");
fclose(Tabella);


//(1.248E+9 Y

printf("Xe 'nda` tuto ben!\n");
}
