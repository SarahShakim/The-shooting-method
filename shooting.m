% shooting
% 
% Making the equation an initial value problem and solving to see if our value is correct. If it  % not correct, we would readjust our initial guess and try again until we obtain the correct answer
%
% Parameters
%
% For each parameter, give a brief description of the purpose of that parameter
%
%    s1        The first approximation of the slope for the function
%    s2        The second approximation of the slope for the function
%    f         the differential equation
%    x_rng   row vector that gives the range for the boundary value problem
%    u_bndry   row vector that defines the boundary conditions for u
%    h         the initial step size
%    eps_abs   the error value that will be used for the dormant prince and secant method
%    eps_step  sets the step size for the secant method
%    N_max     The maximum number of iterations that is used for the secant method
%
% Return Values
%
% For each return value, give a brief description of its values
%
%   x_out  the x-value of the optimal slope
%   u_out  the u-value for the optimal slope

function [x_out, u_out] = shooting( s1, s2, f, x_rng, u_bndry, h, eps_abs, eps_step, N_max )
errs1 = err_shot(s1, f, x_rng, u_bndry, h, eps_abs);
    errs2 = err_shot(s2, f, x_rng, u_bndry, h, eps_abs);
    s = inf;
        
    %secant method to find a root by finding the interpolating straight
    %line that passes through two points:
    
    for i=1:N_max
        
       %method used to find the new slope given s1 and s2:
       
       s3 = ((s1*errs2)-(s2*errs1))/(errs2-errs1);
       
       errs3 = err_shot(s3, f, x_rng, u_bndry, h, eps_abs);
       
       %condition used when we have a good approximation:
       
       if abs(s2-s3)<eps_step && abs(errs3)<eps_abs
           s = s3;
           break
       end
       
       %updating the values of s1 and s2 for the next iteration 
