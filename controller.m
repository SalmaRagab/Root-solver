function [handles] = controller(hObject,handles)
    [handles] =  handle_error_msgs(hObject,handles,1);
    [is_valid, full_tagname] = Validator(handles);
    if(~is_valid)
       handles.ErrorMsgs =  full_tagname;
       guidata(hObject, handles);
       handle_error_msgs(hObject,handles,0);
    else
      call_evaluating_methods(handles);
    end;
    guidata(hObject, handles);
    
    
function [handles] =  handle_error_msgs(hObject,handles,isAnotherChance)
  [row,col] = size(handles.ErrorMsgs);
 if(col > 0 )
  for i = 1 : row
      for j = 1 : col
      if(isAnotherChance == 1)
      set(handles.(char(handles.ErrorMsgs{i,j})), 'String','');
      else
      set(handles.(char(handles.ErrorMsgs{i,j})), 'String','Invalid Entry');
      end;
      guidata(hObject, handles);
      end;
  end;
 end;
      
function call_evaluating_methods(handles)
    selected_method = get(handles.method_drop_down, 'value');
    method_names = {'Bisection Results' ; 'False Position Results';'Fixed Point Results';'Newton Raphson Results' ; 'Birge Vieta Results';'Secant Results';'Brent Results';'Brent Multiplicity Results'};
    isAll = 0;
    xl = [];
    xu = [];
    xr = [];
    roots = [];
    errors = [];
    iterations = [];
    switch selected_method 
        case 1  %all
           [equation,xl,xu,root1,error1,noO1] = call_bisection(handles);
           [equation,xl,xu,root2,error2,noO2] = call_false_position(handles);
           [equation,root3,error3,noO3] =  call_newton_raphson(handles);
           [equation,root4,error4,noO4] =  call_fixed_point(handles);
           [equation,root5,error5,noO5] =  call_secant(handles);
           [equation,root6,error6,noO6] =  call_birge_vieta(handles);
           [equation] =  call_brent(handles , 1 ,   method_names{7});
           [equation] =  call_brent(handles , 0 ,    method_names{8});
            join_files(method_names, 'allResults.txt');
            deleteFiles(method_names);
            fileName = 'allResults.txt';
            isAll = 1;
        case 2 %bisection
            [equation,xl,xu,xr] = call_bisection(handles);
            fileName = 'Bisection Results.txt';
             isAll = 3;
        case 3 %false position
            [equation,xl,xu,xr] =  call_false_position(handles);
             fileName = 'False Position Results.txt';
             isAll = 4;
        case 4 %fixed point
            [equation] =  call_fixed_point(handles);
            fileName = 'Fixed Point Results.txt';
             isAll = 2;
        case 5 %newton
            [equation] = call_newton_raphson(handles);
            fileName = 'Newton Raphson Results.txt';
        case 6 %secant
            [equation] = call_secant(handles);
            fileName = 'Secant Results.txt';
        case 7 %birge vieta 
           [equation] =  call_birge_vieta(handles);
            fileName = 'Birge Vieta Results.txt';
        case 8  %brent
             fileName = 'Brent Results.txt';
             [equation] =  call_brent(handles , 1 ,     method_names{7});
        case 9  %brent multiplicity
             fileName = 'Brent Multiplicity Results.txt';
             [equation] =  call_brent(handles , 0 ,    method_names{8});
            
            
    end;
    
    if (isAll == 1)
     roots = {root1;root2;root3;root4;root5;root6};
     errors = {error1;error2;error3;error4;error5;error6};
     iterations = {noO1;noO2;noO3;noO4;noO5;noO6};
    end;
    open_result_view(fileName,isAll,equation,roots,errors,iterations,xl,xu,xr);
    
     
    
    
