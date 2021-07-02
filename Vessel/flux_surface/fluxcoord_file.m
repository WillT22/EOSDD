% puts the cylindrical coordinates made by the flux_coordinates function into a .dat file

fileID = fopen('SULI21/Vessel/flux_surface/flux_coords.dat','w');   % opens the file for modification

    % DATA  
    % Variable start points for R, Z, and PHI
    arr_index = [1:size(flux_co(10).r)]';                           % creates an array of indecies
    file_data = [arr_index, flux_co(10).r, arr_index,...            % creates an array of alternating index columns and coordinate columns
        flux_co(10).z, arr_index, flux_co(10).phi];

    
fprintf(fileID, 'R_START(%.0d) = %20.12e    Z_START(%.0d) = %20.12e    PHI_START(%.0d) = %20.12e\n', file_data');
fprintf(fileID, '/');
fclose(fileID); % closes the file
