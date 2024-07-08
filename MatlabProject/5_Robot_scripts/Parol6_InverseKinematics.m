% Parol6 Robot arm RTB IK

clc
clear

x=0; % Roll -90
y=180; % Pitch 0
z=0; % Yaw 0
RR = compose_rotation(x, y, z)

L1 = 123.32; L2 = 577.32; L3 = 949.04; L4 = 227.79; L5 = 918.09; L6 = 740.36;

T = [RR(1,1)    RR(1,2)   RR(1,3)    1387.26
     RR(2,1)    RR(2,2)   RR(2,3)    627.8
     RR(3,1)    RR(3,2)   RR(3,3)    106.212
     0    0    0    1.0000];
     
R = [?]; 

o = [?];

xc = o(1) - ?;
yc = o(2) - ?;
zc = o(3) - ?;

% find thetha1
thetha1 = ?

% find thetha3
a = ?
r = ?
s = ? 
b = ?
D = ?
fi = ?
beta = ?
alpha = ?
% thetha3 = ? % config I
thetha3 = ? % config II

% find thetha2
fi2 = ? 
D1 = ?
fi1 = ?
% thetha2 = ? % config I
thetha2 = ? % config II

% find thetha4, thetha5, thetha6
alpha1 = ?; alpha2 = ?; alpha3 = ?;
r1 = ?; r2 = ?; r3 = ?;
d1 = ?; d2 = ?; d3 = ?; 

T1 = [?];
T2 = [?];
T3 = [?];
 
T03 = ?
R03 = [?];

R03T = R03.'; 
R36 = ?;

% find thetha5
thetha5 = -acosd(R36(3,3))

% find thetha4
thetha4 = atan2d(-R36(2,3),-R36(1,3))

% find thetha6
thetha6 = atan2d(-R36(3,2),R36(3,1))

alpha1 = ?; alpha2 = ?; alpha3 = ?; alpha4 = ?; alpha5 = ?; alpha6 = ?;
r1 = ?; r2 = ?; r3 = ?; r4 = ?; r5 = ?; r6 = ?; 
d1 = ?; d2 = ?; d3 = ?; d4 = ?; d5 = ?; d6 = ?;

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