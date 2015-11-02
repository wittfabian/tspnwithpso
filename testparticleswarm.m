
% Define the objective function
fun = @(x)x(1)*exp(-norm(x)^2);

% Set bounds on the variables.
lb = [-10,-15];
ub = [15,20];

% Specify the options
options = optimoptions('particleswarm','SwarmSize',100,'HybridFcn',@fmincon);

% Call particleswarm to minimize the function
rng default  % For reproducibility
x = particleswarm(fun,2,lb,ub,options)

% This solution is far from the true minimum, as you see in a function plot.
ezsurf(@(x,y)x.*exp(-(x.^2+y.^2)))