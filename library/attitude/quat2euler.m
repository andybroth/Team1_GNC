function euler = quat2euler(q)

R     = quat2dcm(q);
euler = dcm2euler321(R);

end