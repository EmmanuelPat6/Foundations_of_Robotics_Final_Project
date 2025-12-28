function w = manipulability_measure(q)

scara_parameters;

J = jacobian(q);
Jt = J';

w = (sqrt(det(J*Jt)));

end