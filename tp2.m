clc; clear; close all


for i = 1:200
    load("test_"+ i + ".mat");

    [P, m(:,i)] = filtKalmanEtendu(vec_t, vec_x_obs, vec_y_obs, vec_x_src, vec_y_src, vec_Y, P_0_0, tens_Q, tens_R, vec_v_src, vec_cap_src);
    
end

theta = (0:10^-2:2*pi)';
Eps = sqrtm(P(1:2,1:2))*[cos(theta');sin(theta')];


figure(2)
plot(Eps(1,:), Eps(2,:))
hold on
scatter(m(1,:), m(2,:))
grid on