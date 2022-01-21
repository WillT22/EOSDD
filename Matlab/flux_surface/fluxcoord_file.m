% puts the cylindrical coordinates made by the flux_coordinates function into a .dat file

fileID = fopen('SULI21/Vessel/flux_surface/.dat','w');   % opens the file for modification

    % DATA  
    % Variable start points for R, Z, and PHI
    arr_index = [1:size(arr,1)]';                           % creates an array of indecies
    file_data = [arr_index, arr(:,1), arr_index,...            % creates an array of alternating index columns and coordinate columns
        arr(:,2), arr_index, arr(:,3)];

    
fprintf(fileID, 'R_START(%.0d) = %20.12e    Z_START(%.0d) = %20.12e    PHI_START(%.0d) = %20.12e\n', file_data');
fprintf(fileID, '/');
fclose(fileID); % closes the file
