function A = ackley(x)
% ackley(x); x: vector, real
  c1 = 20;
  c2 = 0.2;
  c3 = 2*pi;
  A = -c1 * exp(-c2*sqrt(mean(x.^2))) - exp(mean(cos(c3*x))) + c1 + exp(1);
end




  