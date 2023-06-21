TF1 * picco = new TF1("picco","gaus",80,2040);
typedef struct {float uno,due,tre;}Gauss;
Gauss Interpola(float x1,float x2,TH1F *Pulito,TH1F *Pulire,TF1 *Eff){
  Gauss g;
  Pulito->Fit("picco","","",x1,x2);
  g.uno = picco->GetParameter(0)*Pulire->GetBinContent((int)(((x1+x2)/4400.)*(float)Pulire->GetNbinsX()))/Eff->Eval((x1+x2)/2.);
  g.due = picco->GetParameter(1);
  g.tre = picco->GetParameter(2);
  return g;
}
Gauss Interpola(float x1,float x2,TH1F *Pulito,TF1 *Eval){
  Gauss g;
  Pulito->Fit("picco","","",x1,x2);
  g.uno = picco->GetParameter(0)/Eff->Eval((x1+x2)/2.);
  g.due = picco->GetParameter(1);
  g.tre = picco->GetParameter(2);
  return g;
}
Gauss Interpola(float x1,float x2,TH1F *Pulito){
  Gauss g;
  Pulito->Fit("picco","","",x1,x2);
  g.uno = picco->GetParameter(0);
  g.due = picco->GetParameter(1);
  g.tre = picco->GetParameter(2);
  return g;
}
