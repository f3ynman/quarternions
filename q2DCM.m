function DCM = q2DCM(q)
%QUARTERION_COSINEMATRIX Summary of this function goes here
%   Input: unit quarterion (4x1 array) 

q1 = q(1); q2 = q(2); q3 = q(3); q4 = q(4);

% Norm should be 1

qNorm = sqrt(q1^2+q2^2+q3^2+q4^2); 

if qNorm == 1
    
    DCM = [q1^2-q2^2+q3^2+q4^2,  2*(q1*q2+q3*q4),      2*(q1*q3-q2*q4);
           2*(q1*q2-q3*q4),     -q1^2+q2^2-q3^2+q4^2, 2*(q2*q3+q1*q4);
           2*(q3*q1+q2*q4),      2*(q2*q3-q1*q4),     -q1^2-q2^2+q3^2+q4^2
            ];
else 
  fprintf("Input should be unit Quarterion\n")
end

end