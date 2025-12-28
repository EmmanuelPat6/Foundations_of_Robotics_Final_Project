function B = BComputation(q)
    
    %m
    a1 = 0.5;
    a2 = 0.5;
    l1 = 0.25;
    l2 = 0.25;
    
    %kg
    ml1 = 20;
    ml2 = 20;
    ml3 = 10;
    
    %kg*m^2
    Il1 = 4;
    Il2 = 4;
    Il4 = 1;
    
    %rad/m
    kr1 = 1;
    kr2 = 1;
    kr3 = 50;
    kr4 = 20;
    
    %kg*m2
    Im1 = 0.01;
    Im2 = 0.01;
    Im3 = 0.005;
    Im4 = 0.001;

    %B = Bl + Bm
    
    %Jacobians
    Jpl1 = [-l1*sin(q(1)) 0 0 0;
           l1*cos(q(1)) 0 0 0;
           0 0 0 0];

    Jpl2 = [-l2*sin(q(1)+q(2))-a1*sin(q(1)) -l2*sin(q(1)+q(2)) 0 0;
           l2*cos(q(1)+q(2))+a1*cos(q(1)) l2*cos(q(1)+q(2)) 0 0;
           0 0 0 0];

    Jpl4 = [-a2*sin(q(1)+q(2))-a1*sin(q(1)) -a2*sin(q(1)+q(2)) 0 0;
           a2*cos(q(1)+q(2))+a1*cos(q(1)) a2*cos(q(1)+q(2)) 0 0;
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

end