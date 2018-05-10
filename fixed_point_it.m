function [theo_bound,column_names,res_table, root, number_of_it, exec_t, precision, plot, err_message] = fixed_point_it (fx, intial, bound, max_it)
 
 func = convert2func(fx, '+x');
 theo_bound = compute_theoerr (func, intial);
 [column_names,res_table, root, number_of_it, exec_t, precision, plot, err_message] = fixed_pt(func, intial ,bound, max_it, theo_bound);
 
 
 
 
 function [column_names,res_table, root, number_of_it, exec_t, precision, plot, err_message] = fixed_pt(g, intial ,bound, max_it, theo_bound)
% Input - g is the iteration function
%       - p0 is the initial guess for the fixed-point
%       - tol is the tolerance
%       - max1 is the maximum number of iterations
% Output - k is the number of iterations that were carried out
%          - p is the approximation to the fixed-point
%          - err is the error in the approximation
%          - P'contains the sequence {pn}
 
column_names = {'#_of_Iterations', 'X(i)', 'X(i+1)', 'Absolute_Error'};
plot = g;
format long;
iterations(1)= intial;
err_message = {};
tic;
for number_of_it = 2 : max_it
   iterations(number_of_it) = eval(subs(g, iterations(number_of_it - 1)));
   err(number_of_it) = abs(iterations(number_of_it) - iterations(number_of_it - 1));
   root = iterations(number_of_it);
   true_root = fzero(matlabFunction(g), intial);
   res_table(number_of_it - 1, 1:4) = [number_of_it - 1;iterations(number_of_it - 1); iterations(number_of_it); err(number_of_it)];
   if number_of_it > 2 && (err(number_of_it) > err(number_of_it - 1) && err(number_of_it) > err(number_of_it - 2))
       err_message = 'Fixed Point Iteration Method Diverged for the given g(x).';
       break;
   end
   if (err(number_of_it) < bound),break;end
end
 exec_t = toc; 
if number_of_it == max_it
   err_message = 'Maximum # of iterations reached with no root found';
end
 
precision = err(number_of_it);
 
 
 
function func = convert2func (g, f)
g = sym(g);
f = sym(f);
func = sym(g + f);

 
function theo_bound = compute_theoerr (func, intial)
diff_func = sym(diff(func));

true_root = fzero(matlabFunction(func), intial);

theo_bound = abs(eval(subs(diff_func, true_root)));