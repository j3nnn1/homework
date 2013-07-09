#!/usr/bin/perl -w
use strict;
use common::sense;
use Data::Dumper;
use JSON;

#jcmm986 - 0.0.0 -

#read centroides
#obtener arreglo de provincias y capitales con su long y lat.
#read csv
#if province_csv = province_geojson or city_geojson 
    #add features in geojson

my $filenameIN = 'eph20130706_200301.csv';

open(FILE, '<', $filenameIN);
open(FILECENTRO, '<', 'ARG_adm1.geojson');
open(FILEOUT, '>', $filenameIN.'ARG_adm1.geojson');

local $/;
my $geojson  = <FILECENTRO>;

local $/="\n";
my @file = <FILE>;
my $decoded_json = decode_json($geojson);

my $features = $decoded_json->{'features'};
my $juri;
my $capital;
my $line;


foreach my $feature (@$features) {
#type
#geometry
#properties array type
#print Dumper ($feature->{'properties'}{'NAME_1'});
my $province = lc($feature->{'properties'}{'NAME_1'});
#print "Tiene un total de N :". keys($feature->{'properties'})."\n";
#print "\n";
    #$juri =  $feature->{'properties'}->{'JURISDICCI'}."\n";
#    $capital = $feature->{'properties'}->{'CAPITAL'}."\n";
#    chomp($juri);
#    chomp($capital);
    foreach my $line (@file){
       my @fields = split(';', $line); 
       $fields[1] = lc($fields[1]);
#
       if ($province =~m/$fields[1]/i){
       chomp($fields[6]);
       print $fields[1]."\n";
       print $province."\n";
       $feature->{'properties'}->{'desocupacion'} = $fields[2];  
       $feature->{'properties'}->{'actividad'} = $fields[3];  
       $feature->{'properties'}->{'subocupacion_no_demandante'} = $fields[4];  
       $feature->{'properties'}->{'empleo'} = $fields[5];  
       $feature->{'properties'}->{'subocupacion_demandante'} = $fields[6];  
       last;
       }
       else {
          $feature->{'properties'}->{'desocupacion'} = 'NA';  
          $feature->{'properties'}->{'actividad'} = 'NA';
          $feature->{'properties'}->{'subocupacion_no_demandante'} = 'NA';
          $feature->{'properties'}->{'empleo'} = 'NA';
          $feature->{'properties'}->{'subocupacion_demandante'} = 'NA';
       }
    }
}

$decoded_json->{'features'} = $features;

my $json_pretty= JSON->new->allow_nonref;
print FILEOUT $json_pretty->pretty->encode($decoded_json);
