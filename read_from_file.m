function [handles] = read_from_file(hObject,handles,path)
fileID = fopen(path);
equation = fgetl(fileID);
set(handles.EquationText, 'String',equation);
counter = 0;
while ~feof(fileID)
    counter = counter + 1;
    method_name = fgetl(fileID); 
    if (strcmp(method_name, 'brent') == 1)
       [handles] =  fill_brent(handles);
    elseif(strcmp(method_name, 'brentmultiplicity') == 1)
        [handles] = fill_brent_multiplicity(handles); 
    else
    first  = fgetl(fileID);
    second = fgetl(fileID);
    third = fgetl(fileID);
   switch method_name
       case 'bisection'
         fourth = fgetl(fileID);
         [handles] =  fill_bisection(handles,first,second,third,fourth);
       case 'falseposition'
          fourth = fgetl(fileID);
         [handles] =  fill_false_position(handles,first,second,third,fourth);
       case 'fixedpoint'
           [handles] =  fill_fixed_point(handles,first,second,third);
       case 'birgevieta'
           [handles] =  fill_birge_vieta(handles,first,second,third);
       case 'newtonraphson'
           [handles] =  fill_newton_raphson(handles,first,second,third);
       case 'secant'
          fourth = fgetl(fileID);
          [handles] = fill_secant(handles,first,second,third,fourth);          
    end;
    end;
end;
   if(counter ~= 1)
       set(handles.method_drop_down,'value',1);
       handles.current_panel = 'BisectionMethod';
       handles.prev_panel = 'BisectionMethod';
       handles.flag_default = 1;
   end;
     guidata(hObject, handles);
     [handles] = switching_panels(hObject,handles);

function  [handles] =  fill_bisection(handles,first,second,third,fourth)
set(handles.BisectionXlower, 'String',first);
set(handles.BisectionXupper, 'String',second);
set(handles.BisectionNoOfIterations, 'String',third);
set(handles.BisectionEpsilon, 'String',fourth);
handles.prev_panel = handles.current_panel;
handles.current_panel = 'BisectionMethod';
set(handles.method_drop_down,'value',2);

function [handles] = fill_brent(handles)
handles.prev_panel = handles.current_panel;
handles.current_panel = 'BrentMethod';
set(handles.method_drop_down,'value',8);


function  [handles] =  fill_brent_multiplicity(handles)
handles.prev_panel = handles.current_panel;
handles.current_panel = 'BrentMultiplicityMethod';
set(handles.method_drop_down,'value',9);






function  [handles] =  fill_false_position(handles,first,second,third,fourth)
set(handles.FalsePostionXlower, 'String',first);
set(handles.FalsePostionXupper, 'String',second);
set(handles.FalsePositionNoOfIterations, 'String',third);
set(handles.FalsePositionEpsilon, 'String',fourth);
handles.prev_panel = handles.current_panel;
handles.current_panel = 'FalsePositionMethod';
set(handles.method_drop_down,'value',3);




function  [handles] =  fill_secant(handles,first,second,third,fourth)
set(handles.SecantFirstPoint, 'String',first);
set(handles.SecantSecondPoint, 'String',second);
set(handles.SecantNoOfIterations, 'String',third);
set(handles.SecantEpsilon, 'String',fourth);
handles.prev_panel = handles.current_panel;
handles.current_panel = 'SecantMethod';
set(handles.method_drop_down,'value',6);


function  [handles] =  fill_newton_raphson(handles,first,second,third)
set(handles.NewtonRaphsonXi, 'String',first);
set(handles.NewtonRaphsonNoOfIterations, 'String',second);
set(handles.NewtonRaphsonEpsilon, 'String',third);
handles.prev_panel = handles.current_panel;
handles.current_panel = 'NewtonRaphsonMethod';
set(handles.method_drop_down,'value',5);

function  [handles] =  fill_birge_vieta(handles,first,second,third)
set(handles.BirgeVietaXi, 'String',first);
set(handles.BirgeVietaNoOfIterations, 'String',second);
set(handles.BirgeVietaEpsilon, 'String',third);
handles.prev_panel = handles.current_panel;
handles.current_panel = 'BirgeVietaMethod';
set(handles.method_drop_down,'value',7);


function  [handles] =  fill_fixed_point(handles,first,second,third)
set(handles.FixedPointIterationXi, 'String',first);
set(handles.FixedPointIterationNoOfIterations, 'String',second);
set(handles.FixedPointIterationEpsilon, 'String',third);
handles.prev_panel = handles.current_panel;
handles.current_panel = 'FixedPointIterationMethod';
set(handles.method_drop_down,'value',4);

