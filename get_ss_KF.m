function [Ad, Bd, Kgain, P] = get_ss_KF(A, B, G, C, Q, R, k2, k5, Ts)

% discrete system matrices
[Ad, Bd] = c2d(A,B,Ts);     % discrete A and B matrices

% continuous state space model
sys = ss(A,[B G], C, 0);

% discrete Kalman estimator for the continuous plant
% K_inf is the Kalman gain
[kest, Kgain, P, M, Z] = kalmd(sys, Q, R, Ts);
