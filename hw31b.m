%state matricies

a = [0,1;-0.9801,1.6];                          %Matrix A
 
b = [0,1]';                                     %Matrix B
 

 
x0 = [0 0]';                                    %Initial State x(0)
 
k = [1:1:100]';                                 %Time Index
 
u = ones(size(k));                              %Unit Step input
 
[ki,x] = disc_time_sys_wnoise(a,b,x0,u);
 
plot(ki,x)                                      %Plotting State Variables
 
xlabel('Time');
 
ylabel('Amplitude');

function [ki,x] = disc_time_sys_wnoise(a,b,x0,u)
 
    N = size(u);                                    %N = 100
    
    n = size(x0);                                   
    
    ki(1) = 1;
    
    x = zeros(N(1),n(1));                           %Initializing States
    
    x(1,:) = x0';                                   %x(0)
    
    r = sqrt(0.1)*randn(N(1),2);                    %Process noise with Covar=0.1
    
    for k = 1:N(1)-1                                %Calculating State Vatiables
    
        ki(k+1) = k+1;
        
        x(k+1,:) = (a*x(k,:)' + b*u(k,:)' + r(k,:)')';
    end
    
    ki =ki';
end