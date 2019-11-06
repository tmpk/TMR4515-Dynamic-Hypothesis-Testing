function [y_hat, x_hat] = kalm(y,u)

TH1=10^-6; TH2=10^-6;
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

persistent P_
if isempty(P_)
    P_ = zeros(10,10);
end

A = [zeros(4,4) eye(4) zeros(4,2);
    -(k1+k2+k1)/J_L1 k2/J_L1 k3/J_L1 0 -(b1+b2+b3)/J_L1 b2/J_L1 b3/J_L1 0 1/J_L1 0;
    k2/J_M1 -(k2+k4)/J_M1 0 k4/J_M1 b2/J_M1 -(b2+b4)/J_M1 0 b4/J_M1 0 0;
    k3/J_M2 0 (-k3+k5)/J_M2 k5/J_M2 b3/J_M2 0 -(b3+b5)/J_M2 b5/J_M2 0 0;
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

Q = 1*eye(2);       % unity intensity on process noise
R = 10^-6*eye(2);   % 10^-6 intensity on measurement noise
    
%sys = ss(A,[B G], C, 0);

%[kest, L, P, M, Z] = kalmd(sys, Q, R, Ts);

persistent x
if isempty(x)
    x = zeros(10,1);
end


PHI =     [1.0000    0.0000    0.0000    0.0000    0.0010    0.0000    0.0000    0.0000    0.0000    0.0000
    0.0000    1.0000    0.0000    0.0000    0.0000    0.0010    0.0000    0.0000    0.0000    0.0000
    0.0000    0.0000    1.0000    0.0000    0.0000    0.0000    0.0010    0.0000    0.0000    0.0000
    0.0000    0.0000    0.0000    1.0000    0.0000    0.0000    0.0000    0.0010    0.0000    0.0000
   -0.0019    0.0016    0.0001    0.0000    0.9997    0.0001    0.0001    0.0000    0.0010    0.0000
    0.0016   -0.0017    0.0000    0.0001    0.0001    0.9998    0.0000    0.0001    0.0000    0.0000
    0.0001    0.0000    0.0016    0.0017    0.0001    0.0000    0.9998    0.0001    0.0000    0.0000
    0.0000    0.0001    0.0017   -0.0018    0.0000    0.0001    0.0001    0.9998    0.0000    0.0010
         0         0         0         0         0         0         0         0    0.9998         0
    0.0000    0.0000    0.0000   -0.0000    0.0000    0.0000    0.0000    0.0010    0.0000    0.9998];

DELTA = 1.0e-03*[ 0.0000    0.0000
    0.0005    0.0000
    0.0000    0.0005
    0.0000    0.0000
    0.0001    0.0001
    0.9999    0.0000
    0.0000    0.9999
    0.0001    0.0001
         0         0
    0.0000    0.0000];

GAMMA = 1.0e-03* [0.0000    0.0000
    0.0000    0.0000
    0.0000    0.0000
    0.0000    0.0000
    0.0001    0.0000
    0.0000    0.0000
    0.0000    0.0000
    0.0000    0.0001
    0.2000         0
    0.0000    0.2000];

K = P_*transpose(C)*inv(C*P_*transpose(C)+R);
x_hat = x + K*(y-C*x);
P_hat = (eye(10)-K*C)*P_*transpose(eye(10)-K*C)+K*R*transpose(K);

x = PHI*x_hat+DELTA*u;
P_ = PHI*P_hat*transpose(PHI)+GAMMA*Q*transpose(GAMMA);

x_hat = x;
y_hat = C*x;

end
