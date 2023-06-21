#!/usr/bin/perl
#use strict;
use warnings;

sub SQR{
    my $Num = shift(@_);
    return $Num*$Num;
}
sub FileMedia{
    $nMass=-1;
    foreach $ciccia (@_)
    {
	if($nMass>=0){
	    chomp($ciccia);
#	    @ciccione = split("  ",$ciccia);
#	    foreach $pasciuto (@ciccione){ print "$pasciuto";}print "\n";
	    ($x,$y1,$y2,$y3) = split(/   /,$ciccia);
	    $xm[$nMass] = $x;
	    $y1m[$nMass] = $y1;
	    $y2m[$nMass] = $y2;
	    $y3m[$nMass] = $y3;
#	    print "  $nMass $ciccia\n";
#	    print "$x $y1 $y2 $y3\n";
#	    print "@xm[$nMass] @y1m[$nMass] @y2m[$nMass] @y3m[$nMass]\n";
	}
	$nMass++;
    }
    @newlines = (@xm,@y1m,@y2m,@y3m);
    return @newlines;
}
sub FileSplit{
    $n = 0;
    foreach $ciccia (@_)
    {
	chomp($ciccia);
	($ax,$ay,$az) = split(/\ /,$ciccia);
	$r = $ax * $ax +  $ay * $ay + $az * $az;
	if( $n <= 100){
	    push @r0, $r
	}
	elsif ( $n <= 201 ){ 
	    push @r1, $r
	}
	elsif ( $n <= 302 ){ 
	    push @r2, $r
	}
	#print "$n $r\n";
	$n++;
    }
    $n = 0;
    foreach $c0 (@r0){
	$c1 = $r1[$n];
	$c2 = $r2[$n];
	if($n < 100){
	    print OUTFILE "$c0\t$c1\t$c2\n";
	}
	$n++;
    }
}
#To be finished (if necesary)
sub SubsRigidPos{
    my ($FRead) = @_;
    open( FILE1, "< $FRead" ) or die "Can't open $FRead : $!";
    #open( FILE2, "> $FWrite" ) or $outfile = "Output.dat";
    @lines1 = <FILE1>;
    close(FILE1);
    my $nx = 0.;
    my $ny = 0.;
    my $nz = 0.;
    foreach $line (@lines1){
	chomp($line);
#	($filename,$nx,$ny,$nz) = split(/\ /,$ciccia);
	($filename,$nx,$ny,$nz) = split(/\W+/,$ciccia);
	open(FSnap, "< $filename" ) or die "Can't open $filename : $!";
	@snap1 = <FSnap>;
	foreach $snap (@snap1){
	    if($snap =~ /^# Rigid/){
		$snap =~ m/x\(/g;
		
		exit;
	    }
	}
	close(FSnap);
    }
}	
sub Press{
    my ($FRead,$FWrite) = @_;
    open( FILE1, "< $FRead" ) or die "Can't open $FRead : $!";
    open( FILE2, "> $FWrite" ) or $outfile = "Output.dat";
    @lines1 = <FILE1>;
    close(FILE1);
    #print FILE2 "#Prex Prey Prez\n";
    my $Avx = 0.;
    my $Avy = 0.;
    my $Avz = 0.;
    my $Avx2 = 0.;
    my $Avy2 = 0.;
    my $Avz2 = 0.;
    my $AvLy = 0.;
    my $AvLz = 0.;
    my $Area = 0.;
    my $Area2 = 0.;
    my $n = 0;
    my $nOff = 0.;
    foreach $line (@lines1){
	chop($line);
	if($nOff > 5){
	    if($line =~ /l=/){
		$line =~ m/l=/g;
		$OffSet = pos($line);
		my ($Lx,$Ly,$Lz) = split / /,substr($line,$OffSet);
		$AvLy += $Ly;
		$AvLz += $Lz;
		$Area += $Lx*$Ly;
		$Area2 += ($Lx*$Ly)*($Lx*$Ly);
	    }
	    if($line =~ /P=/){
		$line =~ m/P=/g;
		$OffSet = pos($line);
		my ($Prex,$Prey,$Prez) = split / /,substr($line,$OffSet);
		$Avx += $Prex;
		$Avy += $Prey;
		$Avz += $Prez;
		$Avx2 += $Prex*$Prex;
		$Avy2 += $Prey*$Prey;
		$Avz2 += $Prez*$Prez;
		$n++;
		print FILE2 "$n $Prex $Prey $Prez\n";
	    }
	}
	$nOff++;
    }
    if($n <= 1){ print "no data\n"; return;}
    $Avx = $Avx/$n;
    $Errx = sqrt(($Avx2 - $n*$Avx*$Avx)/($n-1));
    $Avy = $Avy/$n;
    $Erry = sqrt(($Avy2 - $n*$Avy*$Avy)/($n-1));
    $Avz = $Avz/$n;
    $Errz = sqrt(($Avz2 - $n*$Avz*$Avz)/($n-1));
    $AvLz = $AvLz/$n;
    $AvLy = $AvLy/$n;
    #$ErrRel = sqrt(SQR($Errx/$Avx) + SQR($Erry/$Avy) + SQR($Errz/$Avz));
    #Relative error does not make sense for values oscillating around zero
    $ErrRel = ($Errx + $Erry + $Errz)/3.;
    $Area = $Area/$n;
    my $LatPre = ($Avz - .5*($Avx+$Avy))*$AvLz;
#    my $LatPre = ($Avy - .5*($Avx+$Avz))*$AvLy;
    my $LatErr = $LatPre*$ErrRel/sqrt($n);
    my $Compr = ($Area2/$n - $Area*$Area)/$Area;
#    print "$LatPre +- $LatErr Compr $Compr \n($Avx +- $Errx $Avy +- $Erry $Avz +- $Errz )\n";
    print "$LatPre  $LatErr \n";
    close(FILE2);
}
sub ConvPoly{
    my ($file1,$file2) = @_;
    open( FILE1, "< $file1" ) or die "Can't open $file1 : $!";
    open( FILE2, "> $file2" ) or die "Can't open $file2 : $!";# open( FILE2, "> Risposta.dat" );
    @lines1 = <FILE1>;
    my $n = 0;
    print "$file1 $file2\n";
    foreach $line1 (@lines1){
	++$n;
	if($n < 6){next;}
	chop($line1);
	my ($x1,$x2,$x3,$t) = split / /,$line1;
	my $type = 1;
	if($t==2){$type = 0;};
	print FILE2 "$x3 $x2 $x1 0 0 0 $type\n";
	#if($n > 536643){ last; };
    }
}
sub PoreTens{
    my ($file1,$file2) = @_;
    open( FILE1, "< $file1" ) or die "Can't open $file1 : $!";
    open( FILE2, "> $file2" ) or die "Can't open $file2 : $!";# open( FILE2, "> Risposta.dat" );
    @lines1 = <FILE1>;
    close(FILE1);
    print FILE2 "#Rad Tens Rad*LatPre LatPre\n";
    my $NSlab = 100;
    foreach $line1 (@lines1){
	chop($line1);
	if($line1 =~ /#/){next;}
	my ($Pre1,$Pre2,$Pre3,$Area) = split / /,$line1;
	#if($Pre[0] !~ m/\d/){ next;}
	$Rad = sqrt(($NSlab*$NSlab-$Pre1)/($NSlab*$NSlab)*$Area)/3.1416;
#	$Tens += ($Pre[1]/(32*32))/3.96;
#	$Prod = $Rad*$Pre[2]*32;
	my $PoreRad = 1.0/$Rad;
	print FILE2 "$PoreRad $Pre2 \n";
    }
    close(FILE2);
}
sub FileMedia1{
    $nf = 0; foreach $filename (@_)
#    for($nf=0;$nf<$ARGV-1;$nf++)
    {
	print "$filename\r";
	open( FILE, "< $filename" ) or die "Can't open $filename : $!";
	@lines = <FILE>;
	close (FILE);
	@newlines = Media(@lines);
	for($n=0;$n<$nMass;$n++){
	    $y1mf[$n] += $y1m[$n];
	    $y2mf[$n] += $y2m[$n];
	    $y3mf[$n] += $y3m[$n];
	    print "$nf $n $xm[$n]\t$y1m[$n]\t$y2m[$n]\t$y3m[$n]\n";
	    print "$nf $n $xm[$n]\t$y1mf[$n]\t$y2mf[$n]\t$y3mf[$n]\n";
	}
	$nf++;
    }
    $nn = 0;
    foreach (@xm){
	$y1m[$nn] /= $nf;
	$y2m[$nn] /= $nf;
	$y3m[$nn] /= $nf;
	$nn++;
    }
    $outfile = "AverageTension.dat";
#    $outfile = @_[0];
    open( OUTFILE, "> $outfile") or die "Can't open $outfile : $!";
    for($n=0;$n<$nMass;$n++){
#	print OUTFILE "@xm[$n] @y1m[$n] @y2m[$n] @y3m[$n]\n";
#	print "@xm[$n]  @y1m[$n]  @y2m[$n]  @y3m[$n]\n";
	print OUTFILE "$xm[$n]  \n";
    }
}
sub FileRead
{
    my ( $f ) = @_;
    open F, "< $f" or die "Can't open $f : $!";
    my @f = <F>;
    close F;
    return wantarray ? @f : \@f;
}
sub FileWrite
{
    my ( $f, @data ) = @_;
    @data = () unless @data;
    open F, "> $f" or die "Can't open $f : $!";
    print F @data;
    close F;
}
sub FileKlebt{
    $nf=0;
    foreach $filename (@_)
    {
	open(FILE, "< $filename") or die "Couldn't open $filename : $!";
	while (<FILE>){
	    $nl = 0;
	    $string[$nl] = join($_,' ');
	    push(@Text,$string);
	    $nl++;
	    print "$nl $string[$nl]\n"
	}
	$nf++;
    }
    print "@Text";
}
sub FileAverage{
    $n=0;
    foreach $ciccia (@_)
    {
	chomp($ciccia);
	($aa,$ab,$ac,$ad,$a4,$ae,$af,$ag) = split(/\ /,$ciccia);
	$a4=0.;
	$aaa += $aa;$aac += $ac;$aad += $ad;$aae += $ae;$aaf += $af;$aag += $ag;
#   print "$n $ab $aa $ac $ad $ae\n";
#	if($n == 499){
#	exit;
	$n++;
    }
    $aaa /= $n+1;$aac /= $n+1;$aad /= $n+1;$aae /= $n+1;$aaf /= $n+1;$aag /= $n+1;$pot /= $n+1;
    print OUTFILE "$ab  $aaa  $aac  $aad  $aaf  $aag  $pot\n";
    $aaa = 0;$aac = 0;$aad = 0;$aae = 0;$aaf = 0;$aag = 0;$pot=0;$n =0;
}
sub ColMultiply{
    $n=0;
    foreach $ciccia (@_)
    {
	chomp($ciccia);
	($sonsa,$baga) = split(/\ /,$ciccia);
	$pansa = $sonsa*$baga;
	print OUTFILE "$pansa\n";
    }
}
sub CalcError{
    my $n=1;
    my $Prey  = 0;
    my $Prey2 = 0;
    my $PreOld = 0;
    foreach $ciccia(@_){
	chomp $ciccia;
	my @Pre = split / /,$ciccia;
	if($Pre[0] == $PreOld){
	    $Prey += $Pre[1];
	    $Prey2 += $Pre[1]*$Pre[1];
	    $n++;
	}
	elsif($n>1){
	    $Prey /= $n;
	    $Err = sqrt(($Prey2 - $n*$Prey*$Prey)/($n-1));
	    print OUTFILE "$PreOld $Prey $Err\n";
	    #print "$PreOld $Prey $Err $n\n";
	    $n = 1;
	    $Prey = $Pre[1];
	    $Prey2 = $Pre[1]*$Pre[1];
	}
	else{
	    print OUTFILE "$Pre[0] $Pre[1] 0\n";
	    $n = 0;
	    $Prey = 0;
	    $Prey2 = 0;
	}
	#print "$n @Pre[0] @Pre[1] $Prey $Prey2\n";
	$PreOld = $Pre[0];
    }
}
sub CalcAverage{
    my ($filename,$outfile) = @_;
    open( FILE, "< $filename" ) or die "Can't open $filename : $!";
    open( OUTFILE, "> $outfile") or $outfile = "Output.dat";
    @lines = <FILE>;
    close (FILE);
    my $n=0;
    my $Prex  = 0;
    my $Prex2 = 0;
    my $Prey  = 0;
    my $Prey2 = 0;
    my $Prez  = 0;
    my $Prez2 = 0;
    my $Initial = 50;
    foreach $ciccia(@lines)
    {
	chomp $ciccia;
	#$ciccia =~ s/[ \n]+$//;
 	#my @Pre = split(/\W /,$ciccia,-1);
	my @Pre = split / /,$ciccia;
	if($n>$Initial){
	    $Prex  += $Pre[2];
	    $Prex2 += $Pre[2]*$Pre[2];
	    $Prey  += $Pre[3];
	    $Prey2 += $Pre[3]*$Pre[3];
	    $Prez  += $Pre[4];
	    $Prez2 += $Pre[4]*$Pre[4];
	    $Norm = $n - $Initial;
	    if($Norm > 0){
		$Press = 32*($Pre[4] - .5*($Pre[3] + $Pre[2]));
		$Lat = .5*($Pre[2] + $Pre[3]);
		printf OUTFILE "%.2f %.5f %.5f\n",$Pre[0], $Lat , $Press;
	    }
	}
	$n++;
    }
    if($n > 0){
	$Norm = $n - $Initial;
	$Prex /= $Norm;
	$Errx = sqrt(($Prex2 - $Norm*$Prex*$Prex)/($Norm-1));
	$Prey /= $Norm;
	$Erry = sqrt(($Prey2 - $Norm*$Prey*$Prey)/($Norm-1));
	$Prez /= $Norm;
	$Errz = sqrt(($Prez2 - $Norm*$Prez*$Prez)/($Norm-1));
	$ErrRel = sqrt( SQR($Errx/$Prex) + SQR($Erry/$Prey) + SQR($Errz/$Prez));
	$Tens = 32*($Prez - .5*($Prex + $Prey));
	$LatPre = .5*($Prex+$Prey);
	$ErrTens = $Tens*$ErrRel;
	printf "$LatPre $Tens pm $ErrTens $Prex pm $Errx $Prey pm $Erry $Prez pm $Errz \n";
    }
}
sub OverThreshold{
    my ($file1,$col,$thr) = @_;
    open( FILE1, "< $file1" ) or die "Can't open $file1 : $!";
    my $n=0;
    @lines1 = <FILE1>;
    close(FILE1);
    foreach $line1 (@lines1){
	chomp($line1);
	my @Pre = split / /,$line1;
	if($Pre[$col] > $thr){
	    print "$n $Pre[$col]\n";
	}
	$n++;
    }
}
sub Compare2{
    my ($file1,$file2) = @_;
    open( FILE1, "< $file1" ) or die "Can't open $file1 : $!";
    open( FILE2, "< $file2" ) or die "Can't open $file2 : $!";
    open(EXIT,"> FileList.txt" ) or die "Can't open FileList.txt";
    @lines1 = <FILE1>;
    @lines2 = <FILE2>;
    close(FILE1);
    close(FILE2);
    foreach $line1 (@lines1){
	my $Celo = 0;
	foreach $line2 (@lines2){
	    if($line1 eq $line2){
		$Celo = 1;
		last;
	    }
	}
	if($Celo==0){
	    print EXIT "$line1";
	}
    }
}

my $str1 = 'ciccia';
my $str2 = 'panza';
if($str1 eq $str2){
    print "Ciccia\n";
}

sub RunningAv{
    my ($file1,$file2) = @_;
    open( FILE1, "< $file1" ) or die "Can't open $file1 : $!";
    open( FILE2, "> $file2" ) or die "Can't open $file2 : $!";
    @lines1 = <FILE1>;
    close(FILE1);
    my $NSample = 2;
    my $n = 0;
    my $x = 0;
    my $y = 0;
    foreach $line1 (@lines1){
	chomp($line1);
	my @Pre = split / /,$line1;
	$x += $Pre[0];
	$y += $Pre[1];
	if($n == $NSample){
	    $x /= $NSample;
	    $y /= $NSample;
	    print FILE2 "$x $y\n";
	    $n=0;
	    $x=0;
	    $y=0;
	}
	$n++;
    }
}
#-----------------main----------------------
if($ARGV[0] eq '--comp'){
    Compare2($ARGV[1],$ARGV[2]);
}
elsif($ARGV[0] eq "--RunAv"){
    RunningAv($ARGV[1],$ARGV[2]);
}
elsif($ARGV[0] eq "--PoreTens"){
    PoreTens($ARGV[1],$ARGV[2]);
}
elsif($ARGV[0] eq "--Thr"){
    OverThreshold($ARGV[1],$ARGV[2],$ARGV[3]);
}
elsif($ARGV[0] eq "--Press"){
    Press($ARGV[1],$ARGV[2]);
}
elsif($ARGV[0] eq "--Av"){
    CalcAverage($ARGV[1],$ARGV[2]);
}
elsif($ARGV[0] eq "--ConvPoly"){
    ConvPoly($ARGV[1],$ARGV[2]);
}
else{
    print "Specify a command\n";
    die;
}
