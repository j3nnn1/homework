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

open(FILE, '<', 'eph20130706_200701.csv');
open(FILECENTRO, '<', 'centroide_provincia.geojson');
open(FILEOUT, '>', 'centroide_provincia_200701.geojson');

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

    $juri =  $feature->{'properties'}->{'JURISDICCI'}."\n";
    $capital = $feature->{'properties'}->{'CAPITAL'}."\n";
    $juri = lc($juri);
    $capital = lc($capital);
    chomp($juri);
    chomp($capital);
    foreach my $line (@file){
       my @fields = split(';', $line); 
       $fields[1] = lc($fields[1]);

       if ($fields[1]=~ m/($juri)/i  || $fields[1]=~ m/($capital)/i) {
       print $fields[1]."\n";
       print $juri."\n";
       print $capital."\n";


          ##add features 
          chomp($fields[6]);
          $feature->{'properties'}->{'desocupacion'} = $fields[2];  
          $feature->{'properties'}->{'actividad'} = $fields[3];  
          $feature->{'properties'}->{'subocupacion_no_demandante'} = $fields[4];  
          $feature->{'properties'}->{'empleo'} = $fields[5];  
          $feature->{'properties'}->{'subocupacion_demandante'} = $fields[6];  
          last;
       } 
       else {
          chomp($fields[6]);
          $feature->{'properties'}->{'desocupacion'} = 'NA';  
          $feature->{'properties'}->{'actividad'} = 'NA';
          $feature->{'properties'}->{'subocupacion_no_demandante'} = 'NA';
          $feature->{'properties'}->{'empleo'} = 'NA';
          $feature->{'properties'}->{'subocupacion_demandante'} = 'NA';
       }
    }
}

$decoded_json->{'features'} = $features;
#print encode_json($decoded_json);
my $json_pretty= JSON->new->allow_nonref;
print FILEOUT $json_pretty->pretty->encode($decoded_json);
