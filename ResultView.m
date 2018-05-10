function varargout = ResultView(varargin)
% RESULTVIEW MATLAB code for ResultView.fig
%      RESULTVIEW, by itself, creates a new RESULTVIEW or raises the existing
%      singleton*.
%
%      H = RESULTVIEW returns the handle to a new RESULTVIEW or the handle to
%      the existing singleton*.
%
%      RESULTVIEW('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in RESULTVIEW.M with the given input arguments.
%
%      RESULTVIEW('Property','Value',...) creates a new RESULTVIEW or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ResultView_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ResultView_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ResultView

% Last Modified by GUIDE v2.5 14-May-2017 03:20:23

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ResultView_OpeningFcn, ...
                   'gui_OutputFcn',  @ResultView_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT





% --- Executes just before ResultView is made visible.
function ResultView_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ResultView (see VARARGIN)


% Choose default command line output for ResultView
handles.output = hObject;
handles.fileName = '';
handles.equation = '';
handles.isAll = 0; % 0 : msh All, 1 : All, 2 : Fixed point, 3 : Bisection, 4: False position
handles.xl = [];
handles.xu = [];
handles.xr = [];
handles.roots = []; %contains the approximate roots of all the methods
handles.errors = []; %contains the errors of all the methods
handles.iterations = []; %contains the number of iterations for each method
handles.data = ''; %The static data obtained from the file 
handles.iterator = 1; %index to get the values from the matrices in bisection method


handles.xlLine = '';
handles.xuLine = '';
handles.xrLine = '';


set(handles.results, 'visible', 'off');
set(handles.plot, 'visible', 'off');
set(handles.analysis, 'visible', 'off');
set(handles.results_btn, 'visible', 'off');
set(handles.plot_btn, 'visible', 'off');
set(handles.analysis_btn, 'visible', 'off');
set(handles.next_btn, 'visible', 'off');
set(handles.stepmode_btn, 'visible', 'off');
set(handles.viewResults_btn, 'visible', 'on');



% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ResultView wait for user response (see UIRESUME)
% uiwait(handles.ResultView);


% --- Outputs from this function are returned to the command line.
function varargout = ResultView_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
% set(gcf, 'units','normalized','outerposition',[0 0 1.1 1]);


% --- Executes on button press in results_btn.
function results_btn_Callback(hObject, eventdata, handles)
% hObject    handle to results_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.plot, 'visible', 'off');
set(handles.analysis, 'visible', 'off');

set(handles.results, 'visible', 'on');


% --- Executes on button press in analysis_btn.
function analysis_btn_Callback(hObject, eventdata, handles)
% hObject    handle to analysis_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.plot, 'visible', 'off');
set(handles.results, 'visible', 'off');

set(handles.analysis, 'visible', 'on');

axes(handles.iterations_error); %The number of iterations vs error graph

[length, width] = size (handles.iterations); %- - - - - >> Width = 5
iterations_matrix = [];
roots_matrix = [];

x = [];
y = [];

m = 0;

k = 1;

for i = 1:length
    iterations_matrix{i}= handles.iterations{i,k};
    m = m + 1;       
    
    if (isempty(iterations_matrix{i}) == 0) %not empty
        roots_matrix{i} = handles.errors{i,k};
        
        x{m} = cell2mat(iterations_matrix(i));
        y{m} = cell2mat(roots_matrix(i));
    end
end


[lengthX,widthX] = size(x);

for n = 1:widthX
    a = x{n};
    if (~isempty(a)) %not empty
        switch n 
            case 1 %Bisection
                plot(x{n}, y{n}, 'r', 'DisplayName','Bisection');
            case 2 %False position
                plot(x{n}, y{n}, 'b', 'DisplayName','False Position');
            case 3 %Newton
                plot(x{n}, y{n}, 'y', 'DisplayName','Newton');
            case 4 %Fixed point
                plot(x{n}, y{n}, 'g', 'DisplayName','Fixed Point');
            case 5 %Secant
                plot(x{n}, y{n}, 'color', [0 0.7 0.4], 'DisplayName','Secant');
            case 6 %birge vieta
                plot(x{n}, y{n}, 'color', [1 0 1], 'DisplayName','Berge Vieta');
        end
        hold on
        
    end
