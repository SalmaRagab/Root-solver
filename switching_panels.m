function [handles] = switching_panels(hObject,handles)
   current = findobj('Tag', handles.current_panel);
   prev =  findobj('Tag', handles.prev_panel);
   set(prev, 'visible', 'off');
   set(current, 'visible', 'on');
if(get(handles.method_drop_down,'value') == 1)   %all methods
    if(strcmp(handles.current_panel ,'BisectionMethod') == 0) %not bisection
     set(handles.back_button, 'visible', 'on');
    else  %bisection
     set(handles.back_button, 'visible', 'off');
     set(handles.next_button, 'visible', 'on');
    end
    if(strcmp(handles.current_panel ,'SecantMethod') ==0) %not secant
     set(handles.submit_button, 'visible', 'off');
     set(handles.next_button, 'visible', 'on');
    else  %secant
     set(handles.submit_button, 'visible', 'on');
     set(handles.next_button, 'visible', 'off');
    end;
else    %specific method
   set(handles.back_button, 'visible', 'off');
   set(handles.submit_button, 'visible', 'on');
   set(handles.next_button, 'visible', 'off');
end
   guidata(hObject,handles);