clc;
clear all;
close all;
name = "Matlab";
Client = TCPInit('127.0.0.1',55001,name);

x=0; % Roll -90
y=180; % Pitch 0
z=0; % Yaw 0
RR = compose_rotation(x, y, z)

L1 = 123.32; L2 = 577.32; L3 = 949.04; L4 = 227.79; L5 = 918.09; L6 = 740.36;

T = [RR(1,1)    RR(1,2)   RR(1,3)    1387.26
     RR(2,1)    RR(2,2)   RR(2,3)    627.8
     RR(3,1)    RR(3,2)   RR(3,3)    106.212
     0    0    0    1.0000];
     
R = [T(1,1)    T(1,2)   T(1,3)
     T(2,1)    T(2,2)   T(2,3)
     T(3,1)    T(3,2)   T(3,3)]; 

o = [T(1,4); T(2,4); T(3,4)];

xc = o(1) - L6*R(1,3);
yc = o(2) - L6*R(2,3);
zc = o(3) - L6*R(3,3);

% find thetha1
thetha1 = atan2d(yc,xc)

% find thetha3
a = sqrt(L4^2+L5^2);
r = sqrt(xc^2+yc^2)-L1;
s = zc - L2; 
b = sqrt(r^2+s^2);
D = (L3^2+a^2-b^2)/(2*L3*a);
fi = acosd(D);
beta = 180 - fi;
alpha = atan2d(L4 ,L5);
% thetha3 = beta - alpha + 90 % config I
thetha3 = -(beta + alpha) + 90 % config II

% find thetha2
fi2 = atan2d(s,r); 
D1 = (L3^2 + b^2 - a^2)/(2*L3*b);
fi1 = acosd(D1);
% thetha2 = fi2 - fi1 % config I
thetha2 = (fi1 + fi2) % config II

% find thetha4, thetha5, thetha6
alpha1 = 90; alpha2 = 0; alpha3 = 90;
r1 = L1; r2 = L3; r3 = L4;
d1 = L2; d2 = 0; d3 = 0; 

T1 = [cosd(thetha1) -sind(thetha1)*cosd(alpha1) sind(thetha1)*sind(alpha1) r1*cosd(thetha1);
      sind(thetha1) cosd(thetha1)*cosd(alpha1) -cosd(thetha1)*sind(alpha1) r1*sind(thetha1);
      0 sind(alpha1) cosd(alpha1) d1;
      0 0 0 1];
T2 = [cosd(thetha2) -sind(thetha2)*cosd(alpha2) sind(thetha2)*sind(alpha2) r2*cosd(thetha2);
      sind(thetha2) cosd(thetha2)*cosd(alpha2) -cosd(thetha2)*sind(alpha2) r2*sind(thetha2);
      0 sind(alpha2) cosd(alpha2) d2;
      0 0 0 1];
T3 = [cosd(thetha3) -sind(thetha3)*cosd(alpha3) sind(thetha3)*sind(alpha3) r3*cosd(thetha3);
      sind(thetha3) cosd(thetha3)*cosd(alpha3) -cosd(thetha3)*sind(alpha3) r3*sind(thetha3);
      0 sind(alpha3) cosd(alpha3) d3;
      0 0 0 1];
 
T03 = T1*T2*T3;
R03 = [T03(1,1)    T03(1,2)   T03(1,3)
       T03(2,1)    T03(2,2)   T03(2,3)
       T03(3,1)    T03(3,2)   T03(3,3)];

R03T = R03.'; 
R36 = R03T*R;

% find thetha5
thetha5 = acosd(-R36(3,3))-180

% find thetha4
thetha4 = atan2d(-R36(2,3),-R36(1,3))

% find thetha6
thetha6 = atan2d(-R36(3,2),R36(3,1))

alpha1 = 90; alpha2 = 0; alpha3 = 90; alpha4 = 270; alpha5 = 90; alpha6 = 0;
r1 = L1; r2 = L3; r3 = L4; r4 = 0; r5 = 0; r6 = 0; 
d1 = L2; d2 = 0; d3 = 0; d4 = L5; d5 = 0; d6 = L6;

L(1) = Revolute('d',d1,'a',r1,'alpha',alpha1*pi/180);
L(2) = Revolute('d',d2,'a',r2,'alpha',alpha2*pi/180);
L(3) = Revolute('d',d3,'a',r3,'alpha',alpha3*pi/180);
L(4) = Revolute('d',d4,'a',r4,'alpha',alpha4*pi/180);
L(5) = Revolute('d',d5,'a',r5,'alpha',alpha5*pi/180);
L(6) = Revolute('d',d6,'a',r6,'alpha',alpha6*pi/180);
robot = SerialLink(L);
joints = [thetha1*pi/180,thetha2*pi/180,thetha3*pi/180,thetha4*pi/180,thetha5*pi/180,thetha6*pi/180];
robot.plot(joints);
robot.teach(joints);

