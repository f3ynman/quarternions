%Source: Example 11.23 (Curtis)

function eigenvector = DCMtoQUAT(Q)
% Input: Direction Cosine Matrix
% Output: Quaternion

% Fail-proof version (in case q4 = 0)
    % Reference: Bar-Itzhak, 2000; Jennings, 1977

K = ...
     [Q(1,1)-Q(2,2)-Q(3,3), Q(2,1)+Q(1,2),        Q(3,1)+Q(1,3),               Q(2,3)-Q(3,2);
      Q(2,1)+Q(1,2),        Q(2,2)-Q(1,1)-Q(3,3), Q(2,3)+Q(3,2),               Q(3,1)-Q(1,3);
      Q(3,1)+Q(1,3),        Q(2,3)+Q(3,2),        Q(3,3)-Q(2,2)-Q(1,1),        Q(1,2)-Q(2,1);
      Q(2,3)-Q(3,2),        Q(3,1)-Q(1,3),        Q(1,2)-Q(2,1),        Q(1,1)+Q(2,2)+Q(3,3)
     ]/3;

v0 = [1 1 1 1]';    %Initialize eigenvector
v0 = v0 / norm(v0); %Normalize it

lambda_new = v0' * K * v0;     %Rayleigh quotient (estimate eigenvalue)
                               %(norm(v0)=1 since we normalized it.)
lambda_old = 10 * lambda_new;  %Only for begin the iteration.
no_iteration = 0;              %Iteration count
tolerance = 1e-10;             %Desired tolerance

% Power Iteration Method
while abs((lambda_old - lambda_new)/lambda_old) > tolerance
    no_iteration = no_iteration + 1; %advance counter
    lambda_old = lambda_new;         %Step up previous eigenvalue
    v = v0;                          %Inject old eigenvector
    vnew = K * v / norm(K * v);      %Calculate new eigenvector
    lambda_new = vnew' * K * vnew;   %Calculate new eigenvalue
    v0 = vnew;                       %Pull new eigenvector
end

no_iteration = no_iteration;
lambda_max = lambda_new;
eigenvector = vnew;

disp(no_iteration);
disp(lambda_max);
disp(eigenvector);


end