end

xlabel('Number of iterations') % x-axis label
ylabel('Errors') % y-axis label
legend('show');

%----------------------------------------------
%DRAW THE NUMBER OF ITERATIONS VS ROOT GRAPH
%----------------------------------------------

axes(handles.iterations_root); %The number of iterations vs error graph

[length, width] = size (handles.roots); %- - - - - >> Width = 5

iterations_matrix = [];
roots_matrix = [];

x = [];
y = [];

m = 0;

k = 1;

for i = 1:length
    iterations_matrix{i}= handles.iterations{i,k};
    m = m + 1;       
    
    if (isempty(iterations_matrix{i}) == 0) %not empty
        roots_matrix{i} = handles.roots{i,k};
        
        x{m} = cell2mat(iterations_matrix(i));
        y{m} = cell2mat(roots_matrix(i));
    end
%     k = k + 1;
end

[lengthX,widthX] = size(x);

for n = 1:widthX
    a = x{n};
    if (~isempty(a)) %not empty
        switch n 
            case 1 %Bisection
                plot(x{n}, y{n}, 'r', 'DisplayName','Bisection');
            case 2 %False position
                plot(x{n}, y{n}, 'b', 'DisplayName','False Position');
            case 3 %Newton
                plot(x{n}, y{n}, 'y', 'DisplayName','Newton');
            case 4 %Fixed point
                plot(x{n}, y{n}, 'g', 'DisplayName','Fixed Point');
            case 5 %Secant
                plot(x{n}, y{n}, 'color', [0 0.7 0.4], 'DisplayName','Secant');
            case 6 %birge vieta
                plot(x{n}, y{n}, 'color', [1 0 1], 'DisplayName','Berge Vieta');
        end
        hold on
        
    end
end

xlabel('Number of iterations') % x-axis label
ylabel('Roots') % y-axis label

legend('show');


% --- Executes on button press in plot_btn.
function plot_btn_Callback(hObject, eventdata, handles)
% hObject    handle to plot_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.results, 'visible', 'off');
set(handles.analysis, 'visible', 'off');

set(handles.plot, 'visible', 'on');
ax = handles.plot_axes;
axes(handles.plot_axes)
switch handles.isAll
    case 2 %Fixed Point ((Plot: G(x), y = x))
        ez1 = ezplot(handles.equation);
        set(ez1, 'LineWidth', 2);
        hold on
        ez2 = ezplot(char('x'));
        set(ez2, 'LineWidth', 2, 'color',[1 0 0]);
        title(ax,['y1 = ' char(handles.equation) '    ' ' y2 = x']);
    case 3  %Bisection ((Next button for showing step by step solution))
        ez1 = ezplot(handles.equation, [handles.xl(1) - 5 , handles.xu(1) + 5]);
        set(ez1, 'LineWidth', 2);
        set(handles.stepmode_btn, 'visible', 'on');
    case 4  %False position ((Next button for showing step by step solution))
        ez1 = ezplot(handles.equation, [handles.xl(1) - 5 , handles.xu(1) + 5]);
        set(ez1, 'LineWidth', 2);
        set(handles.stepmode_btn, 'visible', 'on');    
    otherwise
        ez1 = ezplot(handles.equation); %default range!
        set(ez1, 'LineWidth', 2);
        title(ax,['y = ' char(handles.equation)]);
end

xL = get(gca,'XLim');
line(xL,[0 0],'Color',[0 0 0]); %X-axis


