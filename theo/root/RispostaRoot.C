{
gROOT->Reset();
TCanvas *finestra = new TCanvas("finestra","finestra",1);
finestra->Divide(2,2); // Divide la finestra in 4
finestra->SetFillColor(0);
finestra->cd(1);
finestra->GetPad(1)->SetFillColor(0);
finestra->GetPad(2)->SetFillColor(0);
finestra->GetPad(3)->SetFillColor(0);
finestra->GetPad(4)->SetFillColor(0);
int nBinNaI = 1100;
int nBinGe  = 1100;
float NaIZero = /*-27.0267;*/-27.049;
float NaIFine = /*2240.95;*/2216.94;
float GeZero = /*-0.24;*/0.0067;
float GeFine = /*2207.27;*/2209.325;
float RapGe = 0.3787;
float RapNaI = 0.00113;
float RapAut= 0.000882266;
float PicchiNaI[]={60,519,1272};
float EffiNaI[]={0.00028137,0.00027654,0.000079166};
float PicchiGe[] = {59.540,121.78,244.76,344.27,411.34,443.96,778.90,867.37,964.07,1085.9,1112.1,1408.0};
float EffiGe[] ={.00067888,.00086519,.00098536,.00071659,.00069620,.00059794,.00025551,.00024940,.00018641,.00014545,.00014499,.000096698};
//Crea l'istogramma con i tre picchi di calibrazione in efficienza per NaI
TH1F *EffNaI = new TH1F("EffNaI","EffNaI",2200,0,2200);
for(int i=0;i<3;i++)EffNaI->Fill(PicchiNaI[i],EffiNaI[i]);
//Fa il fit con landau della curva di efficienza di NaI
TF1 * fEffNaI = new TF1("fEffNaI","landau",0,2200);
fEffNaI->SetLineWidth(1);
EffNaI->Fit("fEffNaI","R");
//Crea un istogramma con i valori del fit per l'efficienza di NaI
TH1F *EfficienzaNaI = new TH1F("EfficienzaNaI","EfficienzaNaI",nBinNaI,0,2200);
for(int i=0;i<nBinNaI;i++){
  EfficienzaNaI->Fill(((float)i+0.1)/((float)nBinNaI)*2200.,fEffNaI->Eval(((float)i+0.1)/((float)nBinNaI)*2200.));
}
EfficienzaNaI->SetLineWidth(1);
EfficienzaNaI->GetXaxis()->Set(nBinNaI,NaIZero,NaIFine);

//Crea l'istogramma con i tre picchi di calibrazione in efficienza per il Ge
TH1F *EffGe = new TH1F("EffGe","EffGe",2200,0,2200);
for(int i=0;i<12;i++)EffGe->Fill(PicchiGe[i],EffiGe[i]);
//Fa il fit con landau della curva di efficienza di Ge
TF1 * fEffGe = new TF1("fEffGe","landau",0,2200);
fEffGe->SetLineWidth(1);
EffGe->Fit("fEffGe","R");
//Crea un istogramma con i valori del fit per l'efficienza di Ge
TH1F * EfficienzaGe = new TH1F("EfficienzaGe","EfficienzaGe",nBinGe,0,2200);
for(int i=0;i<nBinGe;i++){
  EfficienzaGe->Fill(((float)i+0.1)/((float)nBinGe)*2200.,fEffGe->Eval(((float)i+0.1)/((float)nBinGe)*2200.));
}
EfficienzaGe->SetLineWidth(1);
EfficienzaGe->GetXaxis()->Set(nBinGe,GeZero,GeFine);
// Carica i dati del Fondo (canister vuoto)
TFile * file = new TFile("RadonFondo.root","r");
TH1F * IstFondoNaI = new TH1F("IstFondoNaI","IstFondoNaI",nBinNaI,0,2200);
pjmca->Draw("ch2>>IstFondoNaI");
//IstFondoNaI= &IstooNaI;
IstFondoNaI->SetLineColor(2);
IstFondoNaI->Scale(1./1956.4); // Normalizza
IstFondoNaI->GetXaxis()->Set(nBinNaI,NaIZero,NaIFine);
IstFondoNaI->GetXaxis()->SetRange(10,nBinNaI);
TH1F * IstFondoGe = new TH1F("IstFondoGe","IstFondoGe",nBinGe,0,2200);
finestra->cd(3);
pjmca->Draw("ch3>>IstFondoGe");
//IstFondoGe= &IstooGe;
IstFondoGe->SetLineColor(2);
IstFondoGe->Scale(1./1956.4); // Normalizza
IstFondoGe->GetXaxis()->Set(nBinGe,GeZero,GeFine);
IstFondoGe->GetXaxis()->SetRange(10,nBinGe);
finestra->cd(1);
IstFondoNaI->Draw();
finestra->cd(3);
IstFondoGe->Draw();
// Crea le curve per interpolare il fondo
TF1 * fFondoNaI = new TF1("fFondoNaI","landau",55,1900);
fFondoNaI->SetLineWidth(1);
TF1 * fFondoGe = new TF1("fFondoGe","landau",55,1900);
fFondoGe->SetLineWidth(1);
// Interpolazione del fondo
IstFondoNaI->Fit("fFondoNaI","R");
IstFondoGe->Fit("fFondoGe","R");
// Carica i dati dello sgabuzzino
TFile * file = new TFile("RadonSgabuzzino.root","r");
finestra->cd(1);
TH1F * IstSgabuzNaI = new TH1F("IstSgabuzNaI","IstSgabuzNaI",nBinNaI,0,2200);
TH1F * IstSgabuzGe = new TH1F("IstSgabuzGe","IstSgabuzGe",nBinGe,0,2200);
pjmca->Draw("ch2>>IstSgabuzNaI");
//IstSgabuzNaI= &IstooNaI;
IstSgabuzNaI->SetLineColor(4);
IstSgabuzNaI->Scale(1./1800.5);
IstSgabuzNaI->GetXaxis()->Set(nBinNaI,NaIZero,NaIFine);
IstSgabuzNaI->GetXaxis()->SetRange(10,nBinNaI);
IstFondoNaI->Draw("same");
finestra->cd(3);
pjmca->Draw("ch3>>IstSgabuzGe");
//IstSgabuzGe= &IstooGe;
IstSgabuzGe->SetLineColor(4);
IstSgabuzGe->Scale(1./1800.);
IstSgabuzGe->GetXaxis()->Set(nBinGe,GeZero,GeFine);
IstSgabuzGe->GetXaxis()->SetRange(10,nBinGe);
IstFondoGe->Draw("same");
// Crea l'istogramma con cui pulire gli spettri con la funzione di interpolazione del fondo
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
// Carica i dati della sorgente
TFile * file = new TFile("Radon105.root","r");
TH1F * IstSorgenteNaI = new TH1F("IstSorgenteNaI","IstSorgenteNaI",nBinNaI,0,2200);
TH1F * IstSorgenteGe = new TH1F("IstSorgenteGe","IstSorgenteGe",nBinGe,0,2200);
finestra->cd(1);
pjmca->Draw("ch2>>IstSorgenteNaI");
//IstSgabuzNaI= &IstSorgenteNaI;
IstSorgenteNaI->SetLineColor(6);
IstSorgenteNaI->Scale(1./1801.5);
IstSorgenteNaI->GetXaxis()->Set(nBinNaI,NaIZero,NaIFine);
IstSorgenteNaI->GetXaxis()->SetRange(10,nBinNaI);
finestra->cd(3);
pjmca->Draw("ch3>>IstSorgenteGe");
//IstSgabuzGe= &IstSorgenteGe;
IstSorgenteGe->SetLineColor(6);
IstSorgenteGe->Scale(1./1801.);
IstSorgenteGe->GetXaxis()->Set(nBinGe,GeZero,GeFine);
IstSorgenteGe->GetXaxis()->SetRange(10,nBinGe);
// Carica i dati dell'autunnite
TFile * file = new TFile("Autunnite.root","r");
TH1F * IstAutunNaI = new TH1F("IstAutunNaI","IstAutunNaI",nBinNaI,0,2200);
TH1F * IstAutunGe = new TH1F("IstAutunGe","IstAutunGe",nBinGe,0,2200);
finestra->cd(1);
pjmca->Draw("ch2>>IstAutunNaI");
//IstSgabuzNaI= &IstSorgenteNaI;
IstAutunNaI->SetLineColor(3);
IstAutunNaI->Scale(1./1801.);
IstAutunNaI->GetXaxis()->Set(nBinNaI,NaIZero,NaIFine);
IstAutunNaI->GetXaxis()->SetRange(10,nBinNaI);
IstFondoNaI->Draw("same");
IstSgabuzNaI->Draw("same");
IstSorgenteNaI->Draw("same");
finestra->cd(3);
pjmca->Draw("ch3>>IstAutunGe");
//IstSgabuzGe= &IstSorgenteGe;
IstAutunGe->SetLineColor(3);
IstAutunGe->Scale(1./1801.);
IstAutunGe->GetXaxis()->Set(nBinGe,GeZero,GeFine);
IstAutunGe->GetXaxis()->SetRange(10,nBinGe);
IstFondoGe->Draw("same");
IstSgabuzGe->Draw("same");
IstSorgenteGe->Draw("same");
TH1F * PulFondoNaI = new TH1F("PulFondoNaI","PulFondoNaI",nBinNaI,0,nBinNaI);
TH1F * PulFondoGe = new TH1F("PulFondoGe","PulFondoGe",nBinGe,0,nBinGe);
TH1F * PulSgabuzNaI = new TH1F("PulSgabuzNaI","PulSgabuzNaI",nBinNaI,0,nBinNaI);
TH1F * PulSgabuzGe = new TH1F("PulSgabuzGe","PulSgabuzGe",nBinGe,0,nBinGe);
TH1F * PulSorgenteNaI = new TH1F("PulSorgenteNaI","PulSorgenteNaI",nBinNaI,0,nBinNaI);
TH1F * PulSorgenteGe = new TH1F("PulSorgenteGe","PulSorgenteGe",nBinGe,0,nBinGe);
TH1F * PulAutunNaI = new TH1F("PulAutunNaI","PulAutunNaI",nBinNaI,0,nBinNaI);
TH1F * PulAutunGe = new TH1F("PulAutunGe","PulAutunGe",nBinGe,0,nBinGe);
for(int i=1,j=1;i<nBinNaI;i++){
  PulFondoNaI->Fill(i,((IstFondoNaI->GetBinContent(i)-PulireNaI->GetBinContent(i))/EfficienzaNaI->GetBinContent(i))*RapNaI);
  PulSgabuzNaI->Fill(i,((IstSgabuzNaI->GetBinContent(i)-PulireNaI->GetBinContent(i))/EfficienzaNaI->GetBinContent(i))*RapNaI);
  PulSorgenteNaI->Fill(i,((IstSorgenteNaI->GetBinContent(i)-PulireNaI->GetBinContent(i))/EfficienzaNaI->GetBinContent(i))*RapNaI);
  PulAutunNaI->Fill(i,((IstAutunNaI->GetBinContent(i)-PulireNaI->GetBinContent(i))/EfficienzaNaI->GetBinContent(i))*RapAut);
  if(i%(nBinNaI/100)==0)j++;
}
finestra->cd(2);
PulFondoNaI->SetLineColor(2);
PulFondoNaI->GetXaxis()->Set(nBinNaI,NaIZero,NaIFine);
PulFondoNaI->GetXaxis()->SetRange(10,nBinNaI);
PulSgabuzNaI->SetLineColor(4);
PulSgabuzNaI->GetXaxis()->Set(nBinNaI,NaIZero,NaIFine);
PulSgabuzNaI->GetXaxis()->SetRange(10,nBinNaI);
PulSorgenteNaI->SetLineColor(6);
PulSorgenteNaI->GetXaxis()->Set(nBinNaI,NaIZero,NaIFine);
PulSorgenteNaI->GetXaxis()->SetRange(10,nBinNaI);
PulAutunNaI->SetLineColor(3);
PulAutunNaI->GetXaxis()->Set(nBinNaI,NaIZero,NaIFine);
PulAutunNaI->GetXaxis()->SetRange(10,nBinNaI);
PulSgabuzNaI->Draw();
PulSorgenteNaI->Draw("same");
PulAutunNaI->Draw("same");
PulFondoNaI->Draw("same");
for(int i=1,j=1;i<nBinGe;i++){
  PulFondoGe->Fill(i,((IstFondoGe->GetBinContent(i)-PulireGe->GetBinContent(i))/EfficienzaGe->GetBinContent(i))*RapGe);
  PulSgabuzGe->Fill(i,((IstSgabuzGe->GetBinContent(i)-PulireGe->GetBinContent(i))/EfficienzaGe->GetBinContent(i))*RapGe);
  PulSorgenteGe->Fill(i,((IstSorgenteGe->GetBinContent(i)-PulireGe->GetBinContent(i))/EfficienzaGe->GetBinContent(i))*RapGe);
  PulAutunGe->Fill(i,((IstAutunGe->GetBinContent(i)-PulireGe->GetBinContent(i))/EfficienzaGe->GetBinContent(i))*RapGe);
  if(i%(nBinGe/100)==0){
    j++;
  }
}
finestra->cd(4);
PulFondoGe->SetLineColor(2);
PulFondoGe->GetXaxis()->Set(nBinNaI,NaIZero,NaIFine);
PulFondoNaI->GetXaxis()->SetRange(10,nBinNaI);
PulSgabuzGe->SetLineColor(4);
PulSgabuzGe->GetXaxis()->Set(nBinGe,GeZero,GeFine);
PulSgabuzGe->GetXaxis()->SetRange(10,nBinGe);
PulSorgenteGe->SetLineColor(6);
PulSorgenteGe->GetXaxis()->Set(nBinGe,GeZero,GeFine);
PulSorgenteGe->GetXaxis()->SetRange(10,nBinGe);
PulAutunGe->SetLineColor(3);
PulAutunGe->GetXaxis()->Set(nBinGe,GeZero,GeFine);
PulAutunGe->GetXaxis()->SetRange(10,nBinGe);
PulSgabuzGe->Draw();
PulSorgenteGe->Draw("same");
PulAutunGe->Draw("same");
PulFondoGe->Draw("same");
TCanvas *Nuova = new TCanvas("Nuova","Nuova",2);
Nuova->cd(1);
const int FineNaI=9;
float LimiNaI[FineNaI]={53,214,263,315,563,1045,1183,1304,1650};
float LimsNaI[FineNaI]={83,250,313,375,653,1175,1296,1435,1834};
const int FineGe=14;
float LimiGe[FineGe]={70,241,291,346,607,766,760,929,1112,1238,1374,1460,1729,1762};
float LimsGe[FineGe]={82,248,302,358,617,775,776,945,1129,1246,1389,1470,1738,1775};
Gauss *ConstSgabuzNaI,*ConstSgabuzGe;
ConstSgabuzNaI = (Gauss *)malloc(FineNaI*sizeof(Gauss));
ConstSgabuzGe = (Gauss *)malloc(FineGe*sizeof(Gauss));
Gauss *ConstSorgenteNaI,*ConstSorgenteGe;
ConstSorgenteNaI = (Gauss *)malloc(FineNaI*sizeof(Gauss));
ConstSorgenteGe = (Gauss *)malloc(FineGe*sizeof(Gauss));
Gauss *ConstAutunNaI,*ConstAutunGe;
ConstAutunNaI = (Gauss *)malloc(FineNaI*sizeof(Gauss));
ConstAutunGe = (Gauss *)malloc(FineGe*sizeof(Gauss));
picco->SetLineWidth(1);
for(int i=0;i<FineNaI;i++){
  //  *(ConstSgabuzNaI+i) = Interpola(LimiNaI[i],LimsNaI[i],IstSgabuzNaI);
  *(ConstSgabuzNaI+i) = Interpola(LimiNaI[i],LimsNaI[i],PulSgabuzNaI);
  //  *(ConstSorgenteNaI+i) = Interpola(LimiNaI[i],LimsNaI[i],IstSorgenteNaI);
  *(ConstSorgenteNaI+i) = Interpola(LimiNaI[i],LimsNaI[i],PulSorgenteNaI);
  //  *(ConstAutunNaI+i) = Interpola(LimiNaI[i],LimsNaI[i],IstAutunNaI);
  *(ConstAutunNaI+i) = Interpola(LimiNaI[i],LimsNaI[i],PulAutunNaI);
}
for(int i=0;i<FineGe;i++){
  //  *(ConstSgabuzGe+i) = Interpola(LimiGe[i],LimsGe[i],IstSgabuzGe);
  *(ConstSgabuzGe+i) = Interpola(LimiGe[i],LimsGe[i],PulSgabuzGe);
  //  *(ConstSorgenteGe+i) = Interpola(LimiGe[i],LimsGe[i],IstSorgenteGe);
  *(ConstSorgenteGe+i) = Interpola(LimiGe[i],LimsGe[i],PulSorgenteGe);
  //  *(ConstAutunGe+i) = Interpola(LimiGe[i],LimsGe[i],IstAutunGe);
  *(ConstAutunGe+i) = Interpola(LimiGe[i],LimsGe[i],PulAutunGe);
}
float RisSgNaI,RisANaI;
float RisSgGe,RisAGe;
float inizio,fine,inizNaI,finNaI,inizGe,finGe;
inizio=140.0;
fine=2200.0;
inizNaI=(nBinNaI/2200.0)*inizio;
finNaI=(nBinNaI/2200.0)*fine;
inizGe=(nBinGe/2200.0)*inizio;
finGe=(nBinGe/2200.0)*fine;

//RisSgNaI=(IstSgabuzNaI->GetSum()-IstFondoNaI->GetSum())/(1*(IstSorgenteNaI->GetSum()-IstFondoNaI->GetSum())*7.2*2855);
//RisSgGe=(IstSgabuzGe->GetSum()-IstFondoGe->GetSum())/(1*(IstSorgenteGe->GetSum()-IstFondoGe->GetSum())*7.2*2855);
RisSgNaI=370*1000*( IstSgabuzNaI->Integral((int)(inizNaI),(int)(finNaI)) - IstFondoNaI->Integral((int)(inizNaI) , (int)(finNaI)) ) / ((IstSorgenteNaI->Integral((int)(inizNaI),(int)(finNaI))-IstFondoNaI->Integral((int)(inizNaI),(int)(finNaI)))*0.073*2855*0.828);
RisSgGe=370*1000*(IstSgabuzGe->Integral((int)(inizGe),(int)(finGe))-IstFondoGe->Integral((int)(inizGe),(int)(finGe)))/((IstSorgenteGe->Integral((int)(inizGe),(int)(finGe))-IstFondoGe->Integral((int)(inizGe),(int)(finGe)))*0.073*2855*0.828);
/*RisSgNaI=370*1000*(IstSgabuzNaI->Integral((int)((10./2200.)*nBinNaI),nBinNaI)-IstFondoNaI->Integral((int)((10./2200.)*nBinNaI),nBinNaI))/((IstSorgenteNaI->Integral((int)((10./2200.)*nBinNaI),nBinNaI)-IstFondoNaI->Integral((int)((10./2200.)*nBinNaI),nBinNaI))*0.073*2855*0.828);
RisSgGe=370*1000*(IstSgabuzGe->Integral((int)((10./2200.)*nBinGe),nBinGe)-IstFondoGe->Integral((int)((10./2200.)*nBinGe),nBinGe))/((IstSorgenteGe->Integral((int)((10./2200.)*nBinGe),nBinGe)-IstFondoGe->Integral((int)((10./2200.)*nBinGe),nBinGe))*0.073*2855*0.828);
*/


Tabella = fopen("ConcentrazioneNaI.tex","w");
fprintf(Tabella,"\\begin{tabular}{|c|c|c|c|c|c|c|}\n\
\\hline\n \
\\multicolumn{7}{|c|}{NaI(TL)}\\\\ \n\
\\hline\n \
\\multirow{3}{*}{Picco}&\\multicolumn{2}{|c|}{Sgabuzzino}&\\multicolumn{2}{|c|}{Campione}&\\multicolumn{2}{|c|}{Autunnite}\\\\\n\
\\cline{2-7}\n\
& Energia & Integrale  & Energia & Integrale & Energia & Integrale \\\\ \n\
& (\\SI{}{keV}) & (\\SI{}{Conteggi/s}) &(\\SI{}{keV})&(\\SI{}{Conteggi/s}) &(\\SI{}{keV})&(\\SI{}{Conteggi/s}) \\\\ \n\
\\hline  ");
for(int i=0;i<FineNaI;i++){
  fprintf(Tabella,"%d & $%.1f \\pm %.1f$ & %.3f & $%.1f \\pm %.1f$ & %.3f & $%.1f \\pm %.1f$ & %.3f\\\\\n",i+1,(ConstSgabuzNaI+i)->due,(ConstSgabuzNaI+i)->tre,(ConstSgabuzNaI+i)->uno,(ConstSorgenteNaI+i)->due,(ConstSorgenteNaI+i)->tre,(ConstSorgenteNaI+i)->uno,(ConstAutunNaI+i)->due,(ConstAutunNaI+i)->tre,(ConstAutunNaI+i)->uno);
}
fprintf(Tabella,"\\hline\n \
\\end{tabular}\n");
fclose(Tabella);

Tabella = fopen("ConcentrazioneGe.tex","w");
fprintf(Tabella,"\\begin{tabular}{|c|c|c|c|c|c|c|}\n\
\\hline\n \
\\multicolumn{7}{|c|}{HPGe}\\\\ \n\
\\hline\n \
\\multirow{3}{*}{Picco}&\\multicolumn{2}{|c|}{Sgabuzzino}&\\multicolumn{2}{|c|}{Campione}&\\multicolumn{2}{|c|}{Autunnite}\\\\\n\
\\cline{2-7}\n\
& Energia & Integrale  & Energia & Integrale & Energia & Integrale \\\\ \n\
& (\\SI{}{keV}) & (\\SI{}{Conteggi/s}) &(\\SI{}{keV})&(\\SI{}{Conteggi/s}) &(\\SI{}{keV})&(\\SI{}{Conteggi/s}) \\\\ \n\
\\hline  ");
for(int i=0;i<FineGe;i++){
  fprintf(Tabella,"%d & $%.1f \\pm %.1f$ & %.3f & $%.1f \\pm %.1f$ & %.3f & $%.1f \\pm %.1f$ & %.3f\\\\\n",i+1,(ConstSgabuzGe+i)->due,(ConstSgabuzGe+i)->tre,(ConstSgabuzGe+i)->uno,(ConstSorgenteGe+i)->due,(ConstSorgenteGe+i)->tre,(ConstSorgenteGe+i)->uno,(ConstAutunGe+i)->due,(ConstAutunGe+i)->tre,(ConstAutunGe+i)->uno);
}
fprintf(Tabella,"\\hline\n \
\\end{tabular}\n");
fclose(Tabella);

Tabella = fopen("AttRn.tex","w");
fprintf(Tabella,"\\begin{tabular}{|c|c|}\n\
\\hline\n \
Rivelatore & Attivit\\`a (\\SI{}{Bq/m^3}) \\\\ \n\
\\hline\n \
NaI(Tl) & \\num{%.0f} \\\\ \n\
HPGe    & \\num{%.0f} \\\\ \n\
\\hline\n\
\\end{tabular}\n",RisSgNaI,RisSgGe);
fclose(Tabella);

/*
Tabella = fopen("ConcentrazioneGe.tex","w");
fprintf(Tabella,"\\begin{tabular}{|c|c @{-} c @{-} c|c @{-} c @{-} c|c @{-} c @{-} c|}\n\
\\hline\n \
\\multicolumn{10}{|c|}{HPGe}\\\\ \n\
\\hline\n \
&\\multicolumn{3}{|c|}{Costante \\SI{}{Bq}}&\\multicolumn{3}{|c|}{Centroide \\SI{}{keV}}&\\multicolumn{3}{|c|}{$\\sigma$ \\SI{}{keV}}\\\\\n\\hline\n");
for(int i=0;i<FineNaI;i++){
  fprintf(Tabella,"%d & %.3f&%.3f&%.3f & %.1f&%.1f&%.1f & %.3f&%.3f&%.3f\\\\\n",i,(ConstSgabuzGe+i)->uno,(ConstAutunGe+i)->uno,(ConstSorgenteGe+i)->uno,(ConstSgabuzGe+i)->due,(ConstAutunGe+i)->due,(ConstSorgenteGe+i)->due,(ConstSgabuzGe+i)->tre,(ConstAutunGe+i)->tre,(ConstSorgenteGe+i)->tre);
}
fprintf(Tabella,"&Campione&Riferimento&Autunnite&Campione&Riferimento&Autunnite&Campione&Riferimento&Autunnite\\\\\n");
fprintf(Tabella,"\\hline\n \
\\multicolumn{10}{|c|}{$RN_{Ge}$ %.4g}\\\\\n\\hline\n \
\\end{tabular}\n",RisSgGe);
fclose(Tabella);
*/
printf("Te ve be te `e!\n");
}
