function [rand_flux_co] = rand_flux_coordinates(fieldline_file, number_of_coordinates ,line_number)

switch nargin
    case 1
        line_number = [];
        number_of_coordinates = size([fieldline_file.PHI_lines(1,1:end-1)]',1);
    case 2 
        line_number = [];
    otherwise
        error('3 inputs are accepted.')
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

min = -(pi/number_of_coordinates);   % minimum value to add to phi
max =  (pi/number_of_coordinates);   % maximum value to add to phi
rv = (max-min).*rand(number_of_coordinates,1) + min; % random number calculation
    if rv(1) < 0
       rv(1) = -rv(1);
    end
    if rv(end) > 0 
       rv(end) = -rv(end);
    end

for i = 1:size(flux_co,2)
    rand_flux_co(i).phi = linspace(0,flux_co(i).phi(end),number_of_coordinates)' + rv;   
        rarr = [flux_co(i).phi, flux_co(i).r];
        ru = unique(rarr,'rows');
        rand_flux_co(i).r = interp1(ru(:,1), ru(:,2), rand_flux_co(i).phi);
    rand_flux_co(i).z = flux_co(i).z;    
        zarr = [flux_co(i).phi, flux_co(i).z];
        zu = unique(zarr,'rows');
        rand_flux_co(i).z = interp1(zu(:,1), zu(:,2), rand_flux_co(i).phi);
end
end