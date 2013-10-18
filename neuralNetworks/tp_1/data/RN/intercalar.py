
f = open('/cygdrive/g/RN/data/adult1_class_one_first.csv', 'r')

newfile = open('/cygdrive/g/RN/data/adult1_class_intercalate.csv', 'w')


def next_pair(previous):
    return (previous + 2 )

def next_odd(previous):
    return (previous + 2)

def is_pair(number):
    return (not(number % 2) )

previous_pair = 0
previous_odd = 1
lines = range(1, 12488)
index=0

for line in f:
    fields = line.split(',')

    if (int(fields[3])==1):
        previous_pair = next_pair(previous_pair)
        index = previous_pair
    else:
        previous_odd = next_odd(previous_odd)
        index = previous_odd
    
    lines[index] = ''
    lines[index] = line 


for j, line in enumerate(lines):
    if (len(str(line)) > 6):
        newfile.write(unicode(line))

    
f.close();
newfile.close();
