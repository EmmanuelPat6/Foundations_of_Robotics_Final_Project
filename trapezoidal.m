function [s, sdot ,sdotdot] = trapezoidal(pi,pf,t1,t2,tf,is_circ,is_via,radius,alpha,delta)

si=0;   %Initial Position
dt=t2-t1;   %Time Interval
t=0:0.001:dt;

%Inizialization of the variables for position, velocity and acceleration
sp = zeros(1,length(t));
sdotp = zeros(1,length(t));
sdotdotp = zeros(1,length(t));

l = tf/0.001 + 1;    %Number of time points
s = zeros(1,length(l)); %Final Position Array
sdot = zeros(1,length(l));  %Final Velocity Array
sdotdot = zeros(1,length(l));   %Final Acceleration Array

%Circular Trajectory
if is_circ == 1
    sf = alpha*radius;  %Final Position for Circular Path
else
    sf = norm(pf-pi);   %Final Position for Linear Path
end

sdot_c = 1.5*abs(sf-si)/dt; %Cruise Speed
%1.5 is an Empirical Factor for smooth transition

tc = (si-sf+sdot_c*dt)/sdot_c;  %Time to reach cruise speed
sdotdot_c=sdot_c/tc;    %Acceleration to reach cruise speed

%Trapezoidal Profile
for k=1:length(t)

    %Acceleration Phase
    if t(k)<=tc
        sp(k)=si+0.5*sdotdot_c*t(k).^2; %Position
        sdotp(k)=sdotdot_c*t(k);    %Velocity
        sdotdotp(k)=sdotdot_c;  %Acceleration

    %Constant Speed Phase
    elseif (t(k)>tc && t(k)<=dt-tc) 
        sp(k)=si+sdotdot_c*tc*(t(k)-tc/2);  %Position  
        sdotp(k)=sdot_c;    %Velocity    
        sdotdotp(k)=0;  %Acceleration

    %Deceleration Phase
    elseif (t(k)>dt-tc && t(k)<=dt)
        sp(k)=sf-0.5*sdotdot_c*(dt-t(k))^2; %Position
        sdotp(k)=sdotdot_c*(dt-t(k));   %Velocity
        sdotdotp(k)=-sdotdot_c; %Acceleration
    end

end

%Time Interval for each Phase
tr = 0:0.001:t1;    %Time for Acceleration
ts = t1+0.001:0.001:t2; %Time for Constant Speed
td = t2+0.001:0.001:tf; %Time for Deceleration

%Via Point

if is_via == 0  %No Via Point 
    s(1:length(tr)) = 0;    %Initial Position
    s(length(tr)+1:length(tr)+length(ts)+1) = sp;   %Assign Computed Position
    s(length(tr)+length(ts):length(tr)+length(ts)+length(td)) = sf; %Final Position
    
    sdot(1:length(tr)) = 0; %Initial Velocity
    sdot(length(tr)+1:length(tr)+length(ts)+1) = sdotp; %Assign Computed Velocity
    sdot(length(tr)+length(ts):length(tr)+length(ts)+length(td)) = 0;   %Final Velocity
    
    sdotdot(1:length(tr)) = 0;  %Initial Acceleration
    sdotdot(length(tr)+1:length(tr)+length(ts)+1) = sdotdotp;   %Assign Computed Acceleration
    sdotdot(length(tr)+length(ts):length(tr)+length(ts)+length(td)) = 0;    %Final Acceleration

else    %With Via Point
    dp = delta/0.001;  %Dt'*1000

    %Same steps as before subtracting Dt'
    s(1:(length(tr))-dp) = 0;
    s(length(tr)+1-dp:length(tr)+length(ts)+1-dp) = sp;
    s(length(tr)+length(ts)-dp:length(tr)+length(ts)+length(td)) = sf;
    
    sdot(1:length(tr)-dp) = 0;
    sdot(length(tr)+1-dp:length(tr)+length(ts)+1-dp) = sdotp;
    sdot(length(tr)+length(ts)-dp:length(tr)+length(ts)+length(td)) = 0;
    
    sdotdot(1:length(tr)-dp) = 0;
    sdotdot(length(tr)+1-dp:length(tr)+length(ts)+1-dp) = sdotdotp;
    sdotdot(length(tr)+length(ts)-dp:length(tr)+length(ts)+length(td)) = 0;
end

end