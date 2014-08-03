FILE=$1
#numero de grupo que somos.
NN=19

#revisar la salida de R con head para ver que prediccion es quien.
cut -d',' -f 1,3 $FILE > tmp_result.csv
sed -i 's/.plain.txt//g' tmp_result.csv
sed -i 's/.plain//g' tmp_result.csv
sed -i 's/1$/oposición/g' tmp_result.csv
sed -i 's/2$/oficial/g' tmp_result.csv
sed -i 's/"//g' tmp_result.csv
sort tmp_result.csv >> grupo$NN$FILE



