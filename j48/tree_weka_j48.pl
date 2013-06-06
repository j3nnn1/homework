#!/usr/bin/perl -w
use strict;
use feature "say";
use Getopt::Long;

my $interval     = '0.025';
my $pathtraining = '';

my $pathtest = '';
my $pathweka = '../../weka/weka-3-6-6/weka.jar';

GetOptions( 'interval=f' => \$interval, 'datatraining=s' => \$pathtraining, 'datatest=s' => \$pathtest );

die 'usage: perl treeweka.pl --datatraining="archivo1.arff" --datatest="archivo2.arff"' if ( !$pathtraining || !$pathtest );
die 'Interval percentage confidence should be less or equal to 0.5' if ( $interval > 0.5 );

#encabezado csv
say "sizetree,numleaves,trainclassifycorrect,trainpercentcorrect,testclassifycorrect,testpercentcorrect,confidence";

my $cont = $interval;

while ( $cont < 0.501 ) {

    my $output = `java -classpath $pathweka weka.classifiers.trees.J48 -C $cont -M 2 -no-cv -t $pathtraining -T $pathtest`;

    #say "java -classpath ../weka-3-6-6/weka.jar weka.classifiers.trees.J48 -C $cont -M 2 -no-cv -t training_semidiscretizado.arff -T test_semidiscretizado.arff";

    $output =~ /Size of the tree :\s+(\d+)/;
    my $sizetree = $1;

    $output =~ /Number of Leaves  :\s+(\d+)/;
    my $leaves = $1;

    $output =~ /=== Error on training data ===\n+Correctly Classified Instances \s+ (\d+) \s+ (\d+.\d+)/;
    my $trainclassifycorrect = $1;
    my $trainpercentcorrect  = $2;

    $output =~ /=== Error on test data ===\n+Correctly Classified Instances \s+ (\d+) \s+ (\d+.*\d*)/;
    my $testclassifycorrect = $1;
    my $testpercentcorrect  = $2;

    #clean up
    chomp($testpercentcorrect);
    $testpercentcorrect =~ s/\s+//g;
    $testpercentcorrect =~ s/%//g;

    say "$sizetree, $leaves,$trainclassifycorrect,$trainpercentcorrect,$testclassifycorrect,$testpercentcorrect,$cont";
    $cont = $cont + $interval;
}
