#!/usr/bin/perl
#use strict;
use warnings;
my $TicSize = 0.01;

sub DrawGridx{
    my ($Nx,$Lx,$Cx,$Cy,$Cz,$Lab,$OUTFILE) = @_;
    my $Red = 0.;
    my $Green = 0.;
    my $Blue = 0.;
    print OUTFILE "Arrow\n$Red $Green $Blue 1.0\n";
    my $x0 = $Cx - $Lx;
    my $x1 = $Cx + $Lx;
    print OUTFILE "$x0 $Cy $Cz $x1 $Cy $Cz\n";    
    print OUTFILE "Text\n$Lab\n$Red $Green $Blue 1.0\n";
    print OUTFILE "$x1 $Cy $Cz\n";    
    for($ix=-$Nx;$ix<$Nx;$ix++){
	my $x = $Lx*$ix/$Nx + $Cx;
	print OUTFILE "Line\n$Red $Green $Blue 1.0\n";
	print OUTFILE "$x ",$Cy - .5*$TicSize," $Cz $x ", $Cy + .5*$TicSize," $Cz \n";
    }
}
sub DrawGridy{
    my ($Ny,$Ly,$Cx,$Cy,$Cz,$Lab,$OUTFILE) = @_;
    my $Red = 0.;
    my $Green = 0.;
    my $Blue = 0.;
    print OUTFILE "Arrow\n$Red $Green $Blue 1.0\n";
    my $y0 = $Cy - $Ly;
    my $y1 = $Cy + $Ly;
    print OUTFILE "$Cx $y0 $Cz $Cx $y1 $Cz\n";    
    print OUTFILE "Text\n$Lab\n$Red $Green $Blue 1.0\n";
    print OUTFILE "$Cx $y1 $Cz\n";    
    for($iy=-$Ny;$iy<$Ny;$iy++){
	my $y = $Ly*$iy/$Ny + $Cy;
	print OUTFILE "Line\n$Red $Green $Blue 1.0\n";
	print OUTFILE $Cx-.5*$TicSize," $y $Cz ", $Cx + .5*$TicSize, " $y $Cz \n";
    }
}
#-----------------main----------------------
if($ARGV[0] eq '--grid'){
    open(OUTFILE, "> $ARGV[1]" ) or $ARGV[1] = "Output.dat";
    my ($Nx,$Ny,$Nz) = (5,10,5);
    my ($Cx,$Cy,$Cz) = (.555,.58,0.02);
    my ($Lx,$Ly,$Lz) = (.15,.25,.2);
    my ($Labx,$Laby,$Labz) = ("r","z","pot");
    DrawGridx($Nx,$Lx,$Cx,$Cy,$Cz,$Labx,$OUTFILE);
    DrawGridy($Ny,$Ly,$Cx,$Cy,$Cz,$Laby,$OUTFILE);
}
elsif($ARGV[0] eq "--ciccia"){
}
else{
    print "Specify a command\n";
    die;
}
