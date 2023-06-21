clear
EtNaI = ["$^{22}$Na";"$^{22}$Na";"$^{241}$Am"];
NaIPicco=[511,1275,59.54];
NaICh=[553.68,1333.14,71.67];
ErrNaICh=[39.35,79.10,11.59];
NaIInt=[1636.2,234.2,62374];
ErrNaIInt=[27.5,7.7,278];
Na511=1;Na1275=2;Am59=3;

NaICh2=[527.5,1276.52,1448.9];
NaICh3=[521.9,1263.0];
GeCh2=[509.9,1270.2,1464.8];
GeCh3=[509.5,1270.9];
Picco2=[511,1275,1460];

#EtGe = ["$^{22}$Na";"$^{22}$Na";"$^{241}$Am";"$^{152}$Eu";"$^{152}$Eu";"$^{152}$Eu";"$^{152}$Eu";"$^{152}$Eu";"$^{152}$Eu";"$^{152}$Eu";"$^{152}$Eu"];
#GePicco = [511,1275,59.54,121.8,244.7,344.3,778.9,964.1,1086,1112,1408];
#GeCh=[538.21,1345,58.2,118.5,250,362,824,1021,1137.8,1173.2,1484.5];
#ErrGeCh =[8.40,9.68,2.3,13.4,11.4,18.4,14.8,13.63,16.7,14.46,7.7];
#GeInt=[801.3,1877.9,136421,369474,93106,142350,39943,29888,18675,27679,27694];
#ErrGeInt=[9.05,65.4,2820,613,304,377,200,173,5549,168.2,168];
#GeAtt=[1,1,1,0.122,0.076,0.266,0.130,0.146,0.102,0.137,0.211];
EtGe = ["$^{22}$Na";"$^{22}$Na";"$^{241}$Am"];
for i= 1:30
  EtGe = [EtGe;"$^{152}$Eu"];
endfor;
GePicco=[511,1275,59.54,121.784,244.758,295.939,344.273,367.789,411.344,443.965,488.679,503.474,564.499,586.265,656.487,677.569,688.67,719.349,778.904,810.451,841.57,867.373,919.33,926.317,964.073,1005.272,1085.869,1112.069,1212.948,1292.778,1408.006,1457.643,1528.103];
GeAtt=[200*0.99944,100*0.99944,100*0.852,62.233,8.504,0.455,27.638,0.87,2.401,3.18,0.426,0.151,0.626,0.471,0.1535,0.648,0.896,0.34,12.98,0.322,0.167,4.27,0.429,0.279,14.825,0.649,10.26,13.71,1.426,0.106,21.08,0.503,0.282];
GeCh=[538.74,1342.82,62.45,127.769,257.008,310.712,361.762,386.385,432.037,466.417,514.442,529.943,594.574,617.456,691.774,713.790,725.028,757.591,820.005,852.566,885.169,912.829,967.102,974.894,1014.23,1057.27,1143.02,1170.13,1276.21,1366.92,1481.29,1533.38,1607.95];
ErrGeCh=[1.70,1.481,1.09,1.066,1.353,3.56,1.230,2.319,1.583,1.636,4.283,4.25,4.352,3.221,5.36,6.324,3.093,6.872,1.919,6.70,7.83,2.588,4.79,5.4,2.04,3.55,2.87,2.37,3.42,3.37,2.48,3.23,3.08];
#GeInt =   [1825.91,519.30, 181875, 110097,  17344.1, 1993.11,40763.1,1977.02,3288.31,3573.85,969.331,823.213,995.785,1010.69,733.846,793.210,929.763,789.735,7189.92,655.458,612.838,2298.95,525.208,463.895,5732.23,496.149,3060.30,4076.54,455.599,396.843,4217.45,101.656,62.247];

GeInt=[1808.98,517.77,181637,111682,17380.8,1993.11,41080.2,2031.04,3467.21,3943.99,1072.02,830.904,1145.30,1085.93,733.846,882.867,1099.75,801.946,6879.04,658.954,611.357,2208.95,534.833,468.817,5732.23,531.479,3095.35,4123.14,503.707,397.431,4228.06,100.380,60.8935];
GeIntErr=[26.27,15.44,329.65,265.488,101.148,29.3713,150.275,30.5827,41.4075,43.8069,21.4856,23.177,20.0903,23.3386,16.4555,18.6224,19.1401,16.5279,51.8386,13.0914,12.4074,26.1628,13.0111,11.903,43.0346,12.3957,28.2787,34.0656,10.9984,9.51445,30.7422,4.85651,3.61061];
GeIntErrRel=GeIntErr ./ GeInt;

