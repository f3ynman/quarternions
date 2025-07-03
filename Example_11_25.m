clc; clear; close all

%Example 11.25 (Curtis, 2020)

%Body Axis [I,J,K] -> [i,j,k]
i0 = [ 0.40825 -0.40825   0.81649];
j0 = [-0.10102 -0.90914  -0.40405];
k0 = [ 0.90726  0.082479 -0.41240];
%Inertial frame angular velocity (constabnt)
wX = [-3.1 2.5 1.7];

Q0 = [i0; j0; k0];   %Direction Cosine Matrix (initial)
q0 = -DCMtoQUAT(Q0); %Calculating initial quaterion

wx = Q0 * wX';       %Body-fixed frame angular velocity
wx_mag = norm(wx);   %...and its magnitude

T = 2*pi/wx_mag;     %1 period time (s)
dt = 0.001;           %Timestep   
time = 0:dt:T;       %Time array

%Storage for;
q = zeros(4,length(time));     %...Quaterion   
Q = zeros(3,3,length(time));   %...DCM
euler = zeros(length(time),3); %...Eular angles

%Initialize values for;
q(:,1) = q0 / norm(q0);        %...Quaterion        
Q(:,:,1) = Q0;                 %...DCM
euler(:,1) = dcm2angle(Q0);    %...Euler angles

for i = 1:length(time)-1

    %Self propagating quaterion function (11.169 and 11.171)
    q(:, i+1) = propagate(q(:,i), wx, dt); 

    Q(:,:,i+1) = quat2dcm(q(:, i+1)');     %Update DCM from quaterion
    
    %Calculate Euler angles from DCM
    [euler(i+1,1),euler(i+1,2),euler(i+1,3)] = dcm2angle(Q(:,:,i+1));

    %disp(i)
end

time = time / max(time); %Normalize time axis (fraction of period)

figure;
plot(time, q)
legend("q1", "q2", "q3", "q4",Location="northwest")
title("Components of quaternion")
xlabel("Time (period)")
ylabel("Quaternion")
grid on

figure;
plot(time, rad2deg(euler))
legend("Yaw (ϕ)", "Pitch (θ)", "Roll (ψ)")
title("Euler Angles for 1 period")
xlabel("Time (period)")
ylabel("Degrees")
grid on


function q = propagate(q0, w, t)
    wmag = norm(w);

    if wmag == 0
        q = q0; % If the angular velocity is zero, return the initial quaternion
        return;
    end

    w_x = w(1);
    w_y = w(2);
    w_z = w(3);

    % Calculate the half-angle
    half_angle = t * wmag / 2;

    % Create the quaternion rotation matrix
    exp_omega_t = [+ cos(half_angle),           +(w_z/wmag)*sin(half_angle), -(w_y/wmag)*sin(half_angle), +(w_x/wmag)*sin(half_angle);
                   -(w_z/wmag)*sin(half_angle), +cos(half_angle),            +(w_x/wmag)*sin(half_angle), +(w_y/wmag)*sin(half_angle);
                   +(w_y/wmag)*sin(half_angle), -(w_x/wmag)*sin(half_angle), +cos(half_angle),            +(w_z/wmag)*sin(half_angle);
                   -(w_x/wmag)*sin(half_angle), -(w_y/wmag)*sin(half_angle), -(w_z/wmag)*sin(half_angle), +cos(half_angle)];

    % Multiply the rotation matrix by the initial quaternion
    q = exp_omega_t * q0;
end