%% trajectory calculation (RTB function)
qi1 = joints; % ik position
qf1 = [0,90*pi/180,0,0,-90*pi/180,0]; % init position
t = [0:0.1:2];
q = jtraj(qf1,qi1,t); % traj points
robot.plot(q); % plot traj

%% trajectory calculation (manual function)
Tm= 40; % trajectory steps
qi1 = joints; % ik position
qf1 = [0,90*pi/180,0,0,-90*pi/180,0]; % init position
q = (qi1 - qf1) / Tm; % traj points
for a = 0 : 40
    % robot.plot(qf1); % plot traj 
    func_data(Client, qf1); % send data to unity
    qf1 = qf1 + q;
end
% robot.teach(joints);
%% take object
grab = 1;
func_grab(Client, grab);% send data to unity
pause(4.5);
%%
color = color_check(Client); % function for detecting colors

if color == 1 % Red sorting
    X2 = 0.4727;
    Y2 = -0.063;
    Z2 = 0+0.04;
elseif color == 2 % Green sorting
    X2 = 0.4727;
    Y2 = -0.207;
    Z2 = 0+0.08;
else % Blue sorting
    X2 = 0.334;
    Y2 = -0.207;
    Z2 = 0+0.2;
end
%% back to init pos
for a = 1 : 40
    % robot.plot(qf1); % plot traj   
    func_data(Client, qf1); % send data to unity
    qf1 = qf1 - q;
end
%% release object
grab = 0;
func_grab(Client, grab); % send data to unity
pause(0.5);
%%
clc;
clear all;
close all;
name = "Matlab";
Client = TCPInit('127.0.0.1',55001,name);
%
L1 = 0.0411; L2 = 0.192; L3 = 0.3163; L4 = 0.0759; L5 = 0.306; L6 = 0.233;
thetha1 = 0; thetha2 = 90; thetha3 = 0; thetha4 = 0; thetha5 = -90; thetha6 = 0;
alpha1 = 90; alpha2 = 0; alpha3 = 90; alpha4 = 270; alpha5 = 90; alpha6 = 0;
r1 = L1; r2 = L3; r3 = L4; r4 = 0; r5 = 0; r6 = 0; 
d1 = L2; d2 = 0; d3 = 0; d4 = L5; d5 = 0; d6 = L6;

L(1) = Revolute('d',d1,'a',r1,'alpha',alpha1*pi/180);
L(2) = Revolute('d',d2,'a',r2,'alpha',alpha2*pi/180);
L(3) = Revolute('d',d3,'a',r3,'alpha',alpha3*pi/180);
L(4) = Revolute('d',d4,'a',r4,'alpha',alpha4*pi/180);
L(5) = Revolute('d',d5,'a',r5,'alpha',alpha5*pi/180);
L(6) = Revolute('d',d6,'a',r6,'alpha',alpha6*pi/180);
robot = SerialLink(L);
joints = [thetha1*pi/180,thetha2*pi/180,thetha3*pi/180,thetha4*pi/180,thetha5*pi/180,thetha6*pi/180];
% robot.plot(joints);
% robot.teach(joints);
%
grab = 2; % activate EE (0 - release the object, 1 - grab, 2 - do nothing)
t = [0:0.1:2];

X1 = 0.462; %
Y1 = 0.209; %
Z1 = 0.04; %

T = transl(X1,-Y1, Z1) * trotx(180, "deg");
% T = transl(X1,-Y1, Z1) * trotx(180); use this if line 31 gives error
qi1 = robot.ikine(T);
qf1 = [thetha1*pi/180,thetha2*pi/180,thetha3*pi/180,thetha4*pi/180,thetha5*pi/180,thetha6*pi/180];
q = jtraj(qf1,qi1,t);
% robot.plot(q);
%
b = 1;
for a = 1 : length(q)
    func_data(Client, q, b);
    b=b+1;     
end

% take object
grab = 1;
func_grab(Client, grab);
pause(4.5);

% back to initial pos
b = 1;
q = jtraj(qi1,qf1,t);
% robot.plot(q);

for a = 1 : length(q)
    func_data(Client, q, b); 
    b=b+1;
end

% release object
grab = 0;
func_grab(Client, grab);
pause(0.5);