AmbCh =  [1539.02, 643.270, 616.113, 369.350, 310.095, 97.0080, 90.1610, 78.2436];
ErrAmb = [1.63090, 2.31809, 3.37384, 2.85163, 2.95286, 4.24904, 3.15305, 2.30125];
IntAmb = [22.3395, 9.73276, 9.92755, 15.9853, 17.0567, 44.1422, 53.5999, 87.8497];

Etichet=["NaI(Tl)";"HPGe"];
#Piombo 242,295,352,
#Bismuto 609,1120,768
#Cesio 137 beta- 661.657 94.6%
#Cesio 134 
#611.02\\pm0.97
Etichet=["NaI(Tl)";"HPGe"];

EtiNaI=["Fondo";"Fondo";"Fondo";"Fondo";"Funghi";"Funghi";"Intonaco";"Intonaco";"Intonaco";"Intonaco";"Intonaco";"Castagne";"Castagne";"Castagne"];
OrigineNaI=["$\\beta^+$";"$^{214}$Bi";"-";"$^{40}$K";"$^{137}$Cs";"$^{40}$K";"$^214$Pb";"$^214$Pb";"$^{214}$Bi";"$^{214}$Bi";"$^{40}$K";"$^{214}$Bi";"$^{214}$Bi";"$^{40}$K"];
SpNaI    = [510.148,606.7,975,1463,663,1477,229,342,600,1128,1467,596,1123,1473];
ErrSpNaI = [13.30,10.7,4.7,32,20.9,20.8,15.0,20.1,26.9,21.5,28.11,35.6,12.5,21.0];
ContNaI =  [79.65,98.5,33.3,177.8,0.1104,0.24,0.193,0.084,0.074,0.0063,0.025,0.122,0.11,0.64];
ErrContNaI=[9.4,9.8,4.4,5.4,0.125,0.16,0.249,0.13,0.0095,0.12,0.16,0.177,0.15,0.27];
MassaNaI=[1*(1:4),0.051*(1:2)./(1:2),0.322*(1:5)./(1:5),0.2822*(1:3)./(1:3)];

EtiGe=["Fondo";"Fondo";"Fondo";"Fondo";"Funghi";"Funghi";"Funghi";"Funghi";"Funghi";"Funghi";"Intonaco";"Intonaco";"Intonaco";"Intonaco";"Intonaco";"Intonaco";"Castagne";"Castagne";"Castagne";"Castagne"];
OrigineGe=["$\\beta^+$";"$^{214}$Bi";"-";"$^{40}$K";"$^{214}$Bi";"$^{214}$Pb";"$\\beta^+$";"$^{214}$Bi";"$^{135}$Cs";"$^{40}$K";"$^{214}$Pb";"$^{214}$Pb";"$^{214}$Bi";"-";"$^{214}$Bi";"$^{40}$K";"$^{214}$Pb";"-";"-";"$^{40}$K"];
SpGe= [512.8,610.9,911.8,1456.9,611.02,356,515,613,665,1459,242,354,612,912,1120,1459,242.9,910,1238,1458];
ErrSpGe =[2.0,1.1,1.9,1.5,0.97,2.77,1.69,2.23,2.29,3.1,2.24,1.61,1.72,2.13,5.00,2.11,0.47,3.52,2.25,1.21];
ContGe =[14.8,26.1,12.1,216,13.9,1.23,6.30,5.58,8.83,5.54,7.93,7.19,9.92,11.8,10.20,115.9,36.2,6.31,1.61,143.8];
ErrContGe=[2.9,5,3.7,14,3.58,0.746,2.35,1.62,2.34,5.28,2.20,3.23,2.93,2.96,1.58,7.46,207,1.76,3.0,12.0];
MassaGe=[1*(1:4),0.051*(1:6)./(1:6),0.322*(1:6)./(1:6),0.2822*(1:4)./(1:4)];

