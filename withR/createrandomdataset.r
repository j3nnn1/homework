# this let create a random dataset with a "uniform dist".
#
# N = number of vars, (columns).
# M = quantity of rows.
n = 10000;
m = 50;
#to search a dist.
#help.search("distribution",package="stats");
getclass = function(x) {
	result = c();
	if (x > 0.5) {
		result = 'SI';
	}
	else {
		result = 'NO';
	}
	return (result);
}

dataset.m = matrix(runif(n*m), nrow=n, ncol=m);
class = sapply(runif(n), getclass);

colnames(dataset.m) = c(1:m);
dataset.m = cbind(dataset.m, class);
write.csv(dataset.m, 'datasetrandom.csv');










