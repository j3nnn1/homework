

open(FILE,'<', 'stopwords.txt');
open(FILEOUT,'>', 'stopwords2.txt');

while(<FILE>) {
 my @words = split("\s", $_);
 foreach (@words){
    $_=~s/\s*//g; 
    print FILEOUT $_."\n";
 }

}