% --- Executes when results is resized.
function results_ResizeFcn(hObject, eventdata, handles)
% hObject    handle to results (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on key press with focus on results_btn and none of its controls.
function results_btn_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to results_btn (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)



% --- Executes on key press with focus on plot_btn and none of its controls.
function plot_btn_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to plot_btn (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in next_btn.
function next_btn_Callback(hObject, eventdata, handles)
% hObject    handle to next_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[length, width] = size (handles.xl);

if (handles.iterator <= length)

    yL = get(gca,'YLim');
    delete(handles.xlLine);
    delete(handles.xuLine);
    delete(handles.xrLine);
    guidata(hObject,handles);
    drawnow();

    handles.xlLine = line([handles.xl(handles.iterator) handles.xl(handles.iterator)],yL,'Color','g');
    handles.xuLine = line([handles.xu(handles.iterator) handles.xu(handles.iterator)],yL,'Color','r');
    handles.xrLine = line([handles.xr(handles.iterator) handles.xr(handles.iterator)],yL,'Color',[0.5 0.2 0.7]);
    
    legend([handles.xlLine handles.xuLine handles.xrLine],{'XLower','XUpper', 'Xr'});
    
    handles.iterator = handles.iterator + 1;
    guidata(hObject,handles);
    drawnow();
end;

% --- Executes on button press in stepmode_btn.
function stepmode_btn_Callback(hObject, eventdata, handles)
% hObject    handle to stepmode_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%show the first bisection iteration

yL = get(gca,'YLim');
handles.xlLine = line([handles.xl(handles.iterator) handles.xl(handles.iterator)],yL,'Color','g');
handles.xuLine = line([handles.xu(handles.iterator) handles.xu(handles.iterator)],yL,'Color','r');
handles.xrLine = line([handles.xr(handles.iterator) handles.xr(handles.iterator)],yL,'Color',[0.5 0.2 0.7]);

handles.iterator = handles.iterator + 1;
guidata(hObject,handles);


legend([handles.xlLine handles.xuLine handles.xrLine],{'XLower','XUpper', 'Xr'});

set(handles.next_btn, 'visible', 'on');
set(handles.stepmode_btn, 'visible', 'off');





% --- Executes during object creation, after setting all properties.
function plot_axes_CreateFcn(hObject, eventdata, handles)
% hObject    handle to plot_axes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate plot_axes


% --- Executes on button press in viewResults_btn.
function viewResults_btn_Callback(hObject, eventdata, handles)
% hObject    handle to viewResults_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.viewResults_btn, 'visible', 'off');

set(handles.results_btn, 'visible', 'on');
set(handles.results, 'visible', 'on');

switch handles.isAll
    case 1 %All the methods ((ANALYSIS MODE))
        set(handles.plot_btn, 'visible', 'off');
        set(handles.analysis_btn, 'visible', 'on');
    otherwise %Not All the methods [0,2,3,4]
        set(handles.analysis_btn, 'visible', 'off');
        set(handles.plot_btn, 'visible', 'on');
end

 fileID = fopen(handles.fileName);
 tableData = get(handles.results_table,'data');
 i = 1;
while ~feof(fileID)
    line = fgetl(fileID);
    if(~isempty(line) && line(1) == '_')
        continue;
    end;
    C = strsplit(line);
    [row,col] = size(C);
    for j = 1 : col
         tableData{i,j} = char(C{1,j});
    end;
   
    i = i+1;
end;
fclose(fileID);
  set(handles.results_table,'Data',tableData);
  set(handles.results_table , 'ColumnName',[]);
  set(handles.results_table , 'rowName',[]);
  set(handles.results_table,'ColumnWidth',{150});
  set(handles.results_table,'BackgroundColor',[1 1 1]);



% --- Executes during object creation, after setting all properties.
function results_text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to results_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function hh_Callback(hObject, eventdata, handles)
% hObject    handle to hh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of hh as text
%        str2double(get(hObject,'String')) returns contents of hh as a double


% --- Executes during object creation, after setting all properties.
function hh_CreateFcn(hObject, eventdata, handles)
% hObject    handle to hh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
