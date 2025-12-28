function J = jacobian(q)

    a1 = 0.5;
    a2 = 0.5;
    
    J = [-a2*sin(q(1)+q(2))-a1*sin(q(1)) -a2*sin(q(1)+q(2)) 0 0;
        a2*cos(q(1)+q(2))+a1*cos(q(1)) a2*cos(q(1)+q(2)) 0 0;
        0 0 -1 0;
        1 1 0 -1];

end