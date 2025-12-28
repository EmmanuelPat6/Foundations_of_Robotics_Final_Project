%Kinematic Model
syms theta1 theta2 d3 theta4 a1 a2

A01 = [cos(theta1),-sin(theta1),0,a1*cos(theta1);
    sin(theta1),cos(theta1),0,a1*sin(theta1);
    0,0,1,0;
    0,0,0,1];

A12 = [cos(theta2),-sin(theta2)*cos(pi),0,a2*cos(theta2);
    sin(theta2),cos(theta2)*cos(pi),0,a2*sin(theta2);
    0,0,-1,0;
    0,0,0,1];

A23 = [1,0,0,0;
    0,1,0,0;
    0,0,1,d3;
    0,0,0,1];

A34 = [cos(theta4),-sin(theta4),0,0;
    sin(theta4),cos(theta4),0,0;
    0,0,cos(pi),0;
    0,0,0,1];

T04 = A01*A12*A23*A34;
T04 = simplify(T04);