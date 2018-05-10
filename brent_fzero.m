function  [column_names,interval, res_table,it_pres_root ,root, exec_t, plot, err_message] = brent_fzero(F,varargin)
 
format long;
 
% Initialize.
 
column_names = {'#ofIterations', 'X(i)', 'X(i+1)', 'AbsoluteError'};
err_message = '';
 
 
 
 
tot_it = 1;
it = 1;
rt = 1; 
root = [];
res_table = [];
it_pres_root = [];
x1 = 0;
x2 = 0;
 
interval = {};
 
plot = sym(F);
flag = true;
 
 
tic;
 
xlist = (-100:0.1:100)';    %Divide [-100, 100] into equally intervals of length 0.1 each.
 
func = generate_fnc_handler(F);
 
 
for i = 1: (size(xlist) - 1)
 
 
a = xlist(i);
b = xlist(i + 1);
 
if ~flag 
    a = a + typecast(uint64(1),'double');
end;
 
 
fa = func(a,varargin{:});
fb = func(b,varargin{:});
 
 
if sign(fa) == sign(fb)
continue;
end;
 
interval{tot_it,1} =  strcat('[',num2str(a),',',num2str(b),']');
it = 1;
 
 
c = a;
fc = fa;
d = b - c;   %interval length.
e = d;
 
% Main loop, exit from middle of the loop
while fb ~= 0
 
 
 
   % The three current points, a, b, and c, satisfy:
   %    f(x) changes sign between a and b.
   %    abs(f(b)) <= abs(f(a)).
   %    c = previous b, so c might = a.
   % The next point is chosen from
   %    Bisection point, (a+b)/2.
   %    Secant point determined by b and c.
   %    Inverse quadratic interpolation point determined
   %    by a, b, and c if they are distinct.
 
   if sign(fa) == sign(fb)
      a = c;  fa = fc;
      d = b - c;  e = d;
   end
   if abs(fa) < abs(fb)
      c = b;    b = a;    a = c;
      fc = fb;  fb = fa;  fa = fc;
   end
 
   % Convergence test and possible exit
   m = 0.5*(a - b);
   tol = 2.0*eps*max(abs(b),1.0);
   if (abs(m) <= tol) || (fb == 0.0)
 
       res_table(tot_it, 1:4) = [it;a;b; abs(m)];
 
 
       tot_it = tot_it + 1;
      break
   end
 
   % Choose bisection or interpolation
   if (abs(e) < tol) || (abs(fc) <= abs(fb))
      % Bisection
      d = m;
      e = m;
   else
      % Interpolation
      s = fb/fc;
      if (a == c)
         % Linear interpolation (secant)
         p = 2.0*m*s;
         q = 1.0 - s;
      else
         % Inverse quadratic interpolation
         q = fc/fa;
         r = fb/fa;
         p = s*(2.0*m*q*(q - r) - (b - c)*(r - 1.0));
         q = (q - 1.0)*(r - 1.0)*(s - 1.0);
      end;
      if p > 0, q = -q; else p = -p; end;
      % Is interpolated point acceptable
      if (2.0*p < 3.0*m*q - abs(tol*q)) && (p < abs(0.5*e*q))
         e = d;
         d = p/q;
      else
         d = m;
         e = m;
      end;
   end
 
   % Next point
   x1 = b;
   c = b;
   fc = fb;
   if abs(d) > tol
      b = b + d;
   else
      b = b - sign(b-a)*tol;
   end
   x2 = b;
   fb = func(b,varargin{:});
 
   res_table(tot_it, 1:4) = [it;x1;x2; abs(x2 - x1)];
%    number_of_it(counter) = it;
%    precision(counter) = abs(x2 - x1);
 
   tot_it = tot_it + 1;
   interval{tot_it,1}= '';
   it = it + 1;
end
 if rt > 1 && b == root(rt - 1)
     flag = false;
 else 
     flag = true;
     root(rt) = b;
     it_pres_root(rt,3) = b;
     it_pres_root(rt,1:2) = [it, abs(x2 - x1)];
     rt = rt + 1;
 
 end;
 
 
 
end
exec_t = toc;
 
 
 if size(root) < 1
   err_message = 'No Root Found';
 end;
 
 
 
 
 
function f = generate_fnc_handler(str_fnc)
func_handler = '@(x)';
new_func = strcat(func_handler, str_fnc);
f = str2func(new_func);
 