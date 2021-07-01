% puts the cylindrical coordinates made by the flux_coordinates function into a .dat file

fileID = fopen('SULI21/Vessel/flux_surface/flux_coords.dat','w');            % opens the file for modification
fprintf(fileID, 'Flux Surface Cylindrical Coordinates\n\n');    % makes the header

arr_index = [1:size(flux_co(10).r)]';                           % creates an array of indecies
file_data = [arr_index, flux_co(10).r, arr_index,...            % creates an array of alternating index columns and coordinate columns
    flux_co(10).z, arr_index, flux_co(10).phi];

% sets up the format for the file to populate
fprintf(fileID, 'R(%.0d) = %.12d    Z(%.0d) = %.12d     PHI(%.0d) = %.12d\n', file_data');
fclose(fileID); % closes the file
