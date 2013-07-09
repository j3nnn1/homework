
open(FILE, '<', 'eph_20130701.csv.sort') or die ('could not open file');
open(FILEOUT, '>', 'eph_20130701.csv.sort.timeseries') or die ('could not open file');

my @fields;

while( $line = <FILE>){
    @fields = split(';', $line);
    $year = getyear($fields[0]);
    $period = getperiod($fields[0]);
    my $newfield =  $year.$period;
    $fields[0] = $newfield;
    $newline = join(';', @fields);
    print FILEOUT $newline;
}

sub getperiod(){

    $field = shift;
    my $period;
    if ($field=~/Tercer/) { $period = 3; } 
    if ($field=~/Segundo/) { $period = 2; } 
    if ($field=~/Primer/) { $period = 1; } 
    if ($field=~/Cuarto/) { $period = 4; } 
    return $period;
}

sub getyear(){
    $field = shift;
    my $year;
    if ($field=~/(\d*)$/) {
	$year = $1;
    } 
    return $year;
}

close(FILEOUT);
close(FILE);
