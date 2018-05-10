    function [is_valid, full_tagname] = Validator(handles)
    selected_method = get(handles.method_drop_down, 'value');
    is_valid_equ = true;
    is_valid = true;
    tagname = {};
    
    
    switch selected_method 
        case 1
          [is_valid2, tagname2] = validate_bisection(handles);
          [is_valid3, tagname3] = validate_fixed_point(handles);
          [is_valid4, tagname4] = validate_false_position(handles);
          [is_valid5, tagname5] = validate_newton_raphson(handles);
          [is_valid6, tagname6] = validate_secant(handles);
          is_valid_equ = is_polynomial(get(handles.EquationText,'string'));
          [is_valid7, tagname7] = validate_birge_vieta(handles);
          is_valid = is_valid2 & is_valid3 & is_valid4 & is_valid5 & is_valid6 & is_valid7;
          tagname = vertcat(tagname2, tagname3, tagname4, tagname5, tagname6, tagname7);
        case 2
          [is_valid, tagname] = validate_bisection(handles);
        case 3 
          [is_valid, tagname] = validate_false_position(handles);
        case 4
          [is_valid, tagname] = validate_fixed_point(handles);
        case 5
          [is_valid, tagname] = validate_newton_raphson(handles);
        case 6
          [is_valid, tagname] = validate_secant(handles);
        case 7
           is_valid_equ = is_polynomial(get(handles.EquationText,'string'));
          [is_valid, tagname] = validate_birge_vieta(handles);
    end;
    if(is_valid_equ)
    is_valid_equ = validate_equation(get(handles.EquationText,'string'));
    end;
   
    if(~is_valid_equ) 
        equ{1} = {get(handles.EquationTextErrorMsg,'tag')};
       full_tagname = vertcat(tagname, equ);
       is_valid = false;
    else 
     full_tagname = tagname;   
        
    end;
    


function is_valid_equ = validate_equation(equation) 
   is_valid_equ = true;
try 
x = 0; 
A = eval (equation);
catch 
    is_valid_equ = false;
end;
if(isempty(equation))
    is_valid_equ = false;
