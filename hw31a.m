%State Matricies 
a = [0,1;-0.9801,1.6];                       %Matrix A
 
b = [0,1]';                                 %Matrix B
 
k = [1:1:1000]';                             %Time Index
 
u = ones(size(k));                          %Unit Step
 
x0 = [0,0]';                                %Initial Conditons
 
[ki x] = discrete_time_sys(a,b,x0,u);       
 
plot(ki,x)                                  %Plotting State Variables
 
xlabel('Time');
 
ylabel('Amplitude');
legend('x1','x2');
figure
plot(ki,x(:,1))
xlabel('Time');
ylabel('Amplitude');
legend('x1');
figure
plot(ki,x(:,2))
xlabel('Time');
ylabel('Amplitude');
legend('x2');
function[ki,x] = discrete_time_sys(a,b,x0,u)
    N = size(u);                        %N = 100s
    
    ki(1) = 1;                          %Time Index ki
    
    n = size(x0);                               
    
    x = zeros(N(1),n(1)); x(1,:) = x0'; %Initalizing State variable & x(0)
    
    for k = 1:N(1)-1                    %Loop for calculation of State variables
    
        ki(k+1) = k+1;
        
        x(k+1,:) = (a*x(k,:)'+ b*u(k,:)')';
    end
    
    ki = ki';
    
   

end