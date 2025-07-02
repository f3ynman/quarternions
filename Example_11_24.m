clc; clear;
%Assign principle angle for numeric calculation.
theta = deg2rad(30);

%Given rotation parameters
v = [0 1 0];     %Initial vector: v = 1j
v_quat = [v 0];  %Pure quaterion of vector
q_quat = [sin(theta/2) 0 0 cos(theta/2)];       %Quaternion
qconj_quat = [-sin(theta/2) 0 0 cos(theta/2)];  %Conjugate of q_quat

%Direction Cosine Matrix
Q = [1 0 0; 0 cos(theta) sin(theta); 0 -sin(theta) cos(theta)];

% 1) Evaluate Vector Rotation
%vnew_quat = q_quat *comp* v_quat *comp* q*_quat
vnew_quat = qComp(qComp(q_quat, v_quat)', qconj_quat);
vnew = vnew_quat(1:3);
fprintf("With Rodrigues' Vector Rotation\n")
disp(vnew(1:3))

% 2) Evaluate Frame Rotation vnew = Q * v
vnew = Q * v' ;
fprintf("With Frame Rotation\n")
disp(vnew)