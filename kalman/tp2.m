clc; clear; close all
nb_test = 1;

figure
subplot(2,2,1)
for i = 1:nb_test
    load("C:\Users\leaye\Documents\Lea\Etudes\M2\data\passif\mru_bruit_cote\test_"+ i + ".mat");

    [P1, m1(:,i)] = filtKalmanEtendu(vec_t, vec_x_obs, vec_y_obs, vec_x_src, vec_y_src, vec_Y, P_0_0, tens_Q, tens_R, vec_v_src, vec_cap_src);
end
title("MRU avec bruit à côté")

subplot(2,2,2)
for i = 1:nb_test
    load("C:\Users\leaye\Documents\Lea\Etudes\M2\data\passif\mru_cote\test_"+ i + ".mat");

    [P2, m2(:,i)] = filtKalmanEtendu(vec_t, vec_x_obs, vec_y_obs, vec_x_src, vec_y_src, vec_Y, P_0_0, tens_Q, tens_R, vec_v_src, vec_cap_src);
    
end
title("MRU sans bruit à côté")

subplot(2,1,2)
for i = 1:nb_test
    load("C:\Users\leaye\Documents\Lea\Etudes\M2\data\passif\sin_cote\test_"+ i + ".mat");

    [P4, m4(:,i)] = filtKalmanEtendu(vec_t, vec_x_obs, vec_y_obs, vec_x_src, vec_y_src, vec_Y, P_0_0, tens_Q, tens_R, vec_v_src, vec_cap_src);
    
end
title("Sin sans bruit à côté")

theta = (0:10^-2:2*pi)';


figure
subplot(2,2,1)
Eps = sqrtm(P1(1:2,1:2))*[cos(theta');sin(theta')];
plot(Eps(1,:), Eps(2,:))
hold on
scatter(m1(1,:), m1(2,:))
grid on
title("MRU avec bruit à côté")
legend("Intervalle de confiance", "Erreur pour 200 tests")

subplot(2,2,2)
Eps = sqrtm(P2(1:2,1:2))*[cos(theta');sin(theta')];
plot(Eps(1,:), Eps(2,:))
hold on
scatter(m2(1,:), m2(2,:))
grid on
title("MRU sans bruit à côté")
legend("Intervalle de confiance", "Erreur pour 200 tests")

subplot(2,1,2)
Eps = sqrtm(P4(1:2,1:2))*[cos(theta');sin(theta')];
plot(Eps(1,:), Eps(2,:))
hold on
scatter(m4(1,:), m4(2,:))
grid on
title("Sin sans bruit à côté")
legend("Intervalle de confiance", "Erreur pour 200 tests")