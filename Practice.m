clc; clear;

theta = pi/6;

q1 = sin(theta/2);
q2 = 0;
q3 = 0;
q4 = cos(theta/2);

fprintf('q1 = %.4f, q2 = %.4f, q3 = %.4f, q4 = %.4f\n', q1, q2, q3, q4);

q = [q1 q2 q3 q4];

Q = q2DCM(q)

Qcheck = DCM2q(Q)
