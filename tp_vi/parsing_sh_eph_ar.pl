#!/usr/bin/perl -w
use Spreadsheet::ParseExcel;
use strict;
use common::sense;
use Data::Dumper;

my $parser = Spreadsheet::ParseExcel->new();
my $workbook = $parser->parse('./data/sh_eph_continuatrimestral.xls');

sub getcoordenate() {
    my $province = shift;

    
}

if ( !defined $workbook ) {
    die $parser->error(), ".\n";
}

my $arr_provincias = [];


sub isperiod {
    my $col = shift;  
    my $isperiod = ($col%6);

    return 1 if $col==1;

    if ($isperiod == 1){
        return 1;
    }
    return 0;
}
sub isempleo {
    my $col = shift;    
    my $isempleo = ($col%6);
    if ($isempleo == 2) {
        return 1;
    }
    return 0;
}
sub isdesocupacion {
    my $col = shift;    
    my $isempleo = ($col%6);
    if ($isempleo == 3) {
        return 1;
    }
    return 0;
}
sub issubocu1 {
    my $col = shift;    
    my $isempleo = ($col%6);
    if ($isempleo == 4) {
        return 1;
    }
    return 0;
}

sub issubocu2 {
    my $col = shift;    
    my $isempleo = ($col%6);
    if ($isempleo == 5) {
        return 1;
    }
    return 0;
}
#
#Region, Periodo, Actividad,Empleo, Desocupación, subocupación demandante, subocupación no demandante 
#
#row title period 2.
#row title region col 0.

for my $worksheet ( $workbook->worksheets() ) {
    my ( $row_min, $row_max ) = $worksheet->row_range();
    my ( $col_min, $col_max ) = $worksheet->col_range();
    $row_min = $row_min + 7;
    for my $row ($row_min .. 51) {
        my $empleo;
        my $region='';
        my $periodo='';
        my $celltitle;

        for my $col (($col_min) .. $col_max) {
            my $cell = $worksheet->get_cell( $row, $col );
            next unless $cell;

            $region = $worksheet->get_cell($row, 0);

            next unless $region;
            $region = $region->value();
            
            if (isperiod($col))  {
                $celltitle = $worksheet->get_cell( 2, $col );
                $periodo = $celltitle->value(); 
                $empleo->{$region}->{$periodo}->{'Actividad'} = $cell->value(); 

            } else {
                if (isempleo($col)){ $empleo->{$region}->{$periodo}->{'Empleo'} = $cell->value(); }
                if (isdesocupacion($col)){ $empleo->{$region}->{$periodo}->{'Desocupacion'} = $cell->value(); }
                if (issubocu1($col)){ $empleo->{$region}->{$periodo}->{'subocupacion_demandante'} = $cell->value(); }
                if (issubocu2($col)){ $empleo->{$region}->{$periodo}->{'subocupacion_no_demandante'} = $cell->value(); }
            }
        }
        if ($empleo) {
            push(@$arr_provincias, $empleo);
        }
        #print Dumper $arr_provincias;
        #if ($row==8){die('HERE!');}
    }
}

my $empleo = {};

foreach my $empleo (@{$arr_provincias}) {
    foreach my $provincia (keys(%{$empleo})){
#        print " $provincia : $empleo->{$provincia}\n";
        foreach my $periodo ( keys(%{$empleo->{$provincia}})) {
           my @line= ();
           if ($periodo){
               push(@line, $periodo);
           }
           if ($provincia) {
               push(@line, $provincia);
           }
#           print "$periodo:".$empleo->{$provincia}->{$periodo}."\n"; 
           foreach my $field (%{$empleo->{$provincia}->{$periodo}}) {
               my $value = $empleo->{$provincia}->{$periodo}->{$field};
               if ($value) {
                   push(@line, $value);
               }
               #print "$provincia, $periodo\n";
               #print "$field: ".$empleo->{$provincia}->{$periodo}->{$field}."\n";
           }
           if (@line) {
                   print join(';', @line)."\n";
           }
        }
    }
}

