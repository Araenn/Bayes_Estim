function [P, M] = filtKalmanEtendu(vec_t, vec_x_obs, vec_y_obs, vec_x_src, vec_y_src, vec_Y, P_0_0, tens_Q, tens_R, vec_v_src, vec_cap_src)
    t = vec_t';
    Te = 4;
    posXObs = vec_x_obs';
    posYObs = vec_y_obs';
    Y = vec_Y;
    v = vec_v_src(1); % vitesse constante
    % on cherche et position source
    % ici, obs = Y = mesures, et donc src = X

    R = tens_R;
    m(:,1) = [vec_x_src(1)-vec_x_obs(1);vec_y_src(1)-vec_y_obs(1);vec_cap_src(1)];
    P = P_0_0;
    for i = 2:length(t)
        Q = tens_Q(:,:,i);

        Frond = [m(1,i-1) + Te * v * sin(m(3,i-1)); m(2,i-1) + Te * v * cos(m(3,i-1)); m(3,i-1)];
        m(:,i) = Frond;
        F = [1 0 Te*v*cos(m(3,i)); 0 1 -Te*v*sin(m(3,i)); 0 0 1];

        P = F * P * F' + Q;
        Hrond = atan2(m(1,i),m(2,i));
        H = [m(2,i)/( m(1,i)^2+m(2,i)^2 ); -m(1,i)/( m(1,i)^2+m(2,i)^2 ); 0]';    

        K = P * H' * inv(H * P * H' + R);
        m(:,i) = m(:,i) + K * (Y(:, i) - Hrond);
        P = P - K * H * P;
    end

    M = m(1:2, end) - [vec_x_src(end)-posXObs(end); vec_y_src(end)-posYObs(end)];
%     figure(1)
%     scatter(m(1,:) + posXObs', m(2,:) + posYObs')
%     hold on
%     scatter(vec_x_src, vec_y_src)
%     scatter(posXObs, posYObs)
%     legend("Estimation", "Source", "Observateur")
%     grid on
end