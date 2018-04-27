data=csvread('train.csv',1,0);
X=data(:,1);
y=data(:,2);
m=length(y);
%y=y/10;

X=[ones(m,1),X];
theta=[0.0;0.0];
%--------theta_direct from linear algebra------------
theta_direct=pinv(X'*X)*X'*y;
fprintf('Theta_direct:\n');
fprintf('%f\n',theta_direct);
fprintf('\nCost with theta_direct = %f\n',sum((X*theta_direct-y).^2)/2/m);
plot(X(:,2),y,'r.');
hold on;
plot(X(:,2),X*theta,'color','g');
plot(X(:,2),X*theta_direct,'color','b');
xlabel('X feature'); ylabel('y label');
title ("Step 3 and Step 4");
legend('Scatter data','Initial theta','Theta direct');
hold off;
fprintf('Press enter:\n');
pause;
%--------------gradient descent----------------------
num_iter=1000;
alpha=0.000001; %0.000001
col=['g';'b';'y';'c'];
plot(X(:,2),y,'r.');
hold on;
title("Step 4");
xlabel('X feature'); ylabel('y label');
%leg=[];
for i = 1:num_iter
	A=X*theta-y;
	for j =1:2
		theta(j)=theta(j)-alpha/m*(X(:,j)'*A);
	end
	%fprintf("%f  %f\n",theta(1),theta(2));
	%fprintf('J= %f\n',sum((X*theta-y).^2)/2/m);
	if rem(i,100)==0
		plot(X(:,2),X*theta,'color','g');
		fprintf("%d th iteration: theta= [%f ; %f] ",i,theta(1),theta(2));
		fprintf('  J = %f\n',sum((X*theta-y).^2)/2/m);
		%leg=[num2str(i);leg];
		fprintf("Press enter:\n");
		pause;
	endif;
end
legend('scatter',"learning");
hold off
fprintf('Final theta:');
fprintf(" [%f ; %f] ",theta(1),theta(2));
fprintf('  cost = %f\n',sum((X*theta-y).^2)/2/m);
plot(X(:,2),y,'r.');
hold on;
plot(X(:,2),X*theta,'g+');
title("Step 6");
legend('Scatter data','Gradient descent');
hold off;
fprintf("Press enter to continue\n\n\n");
pause;
%pause
%plot(X(:,2),y,'r.');
%hold on;
%plot(X(:,2),X*theta,'-');
%hold off;
%pause



%---------------------Visualizing cost function-----------------------
theta0_vals=linspace(-2*theta_direct(1),2*theta_direct(1),100);
theta1_vals=linspace(-2*theta_direct(2),2*theta_direct(2),100);

J_vals=zeros(length(theta0_vals),length(theta1_vals));

for i=1:length(theta0_vals)
	for j=1:length(theta1_vals)
		t=[theta0_vals(i);theta1_vals(j)];
		J_vals(i,j)=sum((X*t-y).^2)/2/m;
	end
end


J_vals=J_vals';
figure;
surf(theta0_vals,theta1_vals,J_vals);
xlabel('\theta_0'); ylabel('\theta_1');
fprintf('Press enter to finish\n');
pause;

%------------------------------Test data---------------------------------
test_data=csvread('test.csv',1,0);
X_test=test_data(:,1);
y_test=test_data(:,2);
m_test=length(y_test);
X_test=[ones(m_test,1),X_test];

y_pred1=X_test*theta;
y_pred2=X_test*theta_direct;
rms1=sum((y_pred1-y_test).^2)/m_test;
rms1=sqrt(rms1);
fprintf("Root mean squared error using gradient descent = %f\n",rms1);

rms2=sum((y_pred2-y_test).^2)/m_test;
rms2=sqrt(rms2);
fprintf("Root mean squared error using theta_direct = %f\n",rms2);
