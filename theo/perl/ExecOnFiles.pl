#!/usr/bin/perl
sub MatchX{
    my ($file1,$file2) = @_;
    open( FILE1, "< $file1" ) or die "Can't open $file1 : $!";
    open( FILE2, "< $file2" ) or die "Can't open $file2 : $!";
    @lines1 = <FILE1>;
    @lines2 = <FILE2>;
    close(FILE1);
    close(FILE2);
    my @Vectx1;
    my @Vecty1;
    my $NMax1 = 0;
    my @Vectx2;
    my @Vecty2;
    my $NMax2 = 0;
    foreach $line1 (@lines1){
	chomp($line1);
	($x,$y) = split(/ /,$line1);
	push @Vectx1 , $x;
	push @Vecty1 , $y;
	$NMax1++;
    }
    foreach $line2 (@lines2){
	chomp($line2);
	#(@Vectx2[$NMax2],@Vecty2[$NMax2++]) = split(/   /,$line2);
	($x,$y) = split(/ /,$line2);
	push @Vectx2 , $x;
	push @Vecty2 , $y;
	$NMax2++;
    }
    open(EXIT,"> WidomError.dat" ) or die "Can't open WidomError.dat";
    my $n2Temp = 0;
    my $Ris = 0.;
    my $Arg = 0.;
    for($n1 = 0;$n1<$NMax1;$n1++){
	for($n2=$n2Temp;$n2<$NMax2;$n2++){
	    if(@Vectx2[$n2] > @Vectx1[$n1] && @Vectx2[$n2] < @Vectx1[$n1+1]){
		$n2Temp = $n2;
		if(@Vecty1[$n1]>0.){$Arg = @Vecty2[$n2]/@Vecty1[$n1];}
		else {next;}
		if($Arg > 0.){$Ris = @Vectx2[$n2]+log($Arg);}
		else {next;}
		print EXIT "@Vectx2[$n2] $Ris\n";
		print "$n2 $Ris $Arg $Diff\n";
		#last;
	    }
	}
    }
}

MatchX(@ARGV[0],@ARGV[1]);
