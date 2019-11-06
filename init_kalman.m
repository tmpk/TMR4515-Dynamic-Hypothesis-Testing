% parameters
J_M1 = 1;
J_M2 = 1;
J_L1 = 1;
J_L2 = 1;
k1 = 0.15;
k2 = 1.625;
k3 = 0.1;
k4 = 0.1;
k5 = 1.7;
Ts = 0.001;
b1 = 0.1; b2 = 0.1; b3 = 0.1; b4 =0.1; b5 = 0.1;

% continuous system matrices
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
Qn = eye(2);

% discrete system matrices, computed here and used in kalm
[Ad, Bd] = c2d(A,B,Ts);     % discrete A and B matrices
[~, Gd] = c2d(A,G,Ts);      % discrete G matrix

% Covariance for process noise with unity intensity; continous time:
Q = 1*eye(2);

% Covariance for measurement noise with 10^-6 intensity; continuous time:
R = 10^-6*eye(2);       

% Calculations for discrete time process noise covariance:
Q = G*Q*G'; 
F = [-A Q; 
    zeros(10) A'];
H = expm(F*Ts);
H12 = H(1:10,11:20);
H22 = H(11:20,11:20);

Qd = H22'*H12;      % discrete process noise covariance
%Qd = Qd(9:10,9:10);
Rd = R/Ts;          % discrete measurement noise covariance

%%%% get the discrete kalman filter from kalmd:
% continuous state space model
sys = ss(A,[B G], C, 0);

% discrete Kalman estimator for the continuous plant
% K_inf is the Kalman gain, and is precomputed here for use in kalm2
[kest, K_inf, P, M, Z] = kalmd(sys, Qn, R, Ts);

%save(matrices.mat, PHI, DELTA, GAMMA, C, L);