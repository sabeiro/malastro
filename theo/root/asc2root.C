#include "Riostream.h"

void asctoroot(char* nome_asc, char* nome_root, char* nome, Float_t secondi)
{
   ifstream in;

   in.open(nome_asc);

   Float_t x,y;
   Int_t nlines = 0;
   TFile *f = new TFile(nome_root,"RECREATE");
   TH1F *h1 = new TH1F(nome,"x distribution",4096,0,4096);

   while (1) {
     in >> x >> y;
     if (!in.good()) break;
     h1->Fill(x,y);
     nlines++;
   }
/* h1->Scale(1.0/secondi);*/
   in.close();
   f->Write();
}
