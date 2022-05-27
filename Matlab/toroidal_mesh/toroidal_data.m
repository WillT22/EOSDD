%function toroidal_data(toroidal_structure)
% saves torus vertice/face data as a .dat file
toroidal_structure = fb_30
fileID = fopen('./SULI21/Vessel/fb_30.dat','w');           % opens the file for modification

vessel_name = 'Toroidal Vessel Coil-Plasma Separation 30cm';
date = datestr(now, 'mmm-dd-yyyy');
vertice_total = size(toroidal_structure.vertices,1);       % creates an array of indecies
face_total = size(toroidal_structure.faces,1);

% prints to the file
    % HEADER:
    fprintf(fileID, 'MACHINE: %s \n', vessel_name);   % prints the machine name
    fprintf(fileID, 'DATE: %s \n', date);
    fprintf(fileID, '%.0d %.0d\n', vertice_total, face_total);  
    % DATA:
    fprintf(fileID, '%20.10e %20.10e %20.10e\n', toroidal_structure.vertices');    % sets up the format for vertex data
    fprintf(fileID, '%6.0d %6.0d %6.0d\n', toroidal_structure.faces');             % sets up the format for face data
    fprintf(fileID, '/');
fclose(fileID); % closes the file