Tabella = fopen("FondoNaI.tex","w");
fprintf(Tabella,"\\begin{tabular}{|c|c|c|c|c|c|}\n\
\\hline\n\
\\multicolumn{6}{|c|}{NaI(Tl)}\\\\ \n \
\\hline\n\
\\multirow{2}{*}{Campione}&Centroide & $\\sigma$ & Int & ErrInt & Origine\\\\ \n\
&(\\SI{}{keV}) & (\\SI{}{keV}) & (\\SI{}{Cont/s})& (\\SI{}{Cont/s})&\\\\ \n\
\\hline\n");
for i=1:4;
  fprintf(Tabella,"%s & \\num{%1.2f} & \\num{%1.3f} & \\num{%1.3f} & \
  \\num{%1.3f} & %s\\\\ \n",EtiNaI(i,1:columns(EtiNaI)),SpNaI(i),ErrSpNaI(i),ContNaI(i),ErrContNaI(i),OrigineNaI(i,1:columns(OrigineNaI)));
endfor
fprintf(Tabella,"\\hline\n\
\\end{tabular}");
fclose(Tabella);
Tabella = fopen("FondoGe.tex","w");
fprintf(Tabella,"\\begin{tabular}{|c|c|c|c|c|c|}\n\
\\hline\n\
\\multicolumn{6}{|c|}{HPGe}\\\\ \n \
\\hline\n\
\\multirow{2}{*}{Campione}&Centroide & $\\sigma$ & Int & ErrInt & Origine\\\\ \n\
&(\\SI{}{keV}) & (\\SI{}{keV}) & (\\SI{}{Cont/s})& (\\SI{}{Cont/s})&\\\\ \n\
\\hline\n");
for i=1:4;
  fprintf(Tabella,"%s & \\num{%1.2f} & \\num{%1.3f} & \\num{%1.3f} & \
  \\num{%1.3f} & %s\\\\ \n",EtiGe(i,1:columns(EtiGe)),SpGe(i),ErrSpGe(i),ContGe(i),ErrContGe(i),OrigineGe(i,1:columns(OrigineGe)));
endfor
fprintf(Tabella,"\\hline\n\
\\end{tabular}");
fclose(Tabella);

Tabella = fopen("RigheNaI.tex","w");
fprintf(Tabella,"\\begin{longtable}{|c|c|c|c|c|}\n\
\\hline\n\
\\multicolumn{5}{|c|}{NaI(Tl)}\\\\ \n \
\\hline\n\
\\multirow{2}{*}{Campione}&Centroide & Integrale & \\multirow{2}{*}{Origine} & \\multirow{2}{*}{Attivit\\`a} \\\\ \n\
&(\\SI{}{keV})  & (\\SI{}{Cont/s})&&\\\\ \n\
\\hline\n\
\\endhead \n\
\\hline \n\
\\endfoot \n");
for i=5:length(SpNaI);
  fprintf(Tabella,"%s & $\\num{%1.0f} \\pm \\num{%1.0f}$ & $\\num{%1.3f} \\pm \\num{%1.3f}$ & %s & %.3f\\\\ \n"
	  ,EtiNaI(i,1:columns(EtiNaI)),SpNaI(i),ErrSpNaI(i),ContNaI(i),ErrContNaI(i),OrigineNaI(i,1:columns(OrigineNaI)),ContNaI(i)/MassaNaI(i));
endfor
fprintf(Tabella,"\\end{longtable}");
fclose(Tabella);

Tabella = fopen("RigheGe.tex","w");
fprintf(Tabella,"\\begin{longtable}{|c|c|c|c|c|}\n\
\\hline\n\
\\multicolumn{5}{|c|}{HPGe}\\\\ \n \
\\hline\n\
\\multirow{2}{*}{Campione}&Centroide & Integrale & \\multirow{2}{*}{Origine} & \\multirow{2}{*}{Attivit\\`a} \\\\ \n\
&(\\SI{}{keV})  & (\\SI{}{Cont/s})&&\\\\ \n\
\\hline\n\
\\endhead \n\
\\hline \n\
\\endfoot \n");
for i=5:length(SpNaI);
  fprintf(Tabella,"%s & $\\num{%1.0f} \\pm \\num{%1.0f}$ & $\\num{%1.3f} \\pm \\num{%1.3f}$ & %s & %.3f\\\\ \n"
	  ,EtiGe(i,1:columns(EtiGe)),SpGe(i),ErrSpGe(i),ContGe(i),ErrContGe(i),OrigineGe(i,1:columns(OrigineGe)),ContGe(i)/MassaGe(i));
endfor
fprintf(Tabella,"\\end{longtable}");
fclose(Tabella);

