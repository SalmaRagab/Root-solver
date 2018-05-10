function [equation, ColumnNames_matrix, values_matrix, Absolute_Error, Approximate_root, executionTime, Number_of_iterations] = secant (func, MaxNoOfIterations, x0, x1, ErrorBound)

% y= @(x)x.^3 - 0.165*x.^2 + 3.993 * 10^-4;
equation = func;
Absolute_Error = 10; %initial value
NoOfIterations = 1;
xold = x0; %xi-1
xi = x1; %xi
values_matrix_all = zeros(MaxNoOfIterations, 6);

tic;

while ((NoOfIterations < MaxNoOfIterations) && (abs(Absolute_Error) > ErrorBound)) 
    
    firstValue = eval(subs(func, xold)); %value of f(xi-1)
    secondValue = eval(subs(func, xi)); %value of f(xi)
    
    nextX = xi - (secondValue * ((xi - xold)/(secondValue - firstValue)));
    Absolute_Error = abs(nextX - xi);
    values_matrix_all(NoOfIterations , 1) = NoOfIterations;
    values_matrix_all(NoOfIterations , 2) = xold;
    values_matrix_all(NoOfIterations, 3) = xi; 
    values_matrix_all(NoOfIterations , 4) = firstValue;
    values_matrix_all(NoOfIterations, 5) = secondValue;
    values_matrix_all(NoOfIterations, 6) = nextX;
    values_matrix_all(NoOfIterations, 7) = Absolute_Error;
    
    xold = xi;
    xi = nextX;
    NoOfIterations = NoOfIterations + 1;
end
    NoOfIterations = NoOfIterations - 1;
    executionTime = toc;
    Number_of_iterations = NoOfIterations;

values_matrix = zeros(NoOfIterations,7);

for i = 1 : NoOfIterations
    for j = 1 : 7
        values_matrix(i, j) = values_matrix_all (i, j);
    end
end

ColumnNames_matrix = {'No.OfIterations','X(i-1)','X(i)','f(Xi-1)','f(Xi)', 'X(i+1)' ,'AbsoluteError'};
Approximate_root = values_matrix_all(NoOfIterations, 6);

