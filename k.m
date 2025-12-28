function x = k(q)

a1 = 0.5;
a2 = 0.5;
d0 = 1;

x =[a2*cos(q(1)+q(2))+a1*cos(q(1));
   a2*sin(q(1)+q(2))+a1*sin(q(1));
   d0-q(3);
   q(1)+q(2)-q(4)];

end