function[m,q,Sy,Sm,Sq,r,Res,Cov,n,xbarra,ybarra] = Interpolazione(x,y);
n = length(x);
xbarra = mean(x);
ybarra = mean(y);
Delta = n * sum(x .** 2) - sum(x)**2;
q = (sum(x .** 2) * sum(y) - sum(x) * sum(x .* y)) / Delta;
m = (n * sum(x .* y) - sum(x) * sum(y)) / Delta;
Res = (q + m * x) .- y;
Sy = sqrt(sum( Res .** 2)/(n - 2));
Sm = Sy * sqrt(n / Delta);
Sq = Sy * sqrt(sum(x .** 2) / Delta);
Cov = sum((x - xbarra).*(y-ybarra))/n;
Varx = sum((x - xbarra).**2)/ (n -1);
Vary = sum((y - ybarra).**2)/ (n -1);
#r = Cov / sqrt (Varx * Vary);
r = cov(x,y)/(std(x)*std(y));
endfunction;
function [Media,Err] = MediaPes(x,Errx);
n = length(x);
Peso  = sum(1 ./ (Errx.**2));
Media = sum(x ./ (Errx.**2)) / Peso;
Err   = sqrt(1 / Peso);
endfunction;
X.a=NaIPicco;
Y.a=NaICh;
ErrY.a=ErrNaICh;
X.b=GePicco;
Y.b=GeCh;
ErrY.b=ErrGeCh;
Y.c=NaICh2;
X.c=Picco2;
Y.d=GeCh2;
X.d=Picco2;
disp("Valori da interpolare \n");
				# Valori Da Interpolare
XI.a=X.a;
YI.a=Y.a;
XI.b=X.b;
YI.b=Y.b;
XI.c=X.c;
YI.c=Y.c;
XI.d=X.d;
YI.d=Y.d;
disp("ValoriDelleNetteInterpolanti \n");
				# Valori Delle Rette Interpolanti
x = ["a","b","c","d","e","f"];
i = 1;
[m(i),q(i),Sy(i),Sm(i),Sq(i),r(i)] = Interpolazione(XI.a, YI.a);
i = 2;
[m(i),q(i),Sy(i),Sm(i),Sq(i),r(i)] = Interpolazione(XI.b, YI.b);
i = 3;
[m(i),q(i),Sy(i),Sm(i),Sq(i),r(i)] = Interpolazione(XI.c, YI.c);
i = 4;
[m(i),q(i),Sy(i),Sm(i),Sq(i),r(i)] = Interpolazione(XI.d, YI.d);
i = 3;
#[m(i),q(i),Sy(i),Sm(i),Sq(i),r(i)] = Interpolazione(XI.e, YI.e);
i = 1;

IY.a  = XI.a * m(i) + q(i);
Res.a = XI.a * m(i) + q(i) .- YI.a;       i++;
IY.b  = XI.b * m(i) + q(i);
Res.b = XI.b * m(i) + q(i) .- YI.b;       i++;
IY.c  = X.c * m(i) + q(i);
Res.c = X.c * m(i) + q(i) .- YI.c;       i++;
IY.d  = X.d * m(i) + q(i);
Res.d = X.d * m(i) + q(i) .- YI.d;       i++;

global M=m;
global Q=q;

function En = Energia(Ch,i);
	global Q;
	global M;
	En = (Ch - Q(i))/M(i);
endfunction;

function Ch = Canale(En,i);
	global Q;
	global M;
	Ch = En*M(i)+Q(i);
endfunction;

#RaggioNaI=3.75;
DistanzaNaI=50.5;
#hNaI=sqrt(DistanzaNaI**2 + RaggioNaI**2) - DistanzaNaI;
#RSferaNaI=sqrt(DistanzaNaI**2 + RaggioNaI**2);
#AreaCalottaNaI= 2*pi*RSferaNaI * hNaI;
#AreaSferaNaI=4*pi*RSferaNaI**2;
AttivOdiernaNaI=[3700,3700,433640];
TempoNaI=[800,800,600];
#AttRilevabile = AttivOdiernaNaI * AreaCalottaNaI / AreaSferaNaI;
ngammaNaI=[0.99944*2,0.99944,0.852];
AttRilevataNaI = NaIInt./(TempoNaI .* ngammaNaI);
EfficienzaNaI = AttRilevataNaI ./ AttivOdiernaNaI;


FWHMNaI= 2 * sqrt(2 * log(2)) * ErrNaICh;
RisolNaI = FWHMNaI ./ (NaICh - q(1));

