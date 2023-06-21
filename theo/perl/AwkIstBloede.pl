#!/usr/bin/perl
sub read_file
{
    my ( $f ) = @_;
    open F, "< $f" or die "Can't open $f : $!";
    my @f = <F>;
    close F;
    return wantarray ? @f : \@f;
}

sub write_file
{
    my ( $f, @data ) = @_;
    @data = () unless @data;
    open F, "> $f" or die "Can't open $f : $!";
    print F @data;
    close F;
}
print "@ARGV\n";
$filename = @ARGV[0];
$outfile = @ARGV[1];
open( FILE, "< $filename" ) or die "Can't open $filename : $!";
open( OUTFILE, "> $outfile") or die "Can't open $outfile : $!";
print "Leggo da $filename e scrivo su $outfile\n";
#binmode FILE; 

#while ($dati = <FILE>) { 
#    print $dati;
#}

@lines = <FILE>;
close (FILE);
foreach $ciccia (@lines)
{
    chomp($ciccia);
    ($ax,$ay) = split(/\ /,$ciccia);
    print OUTFILE "$ay\n";
}

#print @lines;
sub split_file
{
    $n = 0;
    foreach $ciccia (@lines)
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
	$c1 = @r1[$n];
	$c2 = @r2[$n];
	if($n < 100){
	    print OUTFILE "$c0\t$c1\t$c2\n";
	}
	$n++;
    }
}
    


#$op = shift;
#for( @ARGV ) {
#    $was = $_;
#    eval $op;
#    die if $@;
#    rename( $was, $_ ) unless $was eq $_;
#}
