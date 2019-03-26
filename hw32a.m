clc;
uk=xlsread('hwk RLS ID data.xls','C4:C604');
yk=xlsread('hwk RLS ID data.xls','E4:E604');

d = 2;
n = 2;
ht = zeros(601,3);
%Calculation of Regression Matrix


for k = 3:601
    ht(k,:) = [-yk(k-1) -yk(k-2) uk(k-2)];
end

sigma = 0.1;
p1 = 1000*eye(3);
theta_cap = zeros(3,601);% Initial Estimates
%Calculation of Pk & Theta_Cap Using RLS Algorithm
for k = 2:600
    pk = p1 - p1*ht(k+1,:)'*(inv(ht(k+1,:)*p1*ht(k+1,:)'+ sigma))*ht(k+1,:)*p1;
    theta_cap(:,k+1) = theta_cap(:,k)+(pk*(ht(k+1,:)'/sigma)*(yk(k+1,1)-(ht(k+1,:)*theta_cap(:,k))));
p1 = pk;
end
ye = ht*theta_cap;
ye = diag(ye); %Y estimate
% Difference of estimate and given output (Error in Estimation)
diff = ye-yk;
figure
plot(diff)

%System Transfer function
theta_cap(:,601)
num=[0 0 theta_cap(3,601)];
den=[1 theta_cap(1,601) theta_cap(2,601)];
sys=filt(num,den)
%simulating the obtained transfer function using the input
out= lsim(sys,uk,1:601);
figure
plot (1:601,out)
hold on
plot (3:603,yk)
hold off
