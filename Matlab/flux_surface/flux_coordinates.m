function [flux_co] = flux_coordinates(fieldline_file, line_number)

switch nargin
    case 1
        line_number = [];
    case 2 
    otherwise
        error('2 inputs are accepted.')
end

if isempty(line_number)
    arr = [1:size(fieldline_file.R_lines,1)];
    string(arr);
    for i = 1:size(fieldline_file.R_lines,1)
        flux_co(i).r = [fieldline_file.R_lines(i,1:end-1)]';
        flux_co(i).z = [fieldline_file.Z_lines(i,1:end-1)]';
        flux_co(i).phi = [fieldline_file.PHI_lines(i,1:end-1)]';
    end
else
    flux_co(1).r = [fieldline_file.R_lines(line_number,1:end-1)]';
    flux_co(1).z = [fieldline_file.Z_lines(line_number,1:end-1)]';
    flux_co(1).phi = [fieldline_file.PHI_lines(line_number,1:end-1)]';
end