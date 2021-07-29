function [rand_flux_co] = rand_flux_coordinates(fieldline_file, line_number)

switch nargin
    case 1
        line_number = [];
    case 2 
    otherwise
        error('2 inputs are accepted.')
end

if isempty(line_number)                         % if the line number is empty, take the coordintates for all fieldlines 
    arr = [1:size(fieldline_file.PHI_lines,1)]; % takes the size of the PHI_lines in the fieldlines file
    string(arr);
    for i = 1:size(fieldline_file.PHI_lines,1)
        flux_co(i).r = [fieldline_file.R_lines(i,1:end-1)]';
        flux_co(i).z = [fieldline_file.Z_lines(i,1:end-1)]';
        flux_co(i).phi = [fieldline_file.PHI_lines(i,1:end-1)]';
    end
else                                            % if the line number is given, take the coordinates for just that line number
    flux_co(1).r = [fieldline_file.R_lines(line_number,1:end-1)]';
    flux_co(1).z = [fieldline_file.Z_lines(line_number,1:end-1)]';
    flux_co(1).phi = [fieldline_file.PHI_lines(line_number,1:end-1)]';
end

a = -0.5;   % minimum value to add to phi
b =  0.5;   % maximum value to add to phi
r = (b-a).*rand(size(flux_co(1).phi,1),1) + a; % random number calculation
for i = 1:size(flux_co,1)
    rand_flux_co(i).phi = flux_co(i).phi + r;
    for j = 1:size(flux_co(1).phi,1)
        rand_flux_co(i).r = flux_co(i).r;
        if flux_co(i).r(j) ~= flux_co(i).r(j+1)
            rand_flux_co(i).r(j) = interp1(flux_co(i).phi, flux_co(i).r, rand_flux_co(i).phi(j));
        end
    end
end
end