end;
% [num, status] = str2num(equation);
% if(status)
%     is_valid_equ = false;
% end;

   
    
    
    
   
            
    function [is_valid, tagname] = validate_bisection(handles)
         tagname = {};
    x_lower = get(handles.BisectionXlower,'string');
    x = str2double(x_lower);
    status1 = ~xor(strcmpi(strtrim(x_lower),'NaN'),isnan(x));
    i = 1;
    if(~status1)  
        tagname{i} = {get(handles.BisectionXlowerErrorMsg,'Tag')};
       i = i + 1;
    end;
    
    x_upper = get(handles.BisectionXupper,'string');
    x = str2double(x_upper);
    status2 = ~xor(strcmpi(strtrim(x_lower),'NaN'),isnan(x));
    if(~status2)  
       tagname{i} = {get(handles.BisectionXupperErrorMsg,'tag')};
       i = i + 1;
    end;
    
    iter = get(handles.BisectionNoOfIterations,'string');
    [num, status3] = str2num(iter);
     if(isempty(iter)) 
      status3 = true;
     end
    if(~status3)  
       tagname{i} = {get(handles.BisectionNoOfIterationsErrorMsg,'tag')};
       i = i + 1;
    end;
    
     eps = get(handles.BisectionEpsilon,'string');
  %  x = str2double(eps);
  %  status4 = strcmpi(strtrim(eps),'NaN');
  [num, status4] = str2num(eps);
  if(isempty(eps)) 
      status4 = true;
  end
    if(~status4)  
       tagname{i} = {get(handles.BisectionEpsilonErrorMsg, 'tagname')};
       i = i + 1;
    end;
    is_valid = status1 & status2 & status3 & status4;
    tagname = tagname';
   
    
    
    function [is_valid, tagname] = validate_fixed_point(handles)
         tagname = {};
    initial = get(handles.FixedPointIterationXi,'string');
    x = str2double(initial);
    status1 = ~xor(strcmpi(strtrim(initial),'NaN'),isnan(x));
    i = 1;
    if(~status1)  
        tagname{i} = {get(handles.FixedPointIterationXiErrorMsg, 'tag')};
        i = i + 1;
    end;
    
    iter = get(handles.FixedPointIterationNoOfIterations,'string');
    [num, status2] = str2num(iter);
     if(isempty(iter)) 
      status2 = true;
     end
    if(~status2)  
       tagname{i} = {get(handles.FixedPointIterationNoOfIterationsErrorMsg, 'tag')};
       i = i + 1;
    end;
    
     eps = get(handles.FixedPointIterationEpsilon,'string');
  %  x = str2double(eps);
  %  status4 = strcmpi(strtrim(eps),'NaN');
  [num, status3] = str2num(eps);
  if(isempty(eps)) 
      status3 = true;
  end
    if(~status3)  
        tagname{i} = {get(handles.FixedPointIterationEpsilonErrorMsg, 'tag')};
        i = i + 1;
    end;
    is_valid = status1 & status2 & status3;
    tagname = tagname';
  
    
     function [is_valid, tagname] = validate_false_position(handles)
          tagname = {};
    x_lower = get(handles.FalsePostionXlower,'string');
    x = str2double(x_lower);
    status1 = ~xor(strcmpi(strtrim(x_lower),'NaN'),isnan(x));
    i = 1;
    if(~status1)  
        tagname{i} = {get(handles.FalsePostionXlowerErrorMsg, 'tag')};
        i = i + 1;
    end;
    
    x_upper = get(handles.FalsePostionXupper,'string');
    x = str2double(x_upper);
    status2 = ~xor(strcmpi(strtrim(x_lower),'NaN'),isnan(x));
    if(~status2)  
        tagname{i} = {get(handles.FalsePostionXupperErrorMsg, 'tag')};
        i = i + 1;
    end;
    
    iter = get(handles.FalsePositionNoOfIterations,'string');
    [num, status3] = str2num(iter);
     if(isempty(iter)) 
      status3 = true;
     end
    if(~status3)  
       tagname{i}  = {get(handles.FalsePositionNoOfIterationsErrorMsg, 'tag')};
       i = i + 1;
    end;
    
     eps = get(handles.FalsePositionEpsilon,'string');
  %  x = str2double(eps);
  %  status4 = strcmpi(strtrim(eps),'NaN');
  [num, status4] = str2num(eps);
  if(isempty(eps)) 
      status4 = true;
  end
    if(~status4)  
       tagname{i} = {get(handles.FalsePositionEpsilonErrorMsg, 'tag')};
       i = i + 1;
    end;
    is_valid = status1 & status2 & status3 & status4;
 tagname = tagname';
    
 function [is_valid, tagname] = validate_newton_raphson(handles)
     tagname = {};
     i = 1;
    initial = get(handles.NewtonRaphsonXi,'string');
    x = str2double(initial);
    status1 = ~xor(strcmpi(strtrim(initial),'NaN'),isnan(x));
    if(~status1)  
       tagname{i} = {get(handles.NewtonRaphsonXiErrorMsg, 'tag')};
       i = i + 1;
    end;
    
    iter = get(handles.NewtonRaphsonNoOfIterations,'string');
    [num, status2] = str2num(iter);
     if(isempty(iter)) 
      status2 = true;
     end
    if(~status2)  
       tagname{i} = {get(handles.NewtonRaphsonNoOfIterationsErrorMsg, 'tag')};
       i = i + 1;
    end;
    
     eps = get(handles.NewtonRaphsonEpsilon,'string');
  [num, status3] = str2num(eps);
  if(isempty(eps)) 
      status3 = true;
  end
    if(~status3)  
        tagname{i} = {get(handles.NewtonRaphsonEpsilonErrorMsg, 'tag')};
       i = i + 1;
    end;
    is_valid = status1 & status2 & status3;
    tagname = tagname';
  
    
    function [is_valid, tagname] = validate_secant(handles)
    tagname = {};
    i = 1;     
    first_iter = get(handles.SecantFirstPoint,'string');
    x = str2double(first_iter);
    status1 = ~xor(strcmpi(strtrim(first_iter),'NaN'),isnan(x));
    if(~status1)  
       tagname{i} = {get(handles.SecantFirstPointErrorMsg, 'tag')};
       i = i + 1;
    end;
    
    secont_iter = get(handles.SecantSecondPoint,'string');
    x = str2double(secont_iter);
    status2 = ~xor(strcmpi(strtrim(first_iter),'NaN'),isnan(x));
    if(~status2)  
         tagname{i} = {get(handles.SecantSecondPointErrorMsg, 'tag')};
         i = i + 1;
    end;
    
    iter = get(handles.SecantNoOfIterations,'string');
    [num, status3] = str2num(iter);
     if(isempty(iter)) 
      status3 = true;
     end
    if(~status3)  
       tagname{i} = {get(handles.SecantNoOfIterationsErrorMsg, 'tag')};
       i = i + 1;
    end;
    
     eps = get(handles.SecantEpsilon,'string');
 
  [num, status4] = str2num(eps);
  if(isempty(eps)) 
      status4 = true;
  end
    if(~status4)  
       tagname{i}= {get(handles.SecantEpsilonErrorMsg, 'tag')};
       i = i + 1;
    end;
    is_valid = status1 & status2 & status3 & status4;
    tagname = tagname';
    
    
    function [is_valid, tagname] = validate_birge_vieta(handles)
    tagname = {};
    i = 1;
    initial = get(handles.BirgeVietaXi,'string');
    x = str2double(initial);
    status1 = ~xor(strcmpi(strtrim(initial),'NaN'),isnan(x));
    if(~status1)  
        %error in xlower
        tagname{i} = {get(handles.BirgeVietaXiErrorMsg,'tag')};
        i = i + 1;
    end;
    
    iter = get(handles.BirgeVietaNoOfIterations,'string');
    [num, status2] = str2num(iter);
     if(isempty(iter)) 
      status2 = true;
     end
    if(~status2)  
        %error in number of iterations
        tagname{i} = {get(handles.BirgeVietaNoOfIterationsErrorMsg, 'tag')};
        i = i + 1;
    end;
    
     eps = get(handles.BirgeVietaEpsilon,'string');
  %  x = str2double(eps);
  %  status4 = strcmpi(strtrim(eps),'NaN');
  [num, status3] = str2num(eps);
  if(isempty(eps)) 
      status3 = true;
  end
    if(~status3)  
        %error in xlower
        tagname{i} = {get(handles.BirgeVietaEpsilonErrorMsg, 'tag')};
        i = i + 1;
    end;
    
    is_valid = status1 & status2 & status3; 
    tagname = tagname';
    
        function is_poly = is_polynomial(equation)
        is_poly = true;
%         try     
%         syms x;
%         sym2poly(equation); % a is matrix of x coefficients
%         catch 
%             is_poly = false;
%         end;
     
            
                
         