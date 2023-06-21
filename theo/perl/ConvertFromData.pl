#!/usr/bin/perl
sub SQR{
    my $Num = shift(@_);
    return $Num*$Num;
}
sub MatchValue{
    my ($table,$Param1,$Param2) = @_;
    open( TABLE, "< $table" ) or die "Can't open $table : $!";
    @tablines = <TABLE>;
    foreach $ciccia(@tablines)
    {
	chomp $ciccia;
	my @xVal = split / /,$ciccia;
	if($Param1 == $xVal[0] && $Param2 == $xVal[1]){
	    return @xVal[2];
	}
    }
    close(TABLE);
}
sub ConvertTable{
    my ($filename,$table,$FileNameOut) = @_;
    open( FILE, "< $filename" ) or die "Can't open $filename : $!";
    open( OUTFILE, "> $FileNameOut" ) or die "Can't open $filename : $!";
    @lines = <FILE>;
    foreach $ciccia(@lines)
    {
	chomp $ciccia;
	my @xVal = split / /,$ciccia;
	my $Converted = 0.;
	$Converted = MatchValue($table,$xVal[0],$xVal[1]);
	printf OUTFILE "%lf %lf\n", @xVal[0]/4.32, $Converted;
    }
    close(FILE);
    print "Wrote on $FileNameOut\n";
}


$filename = @ARGV[0];
$table = @ARGV[1];
$outfile = @ARGV[2];
ConvertTable($filename,$table,$outfile);
