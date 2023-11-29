function [P, M] = filtKalman(vec_t, vec_x_obs, vec_y_obs, vec_x_src, vec_y_src, vec_Y, P_0_0, tens_Q, tens_R)

    t = vec_t';
    Te = 10;
    posXObs = vec_x_obs';
    posYObs = vec_y_obs';
    vitXObs = zeros(length(t), 1);
    vitYObs = zeros(size(vitXObs));
    Y = vec_Y;
    % on cherche vitesse et position source
    % ici, obs = Y = mesures, et donc src = X

    F = [1, 0, Te 0; 0, 1, 0, Te; 0, 0, 1, 0; 0, 0, 0, 1];
    H = [1 0 0 0; 0 1 0 0];


    m(:,1) = randn(4,1);
    P = P_0_0;
    for i = 2:length(t)
        Q = tens_Q(:,:,i);
        R = tens_R;

        m(:,i) = F * m(:,i-1);
        P = F * P * F' + Q;
        K = P * H' * inv(H * P * H' + R);
        m(:,i) = m(:,i-1) + K * (Y(:, i) - H * m(:,i-1));
        P = P - K * H * P;
    end

    M = m(1:2, end) - [vec_x_src(end)-posXObs(end); vec_y_src(end)-posYObs(end)];
%     figure(1)
%     scatter(m(1,:) + posXObs', m(2,:)+posYObs')
%     hold on
%     scatter(vec_x_src, vec_y_src)
%     scatter(posXObs, posYObs)
%     legend("Estimation", "Source", "Observateur")
%     grid on
end