DistanzaGe=13;
AttivOdiernaGe=[3700,3700,433640,(1:30)./(1:30)*172420];
TempoGe=[601,601,617,(1:30)./(1:30)*1203];
#ngammaGe=[2,1,1,0.721*0.622,0.721*0.0843,0.279*0.276,0.279*0.1298,0.721*0.1469,0.721*0.1026,0.721*0.1371,0.721*0.2108];
ngammaGe=GeAtt/100;
AttRilevataGe = GeInt ./(TempoGe .* ngammaGe);
EfficienzaGe = AttRilevataGe ./ AttivOdiernaGe;


FWHMGe = 2 * sqrt(2 * log(2)) * ErrGeCh;
RisolGe = FWHMGe ./ (GeCh - q(2));
GeBelliInt=[];
GeBelliIntErr=[];
GeBelliIntErrRel=[];
GeBelliPicco=[];
GeBelliAtt=[];
GeBelliCh=[];
ErrGeBelliCh=[];
EtGeBelli=[];
EfficienzaGeBelli=[];

for i = 1:length(GeInt)
  if (GeInt(i) > 2032) 
    EfficienzaGeBelli=[EfficienzaGeBelli,EfficienzaGe(i)];
    EtGeBelli=[EtGeBelli;EtGe(i,1:columns(EtGe))];
    GeBelliInt=[GeBelliInt,GeInt(i)];
    GeBelliIntErr=[GeBelliIntErr,GeIntErr(i)];
    GeBelliIntErrRel=[GeBelliIntErrRel,GeIntErrRel(i)];
    GeBelliPicco=[GeBelliPicco,GePicco(i)];
    GeBelliAtt=[GeBelliAtt,GeAtt(i)];
    GeBelliCh=[GeBelliCh,GeCh(i)];
    ErrGeBelliCh=[ErrGeBelliCh,ErrGeCh(i)];
  endif
endfor

Tabella = fopen("NaI.tex","w");
fprintf(Tabella,"\\begin{tabular}{|c|c|c|c|c|c|}\n\
\\hline\n\
\\multirow{2}{*}{Sorgente} & Picco & Energia & \
 Integrale & \
\\multirow{2}{*}{Risoluzione} & \\multirow{2}{*}{Efficienza Relativa}\\\\ \n\
& (\\SI{}{keV}) & (\\SI{}{keV}) & (\\SI{}{keV}) & (\\SI{}{Conteggi/s}) & & \\\\ \n\
\\hline\n");
for i=1:3
  fprintf(Tabella,"%s & \\num{%2.0f} & $ \\num{%2.0f} \\pm \\num{%2.0f}$ & \
  \\num{%2.0f} & \\num{%2.1f} \\%% & \\num{%2.1f} \\%% \\\\ \n", \
	  EtNaI(i,1:columns(EtNaI)),NaIPicco(i), Energia(NaICh(i),1), \
	  ErrNaICh(i)/m(1), Energia(NaIInt(i),1), RisolNaI(i)*100, EfficienzaNaI(i)*100);
endfor;
fprintf(Tabella,"\\hline\n\
\\end{tabular}");
fclose(Tabella);

Tabella = fopen("HPGe.tex","w");
fprintf(Tabella,"\\begin{longtable}{|c|c|c|c|c|c|}\n\
\\hline\n\
\\multirow{2}{*}{Sorgente} & Picco & Energia & Integrale & \\multirow{2}{*}{Risoluzione} & \\multirow{2}{*}{Efficienza Assoluta}\\\\ \n\
& (\\SI{}{keV}) & (\\SI{}{keV}) & (\\SI{}{Conteggi/s}) & & \\\\ \n\
\\hline \n\
\\endhead \n\
\\hline \n\
\\endfoot \n");
for i=1:33
  fprintf(Tabella,"%s & \\num{%2.1f} & $\\num{%2.1f} \\pm \\num{%2.1f}$ & \
  \\num{%2.0f} & \\num{%2.1f} \\%% & \\num{%2.1f} \\textperthousand \\\\ \n", \
	  EtGe(i,1:columns(EtGe)),GePicco(i), Energia(GeCh(i),2), ErrGeCh(i)/m(1), GeInt(i), RisolGe(i)*100, EfficienzaGe(i)*1000);