function [plot,xl,xu,roots,errors,iterations] = call_bisection(handles)
xl = {};
xu = {};
roots = {};
iterations = {};
errors = {};
equ =  sym(get(handles.EquationText,'String'));
a = str2double(get(handles.BisectionXlower,'String'));
b =  str2double(get(handles.BisectionXupper,'String'));
[MaxNoOfIterations,ErrorBound] = calculate_errorBound_noOfIterations(get(handles.BisectionNoOfIterations,'String'),get(handles.BisectionEpsilon,'String')); 
[plot,root,noOfIterations ,theroticalNoOfIteration,error,executionTime,matrixOutput,columnNames ,err_msg]= bisection(equ,a,b,MaxNoOfIterations,ErrorBound);
result_matrix = {'Root' num2str(root);'No.OfIterations' num2str(noOfIterations); 'Theoretical_No_Of_Iterations' num2str(theroticalNoOfIteration);'Execution_Time' strcat(num2str(executionTime),' ms'); 'Precision' num2str(error)};
output_to_file(columnNames,  matrixOutput , result_matrix, 'Bisection Results', err_msg );
if(isempty(err_msg))
xl = matrixOutput(: , 2);
xu= matrixOutput(: , 3);
roots = matrixOutput(: , 6);
iterations = matrixOutput(: , 1);
errors = matrixOutput(: , 8);
end;
        
        
function [plot,xl,xu,roots,errors,iterations] = call_false_position(handles)
xl = {};
xu = {};
roots = {};
iterations = {};
errors = {};
equ =  sym(get(handles.EquationText,'String'));
a = str2double(get(handles.FalsePostionXlower,'String'));
b =  str2double(get(handles.FalsePostionXupper,'String'));
[MaxNoOfIterations,ErrorBound] = calculate_errorBound_noOfIterations(get(handles.FalsePositionNoOfIterations,'String'),get(handles.FalsePositionEpsilon,'String'));  
[plot,root,noOfIterations ,error,executionTime,matrixOutput,columnNames, err_msg ] = false_position(equ,a,b,MaxNoOfIterations,ErrorBound);  
result_matrix = {'Root' num2str(root);'No.OfIterations' num2str(noOfIterations);'Execution_Time' strcat(num2str(executionTime),' ms'); 'Precision' num2str(error)};
output_to_file(columnNames, matrixOutput , result_matrix, 'False Position Results', err_msg );
if(isempty(err_msg))
roots = matrixOutput(: , 6);
iterations = matrixOutput(: , 1);
errors = matrixOutput(: , 8);
xl = matrixOutput(: , 2);
xu= matrixOutput(: , 3);
end;
        
             
        
function [plot,roots,errors,iterations] = call_newton_raphson(handles)
roots = {};
iterations = {};
errors = {};
equ =  sym(get(handles.EquationText,'String'));
Xi = str2double(get(handles.NewtonRaphsonXi,'String'));
[MaxNoOfIterations,ErrorBound] = calculate_errorBound_noOfIterations(get(handles.NewtonRaphsonNoOfIterations,'String'),get(handles.NewtonRaphsonEpsilon,'String'));
[root,noOfIterations,error,executionTime,matrixOutput,columnNames,theoreticalErrorBound,plot, err_msg ]=newton_raphson(equ,Xi,MaxNoOfIterations,ErrorBound);  
result_matrix = {'Root' num2str(root);'No.OfIterations' num2str(noOfIterations); 'Theoretical_Error_Bound' num2str(theoreticalErrorBound);'Execution_Time' strcat(num2str(executionTime),' ms'); 'Precision' num2str(error)};
output_to_file(columnNames,  matrixOutput , result_matrix, 'Newton Raphson Results', err_msg );
if(isempty(err_msg))
roots = matrixOutput(: , 5);
iterations = matrixOutput(: , 1);
errors = matrixOutput(: , 6);
end;

        
        
function [plot,roots,errors,iterations] = call_birge_vieta(handles)
roots = {};
iterations = {};
errors = {};
equ =  sym(get(handles.EquationText,'String'));
Xinitial = str2double(get(handles.BirgeVietaXi,'String'));
[MaxNoOfIterations,ErrorBound] = calculate_errorBound_noOfIterations(get(handles.BirgeVietaNoOfIterations,'String'),get(handles.BirgeVietaEpsilon,'String'));
[col_names, results, time, root, error, noOfIterations, plot, err_msg ] = birge_vieta(equ, MaxNoOfIterations,ErrorBound, Xinitial);
result_matrix = {'Root' num2str(root);'No.OfIterations' num2str(noOfIterations);'Execution_Time' strcat(num2str(time),' ms'); 'Precision' num2str(error)};
output_to_file(col_names, results , result_matrix, 'Birge Vieta Results', err_msg );
if(isempty(err_msg))
roots = results(: , 3);
iterations = results(: , 1);
errors = results(: , 4);
end;
        

     


