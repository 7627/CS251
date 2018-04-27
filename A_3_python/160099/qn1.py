import sys
# x=raw_input("enter the number  ");
# base=input("base : ");
x=sys.argv[1];
base=sys.argv[2];
if len(base)==2:
    base=(ord(base[0])-ord('1')+1)*10+ord(base[1])-ord('1')+1;
elif len(base)==1:
    base=ord(base[0])-ord('1')+1;
# print base;
# print len(x)
if base>36 or base<2:
    print "base is too large or too less";
    quit();
y=[];
number="1234567890"
letter="ABCDEFGHIJKLMNOPQRSTUVWXYZ"
# length=len(x)
minus=0;
dot_present=0; #check if dot is present or not
for i in range(0,len(x)):
    if x[i]=='-':
        y.append(0);
        minus=1;
    elif x[i] in number:
        # print x[i],' is a number'
        y.append(ord(x[i])-ord('1')+1);
        # print ord(x[i])-ord('1')+1;
        if ord(x[i])-ord('1')+1>=base:
            print("invalid input")
            quit();
    elif x[i] in letter:
        # print x[i],' is a Letter'
        y.append(ord(x[i])-ord('A')+10);
        # print ord(x[i])-ord('A')+10;
        if (ord(x[i])-ord('A')+10)>=base:
            print("invalid input");
            quit();
    elif x[i]=='.':
        y.append(x[i]);
        # print x[i],' is a dot'
        dot_index=i;
        dot_present=1;
    else:
        print "invalid input"
        quit();

sum=0;
if dot_present==0:
    dot_index=len(x);
j=dot_index-1;
# for i in range(-(len(x)-dot_index-1),dot_index):
#     (ord(x[i])-ord('a')+10)*pow(base,i)
for i in range(0,len(y)):
    if(y[i]=='.'):
        continue;
    # print x[i],j
    sum=sum+y[i]*pow(base,j);
    if sum>999999999:
        print "Input is too large"
        quit();
    j=j-1;

if minus==1:
    print("%.6f" %-sum);
else:
    print("%.6f" %sum);