#	  ErrGeCh(i)/m(1), energiaGe(GeInt(i)), RisolGe(i)*100, EfficienzaGe(i)*1000);
endfor;
fprintf(Tabella,"\\end{longtable}");
fclose(Tabella);

Tabella = fopen("EfficienzaHPGe.tex","w");
fprintf(Tabella,"\\begin{tabular}{|c|c|c|}\n\
\\hline\n\
\\multirow{2}{*}{Sorgente} & Energia & \\multirow{2}{*}{Efficienza Assoluta}\\\\ \n\
& (\\SI{}{keV}) & \\\\ \n\
\\hline\n");
for i=1:length(GeBelliInt)
  fprintf(Tabella,"%s & \\num{%2.1f} & \\num{%2.1f} \\textperthousand \\\\ \n", \
	  EtGeBelli(i,1:columns(EtGeBelli)),GeBelliPicco(i), EfficienzaGeBelli(i)*1000);
endfor;
fprintf(Tabella,"\\hline\n\
\\end{tabular}");
fclose(Tabella);



Tabella = fopen("InterpolazioneNaI.tex","w");
fprintf(Tabella,"\\begin{tabular}{|c|c|c|c|}\n \
\\hline\n\
$m$ (\\SI{}{keV/Ch}) & $q$ (\\SI{}{keV})& $\\sigma_y$ (\\SI{}{keV})& $r$\\\\\n\
\\hline\n");
for i=1:1
fprintf(Tabella," %2.2f $\\pm$ %2.3f & %2.2f $\\pm$ %2.2f & %2.2f & %2.4f \\\\ \n",\
	m(i),Sm(i),q(i),Sq(i),Sy(i),r(i));
endfor;
fprintf(Tabella,"\\hline\n \\end{tabular}");
fclose(Tabella);

Tabella = fopen("InterpolazioneGe.tex","w");
fprintf(Tabella,"\\begin{tabular}{|c|c|c|c|}\n \
\\hline\n\
$m$ (\\SI{}{keV/Ch}) & $q$ (\\SI{}{keV})& $\\sigma_y$ (\\SI{}{keV})& $r$\\\\\n\
\\hline\n");
for i=2:2
fprintf(Tabella,"%2.2f $\\pm$ %2.3f & %2.2f $\\pm$ %2.2f & %2.2f & %2.5f \\\\ \n",\
	m(i),Sm(i),q(i),Sq(i),Sy(i),r(i));
endfor;
fprintf(Tabella,"\\hline\n \\end{tabular}");
fclose(Tabella);

Tabell = fopen("FondoAmbiente.tex","w");
fprintf(Tabella, "\\begin{tabular}{|c|c|c|}\n\
\\hline\n\
Energia & Errore & Integrale\\\\ \n\
(\\SI{}{keV}) & (\\SI{}{keV}) & (\\SI{}{Conteggi})\\\\ \n\
\\hline\n");
for i = 1:length(AmbCh)
  fprintf(Tabella, "%2.1f & %2.1f & %2.1f \\\\",\
	  Energia(AmbCh(i),2), ErrAmb(i)/m(2), IntAmb(i));
endfor;
fprintf(Tabella,"\\hline\n \\end{tabular}");
fclose(Tabella);

				# Valori Indiretti
disp("ValoriIndiretti \n");




				# Grafici
disp("Salva i grafici \n");

gset term postscript enhanced eps;
#gset data style linespoint;
#gset  linestyle 1 lt 1 lw 1 ps 2;
#gset  linestyle 2 lt 1 lw 1 ps 2;
#gset size 1,1.2
#h = 1;
Grf.a = [X.a',Y.a']; GrfI.a = [XI.a', IY.a'];
Grf.b = [X.b',Y.b']; GrfI.b = [XI.b', IY.b'];
GrafRes.b = [X.b', Res.b'];
#Grf.c = [X.c',Y.c']; GrfI.c = [X.c', IY.c'];

gset out "CalibrazioneGe.eps";
gset xlabel "Energia";
gset ylabel "Canali";
gset key box;
gset style line 1;
gset key width +2;
gset key height +1;
#gplot GrafRes.b with points;
gplot Grf.b with points title "Ge" , \
    GrfI.b with lines 1 title "";
#gset out "CalibrazioneNaI.eps";
#gplot  Grf.a with points title "NaI", \
#    GrfI.a with lines 1 title "";
#  Grf.c with point title "17.74KeV" ,\
#  GrfI.c with lines title "";

#gset term X11;
#replot
