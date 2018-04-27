
import numpy as np
import matplotlib.pyplot as plt
data=np.loadtxt('train.csv',delimiter=',',skiprows=1)
X=data[:,0]
y=data[:,1]
X=X.reshape(X.size,1) #reshape from an arrsy to a matrix of one column
y=y.reshape(y.size,1)
y=y/10.0;
ones=np.ones((X.shape)).reshape(X.size,1)
X=np.hstack((ones,X)); #add a column of ones in X
theta=np.array([[0],[0]]);

plt.plot(X[:,1],y,'ro');
plt.xlabel('features')
plt.ylabel('labels')
plt.title("Blue: Initial theta, green: Trained by Linear algebra")
line=X.dot(theta);
plt.plot(X[:,1],line,'b-')
theta_new=np.linalg.inv(X.T.dot(X)).dot(X.T.dot(y));
plt.plot(X[:,1],X.dot(theta_new),'g-')
plt.show()

#---------gradient descent--------------
plt.plot(X[:,1],y,'ro');
plt.xlabel('features')
plt.ylabel('labels')
plt.title("Being trained")
for i in range(0,1100):
    A=(X.dot(theta)-y);
    theta=theta-0.0000000001*(A.T.dot(X)).T
    if i%100==0:
        print(theta);
        line=X.dot(theta);
        plt.plot(X[:,1],line)
plt.show()
#---------------------------------------------
plt.plot(X[:,1],y,'ro');
plt.xlabel('features')
plt.ylabel('labels')
plt.title("Trained by gradient descent")
line=X.dot(theta);
plt.plot(X[:,1],line,'b-')
plt.show()
#------------standard deviation for test set---------------------
data=np.loadtxt('test.csv',delimiter=',',skiprows=1)
X=data[:,0]
y=data[:,1]
X=X.reshape(X.size,1) #reshape from an arrsy to a matrix of one column
y=y.reshape(y.size,1)
y=y/10.0;
ones=np.ones((X.shape)).reshape(X.size,1)
X=np.hstack((ones,X)); #add a column of ones in X

std1=(((X.dot(theta_new)-y)*10)**2).sum(); #theta_new is obtained by linear algebra
std1=std1/y.size;
std1=std1**0.5;
print "std1=",std1;

std2=(((X.dot(theta)-y)*10)**2).sum(); #theta is rsult of gradient descent
std2=std2/y.size;
std2=std2**0.5;
print "std2=",std2;
