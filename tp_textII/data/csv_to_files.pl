#!/usr/bin/perl -w
use strict;
use common::sense;


my $content_column = 2;
my $title_column = 3;
my $filename = 'diariobae.csv';

$filename =~ /(\w+).csv/g;
my $dirname = $1; 
my $count = 0;
open(FILE, '<', $filename);

while (my $line = <FILE>) {
   my @fields  = split(';', $line);
   mkdir $dirname unless -d $dirname;
   print "Escribiendo archivos en directorio:".$dirname.'/'.$filename.$count.".txt\n";
   open FILEOUT, '>', $dirname.'/'.$filename.$count.".txt" or die ('no es posible abrir el archivo');
   print FILEOUT $fields[2]."\n";
   print FILEOUT $fields[1]."\n";
   close (FILEOUT);
   $count++;
}

close(FILE);
