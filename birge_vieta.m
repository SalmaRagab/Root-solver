function [col_names, results, time, root, error, iterations, plot_function, error_msg] = birge_vieta(fx, max_iterations, max_error, x_initial)
    error_msg = '';
    col_names = {'Iterations', 'X(i)', 'X(i+1)', 'Absolute_Error' };
    tic;
    format ('long');
    plot_function = fx;
    syms x;
    try
        a = sym2poly(fx); % a is matrix of x coefficients
        a = rot90(a); % vertical arrays
        a = flipud(a); % a is ordered from high order to low order
        noOfCoefficients = size(a, 1);

        x_array(1,1) = x_initial; % given initial value 

        b(1, 1 ) =  a(1, 1);
        c(1, 1 ) =  a(1, 1);

        iterations = 0;
        error = 100; % big initial value
        i = 2; % bec i = 1 was already filled with 1 in b and c 
    %     (i calculates b and c column in each iteration     
        while (iterations < max_iterations && error > max_error)
            while (i <=  noOfCoefficients) 
                b(i, 1) = a(i, 1) + b(i-1, 1) * x_initial;
                if (i ~= noOfCoefficients)
                    c(i, 1) = b(i, 1) + c(i-1, 1) * x_initial;
                end
                i = i + 1;
            end
            i = 2;        
            iterations = iterations + 1;
            x_new = x_initial - b(noOfCoefficients, 1) / c (noOfCoefficients -1, 1 );
            if (c (noOfCoefficients -1, 1 ) == 0) 
                error_msg = 'The Method Will not Converge!';
                results(iterations, 3) = NaN;
                results(iterations, 4) = NaN;
                break;
            end
            error = abs(x_new - x_initial);
            results(iterations, 1:4) = [iterations; x_initial; x_new; error];
            x_initial = x_new;    
        end
        time = toc;
        root = x_new;
    catch exception
        error_msg = 'Birge Vieta accepts only polynomial functions';
        results = NaN;
        time = 0;
        root = NaN;
        error = NaN;
        iterations = 0;
    end
   
end

