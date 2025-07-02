function unit = qUnit(q)

q1 = q(1); q2 = q(2); q3 = q(3); q4 = q(4);

qNorm = sqrt(q1^2+q2^2+q3^2+q4^2);

unit = q / qNorm;

end