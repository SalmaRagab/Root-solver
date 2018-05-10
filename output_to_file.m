function [] = output_to_file( column_names_matrix , data_matrix, results_matrix, method_name, error_msg)

file_name = strcat(method_name,'.txt');
fileID = fopen(file_name,'wt');


col_no = size(column_names_matrix, 2);
row_no = size(data_matrix, 1);
space_no = 10;
formatspec = 200;

%  title 

fprintf(fileID,'%s: ',method_name);
fprintf(fileID,'\n');
fprintf(fileID,'\n');

% check if result table is empty 

if size(data_matrix,1) > 0 % could be nan
    if (isnan(data_matrix))
        if (~isempty(error_msg))
            fprintf(fileID,'%s ',error_msg);
        else 
            fprintf(fileID,'%s ','No results');
        end
    else

        %get max width in each col
        max = get_max(column_names_matrix , data_matrix, col_no, row_no, formatspec);

        % header
        header_length = write_header(max, column_names_matrix , col_no, space_no, fileID);

        fprintf(fileID,'\n');
        draw_separator(header_length, fileID);

        % data
        write_data(max, data_matrix ,col_no, row_no, formatspec, space_no, fileID);

        fprintf(fileID,'\n');
        draw_separator(header_length, fileID);

    %     check to print error or results

        if (isempty(error_msg))
            % results 
            fprintf(fileID,'\n');
            results (results_matrix, fileID);
        else
            fprintf(fileID,'%s', error_msg);
        end

    end
else
    if (~isempty(error_msg))
        fprintf(fileID,'%s ',error_msg);
    else 
        fprintf(fileID,'%s ','No results');
    end
end
    
fclose(fileID);
end

% --------------------------------------------------------------------------------
function [max] = get_max( column_names_matrix , data_matrix, col_no, row_no, formatspec)
max = 0;
for i = 1 : col_no
    max(1,i) = length (column_names_matrix{1,i});
end

for i = 1 : row_no
    for j = 1 : col_no
        if isnan(data_matrix(i,j))
            continue;
        end
        if max(1, j) < length (num2str(data_matrix(i,j),formatspec))
           max(1,j) =  length (num2str(data_matrix(i,j),formatspec));
        end
    end
    
end

end

% -------------------------------------------------------------------------------
function [header_length] = write_header(max,column_names_matrix, col_no, space_no, fileID)
header_length = 0;
for i = 1 : col_no
    fprintf(fileID,'%s',column_names_matrix{1,i});
    gap = space_no + max(1,i) - length (column_names_matrix{1,i});
    for j = 1 : gap
        fprintf(fileID,' ');
    end
    header_length = header_length + max(1,i) + space_no;
end
end

% ---------------------------------------------------------------------------------

function [] = draw_separator(header_length, fileID)

for i = 1 : header_length
   fprintf(fileID,'_');  
end
fprintf(fileID,'\n');

end 

% ---------------------------------------------------------------------------------

function [] = write_data(max, data_matrix ,col_no, row_no, formatspec, space_no, fileID)
for i = 1 : row_no
    for j = 1 : col_no
        if isnan(data_matrix(i,j)) 
            fprintf(fileID,'%s','');
            gap = space_no + max(1,j);
        else
            fprintf(fileID,'%s',num2str(data_matrix(i,j),formatspec));
            gap = space_no + max(1,j) - length (num2str(data_matrix(i,j),formatspec));
        end
        
        for k = 1 : gap 
            fprintf(fileID,' ');
        end
        
    end
     fprintf(fileID,'\n');
end

end

% ---------------------------------------------------------------------------------

function [] = results (results_matrix, fileID)

row_no = size(results_matrix, 1);

for i = 1 : row_no
   fprintf(fileID,'%s: %s', results_matrix{i,1}, results_matrix{i,2});
   fprintf(fileID,'\n');
end

end