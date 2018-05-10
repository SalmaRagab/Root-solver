function [fun,root,noOfIterations ,theroticalNoOfIteration,absolute,executionTime,matrixOutput,columnNames,err_msg] = bisection(fun,a,b,MaxNoOfIterations,epsilon) 
 format ('long');
 columnNames = {'noOfIteration','Xl ','Xu','f(Xl)','f(Xu)','Xr','f(Xr)','absolute.Error'};
 matrix = zeros(MaxNoOfIterations+1,8);
 noOfIterations = 0;
 executionTime = 0;
 matrixOutput = {};
 theroticalNoOfIteration = 0;
 Xl = a;    Xu = b;
 L = b - a;
 absolute = 1000;
 err_msg = '';
 c = subs(fun,Xl); d = subs(fun,Xu);
 Xold = Xl;
 root = 0;
 tic;
if c*d > 0.0     
   err_msg = 'Function has same sign at both endpoints.';
   return;
end
while ((noOfIterations < MaxNoOfIterations ) && (absolute > epsilon))
    c = subs(fun,Xl); d = subs(fun,Xu);
    Xr = (Xl + Xu)/2;
    y = subs(fun,Xr);
    absolute = abs(Xr - Xold);
    matrix(noOfIterations+1,1)= noOfIterations+1;
    matrix(noOfIterations+1,2)= Xl;
    matrix(noOfIterations+1,3)= Xu;
    matrix(noOfIterations+1,4)= c;
    matrix(noOfIterations+1,5)= d;
    matrix(noOfIterations+1,6)= Xr;
    matrix(noOfIterations+1,7)= y;
     if noOfIterations == 0 
            matrix(noOfIterations+1,8)=NaN;
    else 
            matrix(noOfIterations+1,8)=abs(absolute);
    end
    noOfIterations = noOfIterations + 1;
     if y == 0
    absolute = 0;
    Xl = Xr;
    c = subs(fun,Xl); d = subs(fun,Xu);
    matrix(noOfIterations+1,1)=noOfIterations+1;
    matrix(noOfIterations+1,2)=Xl;
    matrix(noOfIterations+1,3)=Xu;
    matrix(noOfIterations+1,4)=c;
    matrix(noOfIterations+1,5)=d;
    matrix(noOfIterations+1,6)=Xr;
    matrix(noOfIterations+1,7)=y;
    matrix(noOfIterations+1,8)=abs(absolute);
    noOfIterations = noOfIterations +1;
        break
    end
   if y > 0
        if c > 0
            Xl=Xr;
            Xold = Xl;
        else
            Xu=Xr;
            Xold = Xu;
        end
    else
         if c > 0
           Xu=Xr;
            Xold = Xu;
        else
             Xl=Xr;
            Xold = Xl;
         end
    end
end
  theroticalNoOfIteration = log2(abs(L/absolute));
  executionTime = toc; 
  root = matrix(noOfIterations,6);
  matrixOutput = zeros(noOfIterations,8);

 for i = 1 : noOfIterations
      for j = 1 : 8
      matrixOutput(i,j) = matrix (i,j);
      end
 end
end
