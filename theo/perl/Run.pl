#!/usr/bin/perl
#use strict;
#use warnings;
require "/home/marelli/Calcolo/bin/CreateInitial.pl";
require "/home/marelli/Calcolo/bin/FileElaborate.pl";

#CreateRandom3d();
#CreateOndulate();

#CreateScript();
#FileMedia(@ARGV);
#FileKlebt(@ARGV);
#print "@ARGV\n";
$filename = @ARGV[0];
$outfile = @ARGV[1];    
open( FILE, "< $filename" ) or die "Can't open $filename : $!";
open( OUTFILE, "> $outfile") or die "Can't open $outfile : $!";
#ColMultiply($filename);
#open( OTHER,"ChemPot.2.dat") or die "Can't open $outfile : $!";
#print "Leggo da $filename e scrivo su $outfile\n";
#binmode FILE; 

#while ($dati = <FILE>) { 
#    print $dati;
#}

#@lines = <FILE>;
#close (FILE);
#Average(@lines);
#print @lines;


#$op = shift;
#for( @ARGV ) {
#    $was = $_;
#    eval $op;
#    die if $@;
#    rename( $was, $_ ) unless $was eq $_;
#}
