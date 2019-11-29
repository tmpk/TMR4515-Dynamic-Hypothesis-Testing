function [kest, Ad, Bd, K, P] = get_ss_KF(A, B, G, C, Q, R, k2, k5, Ts)
% This function returns a state space representation of a Kalman filter, as
% well as the steady-state gain matrix and covariance matrix of the filter.
% It also returns the discrete-time system matrices Ad and Bd. 
% the input is the continuous-time system matrices A, B, G and C, covariance
% matrix Q and R of process and measurement noise, and the assumed values of
% the unknown parameters k2 and k5. Ts is the timestep

% discrete system matrices
[Ad, Bd] = c2d(A,B,Ts);     

% continuous state space model
sys = ss(A,[B G], C, 0);

% discrete Kalman estimator for the continuous plant
% K is the Kalman gain, P covariance error matrix
[kest, K, P, ~, ~] = kalmd(sys, Q, R, Ts);
