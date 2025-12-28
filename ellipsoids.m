function [] = ellipsoids(robot,q)

    scara_parameters;
    
    % figure
    % robot.plot(q);
    % xlim([-4,4]); ylim([-4,4]); zlim([-2,1]);
    % robot.vellipse(q,'2d', 'b');
    % robot.fellipse(q, '2d', 'r');
    % title ('Manipulability Ellipsoids');
    % grid on;
    % 
    %Computation of end-effector position
    px = a1*cos(q(1))+a2*cos(q(1)+q(2));
    py = a1*sin(q(1))+a2*sin(q(1)+q(2));
    
    Jp = [-a2*sin(q(1)+q(2))-a1*sin(q(1)) -a2*sin(q(1)+q(2));
          a2*cos(q(1)+q(2))+a1*cos(q(1))  a2*cos(q(1)+q(2))];
    
    %It is used the singular value decomposition (SVD) to get singular values,
    % which are used to define the axes of the manipulability ellipsoid.
    [V,D]=eig(Jp*Jp'); %The eigenvectors are the same as those of (J*J')^(-1); the eigenvalues, however, are their reciprocals
    sv = svd(Jp); %The singular values are ordered in descending order
    xe = sv(1); %Associated to the second eigenvector
    ye = sv(2); %Associated to the first eigenvector
    
    %2D Manipulator
    figure
    plot([0,a1*cos(q(1)),px],[0,a1*sin(q(1)),py],'k-o','LineWidth',2,'MarkerFaceColor',[0.5 0.5 0.5],'MarkerSize',5) 
    % First link: Starts from the origin (0, 0) and reaches the first joint (a1*cos(q(1)), a1*sin(q(1))).
    % Second link: Starts from the first joint and reaches the end of the second link, i.e., the position of the end-effector (px, py).
    axis([-1.5 1.5 -1.5 1.5]);
    grid on
    hold on
    
    %Velocity Manipulability Ellipsoid
    vme = [V(:,2) V(:,1)]*[xe*cosd(0:360)/2; ye*sind(0:360)/2];
    plot(px+vme(1,:),py+vme(2,:),'b-');
    hold on
    
    %Force Manipulability Ellipsoid (Kineto-Static Duality)
    fme = [V(:,2) V(:,1)]*[ye*cosd(0:360)/2;xe*sind(0:360)/2];
    plot(px+fme(1,:),py+fme(2,:),'r-')
    
    legend('SCARA','Velocity Manipulability Ellipsoid','Force Manipulability Ellipsoid')

end