clc; clear;

phi = deg2rad(50);   %yaw angle
theta = deg2rad(90); %pitch angle
psi = deg2rad(120);  %roll angle

Q = angle2dcm(phi, theta, psi, "ZYX");

q = DCMtoQUAT(Q);

Theta = 2 * acos(q(4));

u = q(1:3) / sin(Theta/2);

fprintf("Principle Angle: %.4f [deg]\n", rad2deg(Theta))
fprintf("Euler Axis: [%.4f %.4f %.4f]\n", u)