function [plot,roots,errors,iterations] = call_secant(handles)
equ =  sym(get(handles.EquationText,'String'));
x0 = str2double(get(handles.SecantFirstPoint,'String'));
x1 = str2double(get(handles.SecantSecondPoint,'String'));
[MaxNoOfIterations,ErrorBound] = calculate_errorBound_noOfIterations(get(handles.SecantNoOfIterations,'String'),get(handles.SecantEpsilon,'String'));
[plot, ColumnNames,results, error, root, time,noOfIterations] = secant (equ, MaxNoOfIterations, x0, x1, ErrorBound); 
result_matrix = {'Root' num2str(root);'No.OfIterations' num2str(noOfIterations);'Execution_Time' strcat(num2str(time),' ms'); 'Precision' num2str(error)};
output_to_file(ColumnNames, results , result_matrix, 'Secant Results','');
roots = results(: , 6);
iterations = results(: , 1);
errors = results(: , 7);

        
function [plot,roots,errors,iterations] = call_fixed_point(handles)
roots = {};
iterations = {};
errors = {};
equ =  sym(get(handles.EquationText,'String'));
initial = str2double(get(handles.FixedPointIterationXi,'String'));
[max_it,bound] = calculate_errorBound_noOfIterations(get(handles.FixedPointIterationNoOfIterations,'String'),get(handles.FixedPointIterationEpsilon,'String'));
[theo_bound,column_names,res_table, root, number_of_it, exec_t, error, plot ,err_msg ] = fixed_point_it (equ, initial, bound, max_it);
result_matrix = {'Root' num2str(root);'No.OfIterations' num2str(number_of_it);'Execution_Time' strcat(num2str(exec_t),' ms');  'Theoretical_Error_Bound' num2str(theo_bound);'Precision' num2str(error)};
output_to_file(column_names, res_table , result_matrix, 'Fixed Point Results', err_msg );
if(isempty(err_msg))
roots = res_table(: , 3);
iterations = res_table(: , 1);
errors = res_table(: , 4);
end;

function [plot] = call_brent(handles ,flag , fileName)
 equ = get(handles.EquationText,'String');
 if(flag)
   [column_names,interval, res_table,it_pres_root ,root , exec_t, plot, err_message] = brent_fzero(equ);
 else
   [column_names,interval, res_table,it_pres_root, exec_t, plot, err_message] = brent_fzero_m(equ); 
 end;
[row,col] = size(res_table);
if(~isempty(err_message))
    output_to_file([], [] , [], fileName, err_message);
else
    interval_bgn = 0; counter = 1;
    fileNames = [];
for i = 1 : row
    if(~isempty(interval{i,1}))
         interval_bgn = i;
    end;
    if((isempty(interval{i,1}) &&(i < row && ~isempty(interval{i+1,1})) || i == row)  || (~isempty(interval{i,1}) && (i == row || (i < row && ~isempty(interval{i+1,1}) ))) ) 
         result_matrix = {'Root' num2str(it_pres_root(counter,3));'No.OfIterations' num2str(it_pres_root(counter,1)) ;'Precision' num2str(it_pres_root(counter,2))};
         if(i == row)
           result_matrix = {'Root' num2str(it_pres_root(counter,3));'No.OfIterations' num2str(it_pres_root(counter,1)) ;'Precision' num2str(it_pres_root(counter,2)); 'Total_Execution_time' num2str(exec_t)};
         end;
         output_to_file(column_names,res_table((interval_bgn:i),:) ,  result_matrix , strcat('BrentInterval ',interval{interval_bgn,1}), '');
         fileNames{counter,1} =  strcat('BrentInterval ',interval{interval_bgn,1});
         counter = counter + 1;
    end;
end;
   join_files(fileNames , strcat(fileName , '.txt'));
   deleteFiles(fileNames);
end;



function  deleteFiles(file_names)
 for i = 1 : size(file_names,1)
     delete (strcat(file_names{i,1},'.txt'));
 end;
 
function open_result_view(fileName,isAll,equation,roots,errors,iterations,xl,xu,xr)
     close(ResultView);
     run ResultView;
     h = findobj('Tag','ResultView');
     data = guidata(h);
     data.fileName = fileName;
     data.isAll = isAll;
     data.xl = xl;
     data.xu = xu;
     data.xr = xr;
     data.roots = roots;
     data.errors = errors;
     data.iterations = iterations;
     data.equation = equation;  
     guidata(h,data);
     
     
     
function[MaxNoOfIterations,ErrorBound] = calculate_errorBound_noOfIterations(noOfIterationsString,errorString)      
if(isempty(noOfIterationsString))
    MaxNoOfIterations = 50;
else
MaxNoOfIterations = str2double(noOfIterationsString);
end;
if(isempty(errorString))
    ErrorBound = 0.00001;
else
ErrorBound  = str2double(errorString);
end;        