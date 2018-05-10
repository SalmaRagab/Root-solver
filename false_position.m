function [fun, root, noOfIterations, Error, executionTime, matrixOutput, columnNames, err_msg] = false_position(fun, a, b, MaxNoOfIterations, epsilon) 
% False Position Method
% Find the roots of given function by using false position method.
 format long;
 matrixOutput = {};
 columnNames = {'#OfIteration','Xl','Xu','f(Xl) ','f(Xu)','Xr','f(Xr)','Absolute_Error'};
 root = 0;
 err_msg = '';
 Error = 1000;
 
 matrix = zeros(MaxNoOfIterations, 8);
 noOfIterations = 0;
 executionTime = 0;
 Xl = a;    Xu = b; 
 Xold = NaN;
 tic;
 c = eval(subs(fun,Xl)); d = eval(subs(fun,Xu));
 
 if c*d > 0.0     
    err_msg = 'Function has same sign at both end points.';
    return;
 end;
 
while noOfIterations < MaxNoOfIterations 
    noOfIterations = noOfIterations + 1;
     c = eval(subs(fun,Xl)); d = eval(subs(fun,Xu));
    Xr = ((Xl * d) - (Xu * c)) / (d - c);
    
    absolute = abs(Xr - Xold);
    y = eval(subs(fun,Xr));
    
    
    matrix(noOfIterations, 1) = noOfIterations;
    matrix(noOfIterations, 2) = Xl;
    matrix(noOfIterations, 3) = Xu;
    matrix(noOfIterations, 4) = c;
    matrix(noOfIterations, 5) = d;
    matrix(noOfIterations, 6) = Xr;
    matrix(noOfIterations, 7) = y;
    matrix(noOfIterations, 8) = absolute;
    
    if y == 0
        absolute = 0;
    break;
    end;
    
    if absolute <= epsilon
        break;
    end;
    
   if (y * c) < 0
       Xu = Xr;
   else 
       Xl = Xr;
   end;
     Xold = Xr;   
   
end;
  executionTime = toc;
  Error = absolute;
  root = matrix(noOfIterations,6);
  matrixOutput = zeros(noOfIterations, 8);
  for i = 1: noOfIterations
      for j = 1 : 8
      matrixOutput(i,j) = matrix (i,j);
      end;
  end;
  


