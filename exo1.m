clc; clear; close all

N = 6;


n = 10000;

for i = 1:n
    norm_mu = 7*rand;
    mu = randn(N,1);
    mu = mu/sqrt(sum(mu.^2))*norm_mu;
    B = randn(N,1);
    X = mu + B;
    
    mu_MV(i,:) = (X);
    mu_JS(i,:) = (1 - (N - 2)/norm(X) ) * (X);
end

for i = 1:N
    EQM_MV(i,:) = mean( (mu_MV(i,:)'-mu).^2 );
    EQM_JS(i,:) = mean( (mu_JS(i,:)'-mu)'*(mu_JS(i,:)'-mu) );
    E2(i,:) = mean((mu_MV(i,:)'-mu)'*(mu_MV(i,:)'-mu));
    E3(i,:) = mean( (mu_JS(i,:)'-mu).^2 );
end


figure(1)
plot(EQM_MV)
hold on
plot(EQM_JS)
plot(E2)
plot(E3)
grid()
legend("MV", "JS")
title("EQM selon la valeur de \mu")
xlabel("\mu")
ylabel("EQM")