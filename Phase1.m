function varargout = Phase1(varargin)
% Phase1 MATLAB code for Phase1.fig
%      Phase1, by itself, creates a new Phase1 or raises the existing
%      singleton*.
%
%      H = Phase1 returns the handle to a new Phase1 or the handle to
%      the existing singleton*.
%
%      Phase1('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in Phase1.M with the given input arguments.
%
%      Phase1('Property','Value',...) creates a new Phase1 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Phase1_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Phase1_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Phase1

% Last Modified by GUIDE v2.5 14-May-2017 00:26:15
gui_Singleton = 1;

gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Phase1_OpeningFcn, ...
                   'gui_OutputFcn',  @Phase1_OutputFcn, ...
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


% --- Executes just before Phase1 is made visible.
function Phase1_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Phase1 (see VARARGIN)

% Choose default command line output for Phase1
handles.output = hObject;



% Begin initialization code - DO NOT EDIT
handles.current_panel = 'BisectionMethod';
handles.prev_panel = 'BisectionMethod';
handles.flag_default = 1;
handles.ErrorMsgs = '';

% Update handles structure
guidata(hObject, handles);
set(handles.SecantMethod, 'visible', 'off');
set(handles.submit_button, 'visible', 'off');
set(handles.back_button, 'visible', 'off');
set(handles.BirgeVietaMethod, 'visible', 'off');
set(handles.FixedPointIterationMethod, 'visible', 'off');
set(handles.SecantMethod, 'visible', 'off');
set(handles.NewtonRaphsonMethod, 'visible', 'off');
set(handles.FalsePositionMethod, 'visible', 'off');
set(handles.BrentMethod, 'visible', 'off');
set(handles.BrentMultiplicityMethod, 'visible', 'off');
% UIWAIT makes Phase1 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Phase1_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --------------------------------------------------------------------




function EquationText_Callback(hObject, eventdata, handles)
% hObject    handle to EquationText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)




% Hints: get(hObject,'String') returns contents of EquationText as text
%        str2double(get(hObject,'String')) returns contents of EquationText as a double


% --- Executes during object creation, after setting all properties.
function EquationText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EquationText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end





% --- Executes on selection change in method_drop_down.
function method_drop_down_Callback(hObject, eventdata, handles)
contents = cellstr(get(hObject,'String'));
handles.prev_panel = handles.current_panel;
if(strcmp(contents{get(hObject,'Value')},'All') == 0)  %not default
    handles.current_panel = regexprep(contents{get(hObject,'Value')},'[^\w'']','');
    handles.flag_default = 0;
else
    handles.current_panel = 'BisectionMethod';
    handles.flag_default = 1;
end;
guidata(hObject,handles)
switching_panels(hObject,handles);


