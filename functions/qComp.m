function comp = qComp(p,q)
%COMPOSITION Summary of this function goes here
%   p and q are 4 input arrays.
%   First 3 input vector part.
%   Last part scalar part.

comp = zeros(4,1);

p_vector = p(1:3);
p_scalar = p(4);

q_vector = q(1:3);
q_scalar = q(4);

comp_upper = p_scalar * q_vector + q_scalar * p_vector + cross(p_vector,q_vector);
comp_lower = q_scalar * p_scalar - dot(q_vector, p_vector);

comp(1:3) = comp_upper;
comp(4) = comp_lower;
end