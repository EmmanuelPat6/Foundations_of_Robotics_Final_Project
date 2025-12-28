%Inertia Matrix
syms a1 a2 l1 l2 theta1 theta2 ml1 ml2 ml3 Il1 Il2 Il4 Im1 Im2 Im3 Im4 kr1 kr2 kr3 kr4 real

Jpl1=[-l1*sin(theta1) 0 0 0;
    l1*cos(theta1) 0 0 0;
    0 0 0 0];

Jpl2 = [-l2*sin(theta1+theta2)-a1*sin(theta1) -l2*sin(theta1+theta2) 0 0;
       l2*cos(theta1+theta2)+a1*cos(theta1) l2*cos(theta1+theta2) 0 0;
       0 0 0 0];

Jpl4 = [-a2*sin(theta1+theta2)-a1*sin(theta1) -a2*sin(theta1+theta2) 0 0;
       a2*cos(theta1+theta2)+a1*cos(theta1) a2*cos(theta1+theta2) 0 0;
       0 0 -1 0];

Jol1 = [0 0 0 0;
        0 0 0 0;
        1 0 0 0];

Jol2 = [0 0 0 0;
        0 0 0 0;
        1 1 0 0];

Jol4 = [0 0 0 0;
        0 0 0 0;
        1 1 0 -1];

Bl1 = ml1*(Jpl1'*Jpl1) + Jol1'*Il1*Jol1;
Bl2 = ml2*(Jpl2'*Jpl2) + Jol2'*Il2*Jol2;
Bl3 = ml3*(Jpl4'*Jpl4) + Jol4'*Il4*Jol4;

Bl = Bl1+Bl2+Bl3;

Nr = diag([kr1 kr2 kr3 kr4]);
Im = diag([Im1 Im2 Im3 Im4]);
Bm = Nr*Im*Nr;

B = Bl+Bm;
B = simplify(B)