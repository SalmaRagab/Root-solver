function [root,noOfIterations,error,executionTime,matrixOutput,columnNames,theoreticalErrorBound,plot,err_msg]=newton_raphson(func,Xinitial,MaxNoOfIterations,ErrorBound)     
  format long;
  functionDerivative = @(x) diff(func);
  matrix = zeros(MaxNoOfIterations+1,6);
  noOfIterations = 1;
  error = 1000;
  err_msg = '';
  root = 0;
  matrixOutput = {};
  columnNames = {};
  theoreticalErrorBound = 0;
   plot = diff(func);
  xi = Xinitial;
  tic;
  while ((noOfIterations < MaxNoOfIterations ) && (abs(error) > ErrorBound))
      functionValue = eval(subs(func,xi));
      x = xi;
      derivativeValue = eval(functionDerivative(1));
      if (derivativeValue == 0)
           err_msg = 'ERROR!!! DIVISION BY ZERO OCCURED';
          break;
      end
      xnew = xi - ((functionValue) / (derivativeValue));
      error = xnew - xi;
      matrix(noOfIterations,1) =  noOfIterations;
      matrix(noOfIterations,2) =  xi;
      matrix(noOfIterations,3) = functionValue; 
      matrix(noOfIterations,4) = derivativeValue;
      matrix(noOfIterations,5) =  xnew;
      matrix(noOfIterations,6) =  abs(error);
      noOfIterations = noOfIterations + 1;
      xi = xnew; 
  end 
  if (noOfIterations == MaxNoOfIterations  && abs(error) > ErrorBound)
        err_msg = 'Couldnot find the exact root... method may diverged';
  end;
  noOfIterations = noOfIterations - 1;
  executionTime = toc; 
  if(noOfIterations > 0)
  error = matrix(noOfIterations,6);
  root = matrix(noOfIterations,5);
  columnNames = {'No.OfIteration','Xi ','f(xi) ','f"(xi) ','Xi+1 ','Abs.Error'};
  matrixOutput = zeros(noOfIterations,5);
  trueRoot = fzero(matlabFunction(func),Xinitial);
  theoreticalErrorBound = eval(- subs(sym(diff(func,2)),trueRoot) /  (2 * subs(sym(diff(func)),trueRoot))); 

 for i = 1 : noOfIterations
      for j = 1 : 6
      matrixOutput(i,j) = matrix (i,j);
      end
 end
 end
