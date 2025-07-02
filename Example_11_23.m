clc; clear;

phi = deg2rad(50);   %yaw angle
theta = deg2rad(90); %pitch angle
psi = deg2rad(120);  %roll angle

Q = angle2dcm(phi, theta, psi, "ZYX");

q = DCM2q(Q)

q = DCMtoQUAT(Q)
