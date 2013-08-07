#!/usr/bin/perl -w
use strict;
use common::sense;


my $content_column = 1;
my $title_column = 2;
my $filename = 'noticias24.csv.data';
my $separator = ';';

$filename =~ /(\w+).csv/g;
my $dirname = $1; 
my $count = 0;
open(FILE, '<', $filename);

while (my $line = <FILE>) {

   my @fields  = split($separator, $line);
   mkdir $dirname unless -d $dirname;
   print "Escribiendo archivos en directorio:".$dirname.'/'.$filename.$count.".txt\n";
   open FILEOUT, '>', $dirname.'/'.$filename.$count.".txt" or die ('no es posible abrir el archivo');
   print FILEOUT $fields[$content_column]."\n";
   print FILEOUT $fields[$title_column]."\n";
   close (FILEOUT);
   $count++;
}

close(FILE);
