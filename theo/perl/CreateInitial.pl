#!/usr/bin/perl
sub CreateScript
{
    open (SCRIPT, "> DrawScript.dr") or die "Can't open DrawScript.dr";
    print SCRIPT "#File automatically generated from Averages.pl\n";
    $NCol = 40;
    #print SCRIPT "Text\nHydrophobic\n0.0 0.0 0.0 1.0\n-1.0 .1 0.0\n";
    #print SCRIPT "Text\nHydrophilic\n0.0 0.0 0.0 1.0\n-1.0 .3 0.0\n";
    #print SCRIPT "Text\nOil\n0.0 0.0 0.0 1.0\n-1.0 .5 0.0\n";
    for($c=0;$c<3;$c++){
	$x1 = 2+$c*.1;
	$x2 = $x1+.05;
	for($i=0;$i<$NCol;$i++){
	    $col = $i/$NCol;
	    $y1 = $i/$NCol;
	    $y2 = $y1 + 1.0/$NCol;
	    print SCRIPT "Polygon\n";
	    if($c == 0){
		print SCRIPT "0.0 $col 0.0 1.0\n";}
	    if($c == 1){
		print SCRIPT "0.0 0.0 $col 1.0\n";}
	    if($c == 2){
		print SCRIPT "$col $col 0.0 1.0\n";}
	    print SCRIPT "$x1 $y1 0.0\n";
	    print SCRIPT "$x2 $y1 0.0\n";
	    print SCRIPT "$x2 $y2 0.0\n";
	    print SCRIPT "$x1 $y2 0.0\n";
	}
    }
    close SCRIPT;
}
sub CreateRandom3d
{
    open (INIT, "> Initial.dat") or die "Can't open Initial.dat";
    #print INIT "#File automatically generated from Run.pl\n";
    $NPart = 50;
    for($n=0;$n<$NPart;$n++){
	$t = int(3.*rand()); $x = rand(); $y = rand(); $z = rand();
	print INIT "$t $x $y $z\n";
    }
    close INIT
}
sub CreateOndulate
{
    open (INIT, "> Ondulate.xvl") or die "Can't open Initial.dat";
    print INIT "#l(1.000000 1.000000 1.000000) v[32] d[10]";
    $NPart = 64;
    $Delta = 1.0 / ($NPart);
    $Freq = 4.0/1.0;
    $t = 0;
    $y = 0;
    for($n=0;$n<$NPart;$n++){
	$x = 0;
	for($m=0;$m<$NPart;$m++){
	    #$z = 0.25*sin($x*6.18*$Freq)+ 0.25*sin($y*6.18*$Freq);
	    $z = 0.25*sin($x*$y*6.18*$Freq);
	    print INIT "{x($x $y $z)}\n";
	    #print INIT "$x $y $z \n";
	    #print INIT "$z \n";
	    $x += $Delta;
	}
	$y += $Delta;
    }
    close INIT
}

CreateOndulate();