% --- Executes during object creation, after setting all properties.
function method_drop_down_CreateFcn(hObject, eventdata, handles)
% hObject    handle to method_drop_down (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function BisectionXlower_Callback(hObject, eventdata, handles)
% hObject    handle to BisectionXlower (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of BisectionXlower as text
%        str2double(get(hObject,'String')) returns contents of BisectionXlower as a double


% --- Executes during object creation, after setting all properties.
function BisectionXlower_CreateFcn(hObject, eventdata, handles)
% hObject    handle to BisectionXlower (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function BisectionXupper_Callback(hObject, eventdata, handles)
% hObject    handle to BisectionXupper (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of BisectionXupper as text
%        str2double(get(hObject,'String')) returns contents of BisectionXupper as a double


% --- Executes during object creation, after setting all properties.
function BisectionXupper_CreateFcn(hObject, eventdata, handles)
% hObject    handle to BisectionXupper (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function BisectionNoOfIterations_Callback(hObject, eventdata, handles)
% hObject    handle to BisectionNoOfIterations (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of BisectionNoOfIterations as text
%        str2double(get(hObject,'String')) returns contents of BisectionNoOfIterations as a double


% --- Executes during object creation, after setting all properties.
function BisectionNoOfIterations_CreateFcn(hObject, eventdata, handles)
% hObject    handle to BisectionNoOfIterations (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function BisectionEpsilon_Callback(hObject, eventdata, handles)
% hObject    handle to BisectionEpsilon (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of BisectionEpsilon as text
%        str2double(get(hObject,'String')) returns contents of BisectionEpsilon as a double


% --- Executes during object creation, after setting all properties.
function BisectionEpsilon_CreateFcn(hObject, eventdata, handles)
% hObject    handle to BisectionEpsilon (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function SecantFirstPoint_Callback(hObject, eventdata, handles)
% hObject    handle to SecantFirstPoint (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of SecantFirstPoint as text
%        str2double(get(hObject,'String')) returns contents of SecantFirstPoint as a double


% --- Executes during object creation, after setting all properties.
function SecantFirstPoint_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SecantFirstPoint (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function SecantNoOfIterations_Callback(hObject, eventdata, handles)
% hObject    handle to SecantNoOfIterations (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of SecantNoOfIterations as text
%        str2double(get(hObject,'String')) returns contents of SecantNoOfIterations as a double


% --- Executes during object creation, after setting all properties.
function SecantNoOfIterations_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SecantNoOfIterations (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function SecantEpsilon_Callback(hObject, eventdata, handles)
% hObject    handle to SecantEpsilon (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of SecantEpsilon as text
%        str2double(get(hObject,'String')) returns contents of SecantEpsilon as a double


% --- Executes during object creation, after setting all properties.
function SecantEpsilon_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SecantEpsilon (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




% --- Executes on button press in back_button.
function back_button_Callback(hObject, eventdata, handles)
% hObject    handle to back_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[handles] = get_prev_panel_back_pressed(hObject,handles);
[handles] = switching_panels(hObject,handles);



function SecantSecondPoint_Callback(hObject, eventdata, handles)
% hObject    handle to SecantSecondPoint (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of SecantSecondPoint as text
%        str2double(get(hObject,'String')) returns contents of SecantSecondPoint as a double


% --- Executes during object creation, after setting all properties.
function SecantSecondPoint_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SecantSecondPoint (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function BirgeVietaXi_Callback(hObject, eventdata, handles)
% hObject    handle to BirgeVietaXi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of BirgeVietaXi as text
%        str2double(get(hObject,'String')) returns contents of BirgeVietaXi as a double


% --- Executes during object creation, after setting all properties.
function BirgeVietaXi_CreateFcn(hObject, eventdata, handles)
% hObject    handle to BirgeVietaXi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function BirgeVietaNoOfIterations_Callback(hObject, eventdata, handles)
% hObject    handle to BirgeVietaNoOfIterations (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of BirgeVietaNoOfIterations as text
%        str2double(get(hObject,'String')) returns contents of BirgeVietaNoOfIterations as a double


% --- Executes during object creation, after setting all properties.
function BirgeVietaNoOfIterations_CreateFcn(hObject, eventdata, handles)
% hObject    handle to BirgeVietaNoOfIterations (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function BirgeVietaEpsilon_Callback(hObject, eventdata, handles)
% hObject    handle to BirgeVietaEpsilon (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of BirgeVietaEpsilon as text
%        str2double(get(hObject,'String')) returns contents of BirgeVietaEpsilon as a double


% --- Executes during object creation, after setting all properties.
function BirgeVietaEpsilon_CreateFcn(hObject, eventdata, handles)
% hObject    handle to BirgeVietaEpsilon (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function NewtonRaphsonXi_Callback(hObject, eventdata, handles)
% hObject    handle to NewtonRaphsonXi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of NewtonRaphsonXi as text
%        str2double(get(hObject,'String')) returns contents of NewtonRaphsonXi as a double


% --- Executes during object creation, after setting all properties.
function NewtonRaphsonXi_CreateFcn(hObject, eventdata, handles)
% hObject    handle to NewtonRaphsonXi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function NewtonRaphsonNoOfIterations_Callback(hObject, eventdata, handles)
% hObject    handle to NewtonRaphsonNoOfIterations (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of NewtonRaphsonNoOfIterations as text
%        str2double(get(hObject,'String')) returns contents of NewtonRaphsonNoOfIterations as a double


% --- Executes during object creation, after setting all properties.
function NewtonRaphsonNoOfIterations_CreateFcn(hObject, eventdata, handles)
% hObject    handle to NewtonRaphsonNoOfIterations (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function NewtonRaphsonEpsilon_Callback(hObject, eventdata, handles)
% hObject    handle to NewtonRaphsonEpsilon (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of NewtonRaphsonEpsilon as text
%        str2double(get(hObject,'String')) returns contents of NewtonRaphsonEpsilon as a double


% --- Executes during object creation, after setting all properties.
function NewtonRaphsonEpsilon_CreateFcn(hObject, eventdata, handles)
% hObject    handle to NewtonRaphsonEpsilon (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




function FixedPointIterationXi_Callback(hObject, eventdata, handles)
% hObject    handle to FixedPointIterationXi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of FixedPointIterationXi as text
%        str2double(get(hObject,'String')) returns contents of FixedPointIterationXi as a double


% --- Executes during object creation, after setting all properties.
function FixedPointIterationXi_CreateFcn(hObject, eventdata, handles)
% hObject    handle to FixedPointIterationXi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function FixedPointIterationNoOfIterations_Callback(hObject, eventdata, handles)
% hObject    handle to FixedPointIterationNoOfIterations (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of FixedPointIterationNoOfIterations as text
%        str2double(get(hObject,'String')) returns contents of FixedPointIterationNoOfIterations as a double


% --- Executes during object creation, after setting all properties.
function FixedPointIterationNoOfIterations_CreateFcn(hObject, eventdata, handles)
% hObject    handle to FixedPointIterationNoOfIterations (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function FixedPointIterationEpsilon_Callback(hObject, eventdata, handles)
% hObject    handle to FixedPointIterationEpsilon (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of FixedPointIterationEpsilon as text
%        str2double(get(hObject,'String')) returns contents of FixedPointIterationEpsilon as a double


% --- Executes during object creation, after setting all properties.
function FixedPointIterationEpsilon_CreateFcn(hObject, eventdata, handles)
% hObject    handle to FixedPointIterationEpsilon (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function FalsePostionXlower_Callback(hObject, eventdata, handles)
% hObject    handle to FalsePostionXlower (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of FalsePostionXlower as text
%        str2double(get(hObject,'String')) returns contents of FalsePostionXlower as a double


% --- Executes during object creation, after setting all properties.
function FalsePostionXlower_CreateFcn(hObject, eventdata, handles)
% hObject    handle to FalsePostionXlower (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function FalsePostionXupper_Callback(hObject, eventdata, handles)
% hObject    handle to FalsePostionXupper (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of FalsePostionXupper as text
%        str2double(get(hObject,'String')) returns contents of FalsePostionXupper as a double


% --- Executes during object creation, after setting all properties.
function FalsePostionXupper_CreateFcn(hObject, eventdata, handles)
% hObject    handle to FalsePostionXupper (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function FalsePositionNoOfIterations_Callback(hObject, eventdata, handles)
% hObject    handle to FalsePositionNoOfIterations (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of FalsePositionNoOfIterations as text
%        str2double(get(hObject,'String')) returns contents of FalsePositionNoOfIterations as a double


% --- Executes during object creation, after setting all properties.
function FalsePositionNoOfIterations_CreateFcn(hObject, eventdata, handles)
% hObject    handle to FalsePositionNoOfIterations (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function FalsePositionEpsilon_Callback(hObject, eventdata, handles)
% hObject    handle to FalsePositionEpsilon (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of FalsePositionEpsilon as text
%        str2double(get(hObject,'String')) returns contents of FalsePositionEpsilon as a double


% --- Executes during object creation, after setting all properties.
function FalsePositionEpsilon_CreateFcn(hObject, eventdata, handles)
% hObject    handle to FalsePositionEpsilon (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function back_button_CreateFcn(hObject, eventdata, handles)
% hObject    handle to back_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called



% --- Executes on button press in submit_button.

function submit_button_Callback(hObject, eventdata, handles)
% hObject    handle to submit_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[handles] = controller(hObject,handles);



% --- Executes on button press in next_button.
function next_button_Callback(hObject, eventdata, handles)
% hObject    handle to next_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[handles] = get_current_panel_next_pressed(hObject,handles);
[handles] = switching_panels(hObject,handles);
    
  function [handles] = get_current_panel_next_pressed(hObject,handles)
switch handles.current_panel
    case 'BisectionMethod'
        handles.prev_panel = 'BisectionMethod';
        handles.current_panel = 'FixedPointIterationMethod';
    case 'NewtonRaphsonMethod'
        handles.prev_panel = 'NewtonRaphsonMethod';
        handles.current_panel = 'BirgeVietaMethod';
    case 'FixedPointIterationMethod'
        handles.prev_panel = 'FixedPointIterationMethod';
        handles.current_panel = 'FalsePositionMethod';
    case 'FalsePositionMethod'
        handles.prev_panel = 'FalsePositionMethod';
        handles.current_panel = 'NewtonRaphsonMethod';
    case 'BirgeVietaMethod'
        handles.prev_panel = 'BirgeVietaMethod';
        handles.current_panel = 'BrentMethod';
    case 'BrentMethod'
        handles.prev_panel = 'BrentMethod';
        handles.current_panel = 'BrentMultiplicityMethod';
    case 'BrentMultiplicityMethod'
        handles.prev_panel = 'BrentMultiplicityMethod';
        handles.current_panel = 'SecantMethod';
end;
guidata(hObject, handles);




function [handles] = get_prev_panel_back_pressed(hObject,handles)
switch handles.current_panel
    case 'NewtonRaphsonMethod'
        handles.prev_panel = 'NewtonRaphsonMethod';
        handles.current_panel = 'FalsePositionMethod';
    case 'FixedPointIterationMethod'
        handles.prev_panel = 'FixedPointIterationMethod';
        handles.current_panel = 'BisectionMethod';
    case 'FalsePositionMethod'
        handles.prev_panel = 'FalsePositionMethod';
        handles.current_panel = 'FixedPointIterationMethod';
    case 'BirgeVietaMethod'
        handles.prev_panel = 'BirgeVietaMethod';
        handles.current_panel = 'NewtonRaphsonMethod';
    case 'SecantMethod'
        handles.prev_panel = 'SecantMethod';
        handles.current_panel = 'BrentMultiplicityMethod';
    case 'BrentMethod'
        handles.prev_panel = 'BrentMethod';
        handles.current_panel = 'BirgeVietaMethod';
    case 'BrentMultiplicityMethod'
        handles.prev_panel = 'BrentMultiplicityMethod';
        handles.current_panel = 'BrentMethod';
end;
guidata(hObject, handles);


% --- Executes on button press in FileChooser.
function FileChooser_Callback(hObject, eventdata, handles)
% hObject    handle to FileChooser (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[FileName,PathName] = uigetfile;
if(FileName ~= 0)
 [handles] =  read_from_file(hObject,handles,strcat(PathName,FileName));
 guidata(hObject, handles);  
end;



function FalsePostionNoOfIterations_Callback(hObject, eventdata, handles)
% hObject    handle to FalsePositionNoOfIterations (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of FalsePositionNoOfIterations as text
%        str2double(get(hObject,'String')) returns contents of FalsePositionNoOfIterations as a double


% --- Executes during object creation, after setting all properties.
function FalsePostionNoOfIterations_CreateFcn(hObject, eventdata, handles)
% hObject    handle to FalsePositionNoOfIterations (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
