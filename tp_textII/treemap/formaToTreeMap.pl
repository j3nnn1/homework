#!/usr/bin/perl -w
use strict;
use common::sense;
use Data::Dumper;
use JSON;
use Scalar::Util;

#jcmm986 - 0.0.0 -

##
# dad
#    location
#        app_source
#              screen_name : size

open(FILE,"<","manyeye.csv");
my $fields = [];
my $dad = {};

while (<FILE>) {
    my $line = $_; 
    @{$fields} = split(";", $line);
    $dad->{$fields->[2]}->{$fields->[0]}->{$fields->[1]} = $fields->[3];
}
sub doNode {
   my $name = shift; 
   my $children = shift; 
   my $node = {};
   $node->{name} = $name;
   $node->{children} = $children;
   return $node;
}
sub doEndNode {
   my $name = shift; 
   my $children = shift; 
   my $node = {};
   $node->{name} = $name;
   $node->{size} = $children;
   return $node;
   
}
my $flisol = {
    'name'=> 'Flisol',
    'children'=> []
};

my $c_loc = 0;
my $c_app = 0;
my $follow;
my $user;
my $app;

foreach my $location (keys (%{$dad})){
   $app = [];
   push($flisol->{'children'}, doNode($location, $app));

   $c_app = 0;
   foreach my $app (keys (%{$dad->{$location}})) {
       $user = [];
       push($flisol->{'children'}->[$c_loc]->{'children'}, doNode($app, $user));
       #$flisol->{'children'}->[$c_loc]->{'children'}->[0]->{'children'} = [];
       $flisol->{'children'}->[$c_loc]->{'children'}->[$c_app]->{'children'} = [];
       foreach my $screen (keys(%{$dad->{$location}->{$app}})) {
           $follow = $dad->{$location}->{$app}->{$screen};
           my $arr = $flisol->{'children'}->[$c_loc]->{'children'}->[$c_app]->{'children'};
           push($arr, doEndNode($screen, $follow));
       }
       $c_app = $c_app + 1;
   }
   $c_loc = $c_loc + 1;
}
#print Dumper $flisol;
my $text  = JSON->new->allow_nonref->pretty->encode($flisol);
print $text."\n";
