% This script sets up the necessary discrete-time matrices for 
% implementation of the Kalman filter, and must be run after
% "Load/Parameters" in the simulink file.
%
% First the continuous system is defined and discretized along with the
% noise covariance matrices in order to implement a Kalman filter with a
% time-varying gain matrix.
%
% Then, for each hypothesis, the system is discretized by the MATLAB 
% function kalmd through the call to get_ss_KF, which returns the discrete 
% system matrices and the steady-state gain matrix, as well as the steady-
% state error covariance P
%% parameters
J_M1 = 1;
J_M2 = 1;
J_L1 = 1;
J_L2 = 1;
k1 = 0.15;
k2 = 1.625; % assumed to be in center of interval [0.75, 2.5]
k3 = 0.1;
k4 = 0.1;
k5 = 1.7;   % assumed to be in center of interval [0.9, 2.5]
Ts = 0.001;
b1 = 0.1; b2 = 0.1; b3 = 0.1; b4 =0.1; b5 = 0.1;

% continuous-time system matrices
A = [zeros(4,4) eye(4) zeros(4,2);
    -(k1+k2+k3)/J_L1 k2/J_L1 k3/J_L1 0 -(b1+b2+b3)/J_L1 b2/J_L1 b3/J_L1 0 1/J_L1 0;
    k2/J_M1 -(k2+k4)/J_M1 0 k4/J_M1 b2/J_M1 -(b2+b4)/J_M1 0 b4/J_M1 0 0;
    k3/J_M2 0 -(k3+k5)/J_M2 k5/J_M2 b3/J_M2 0 -(b3+b5)/J_M2 b5/J_M2 0 0;
    0 k4/J_L2 k5/J_L2 -(k4+k5)/J_L2 0 b4/J_L2 b5/J_L2 -(b4+b5)/J_L2 0 1/J_L2;
    0 0 0 0 0 0 0 0 -0.2 0;
    0 0 0 0 0 0 0 0 0 -0.2];
B = zeros(10,2);
B(6,1)=1/J_M1;
B(7,2)=1/J_M1;
G = zeros(10,2);
G(9,1)=0.2;
G(10,2)=0.2;
C = zeros(2,10);
C(1,1)=1;
C(2,4)=1;

% discrete system matrices
[Ad, Bd] = c2d(A,B,Ts);     

% Covariance for process noise; continous time:
Q = XI;

% Covariance for measurement noise; continuous time:
R = TH;       

%% Calculations for discrete time noise covariance, from van Loan's method:
Q_ = G*Q*G'; 
F = [-A Q_; 
    zeros(10) A'];
H = expm(F*Ts);
H12 = H(1:10,11:20);
H22 = H(11:20,11:20);

Qd = H22'*H12;      % discrete process noise covariance
Rd = R/Ts;          % discrete measurement noise covariance

%% get the necessary discrete-time kalman filter matrices according to each hypothesis:
% hypothesis 1: 
k2 = 2;
k5 = 2;
A = [zeros(4,4) eye(4) zeros(4,2);
    -(k1+k2+k3)/J_L1 k2/J_L1 k3/J_L1 0 -(b1+b2+b3)/J_L1 b2/J_L1 b3/J_L1 0 1/J_L1 0;
    k2/J_M1 -(k2+k4)/J_M1 0 k4/J_M1 b2/J_M1 -(b2+b4)/J_M1 0 b4/J_M1 0 0;
    k3/J_M2 0 -(k3+k5)/J_M2 k5/J_M2 b3/J_M2 0 -(b3+b5)/J_M2 b5/J_M2 0 0;
    0 k4/J_L2 k5/J_L2 -(k4+k5)/J_L2 0 b4/J_L2 b5/J_L2 -(b4+b5)/J_L2 0 1/J_L2;
    0 0 0 0 0 0 0 0 -0.2 0;
    0 0 0 0 0 0 0 0 0 -0.2];
[kest_1, Ad_1, Bd_1, Kgain_1, P_1] = get_ss_KF(A,B,G,C,Q,R,k2,k5,Ts);
% hypothesis 2:
k2 = 1;
k5 = 1.75;
A = [zeros(4,4) eye(4) zeros(4,2);
    -(k1+k2+k3)/J_L1 k2/J_L1 k3/J_L1 0 -(b1+b2+b3)/J_L1 b2/J_L1 b3/J_L1 0 1/J_L1 0;
    k2/J_M1 -(k2+k4)/J_M1 0 k4/J_M1 b2/J_M1 -(b2+b4)/J_M1 0 b4/J_M1 0 0;
    k3/J_M2 0 -(k3+k5)/J_M2 k5/J_M2 b3/J_M2 0 -(b3+b5)/J_M2 b5/J_M2 0 0;
    0 k4/J_L2 k5/J_L2 -(k4+k5)/J_L2 0 b4/J_L2 b5/J_L2 -(b4+b5)/J_L2 0 1/J_L2;
    0 0 0 0 0 0 0 0 -0.2 0;
    0 0 0 0 0 0 0 0 0 -0.2];
[kest_2, Ad_2, Bd_2, Kgain_2, P_2] = get_ss_KF(A,B,G,C,Q,R,k2,k5,Ts);
% hypothesis 3:
k2 = 2;
k5 = 1.25;
A = [zeros(4,4) eye(4) zeros(4,2);
    -(k1+k2+k3)/J_L1 k2/J_L1 k3/J_L1 0 -(b1+b2+b3)/J_L1 b2/J_L1 b3/J_L1 0 1/J_L1 0;
    k2/J_M1 -(k2+k4)/J_M1 0 k4/J_M1 b2/J_M1 -(b2+b4)/J_M1 0 b4/J_M1 0 0;
    k3/J_M2 0 -(k3+k5)/J_M2 k5/J_M2 b3/J_M2 0 -(b3+b5)/J_M2 b5/J_M2 0 0;
    0 k4/J_L2 k5/J_L2 -(k4+k5)/J_L2 0 b4/J_L2 b5/J_L2 -(b4+b5)/J_L2 0 1/J_L2;
    0 0 0 0 0 0 0 0 -0.2 0;
    0 0 0 0 0 0 0 0 0 -0.2];
[kest_3, Ad_3, Bd_3, Kgain_3, P_3] = get_ss_KF(A,B,G,C,Q,R,k2,k5,Ts);