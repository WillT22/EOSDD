% saves torus vertice/face data as a .dat file

fileID_t = fopen('SULI21/Vessel/torus_vessel.dat','w');           % opens the file for modification

vessel_name = 'NCSX Ex Torus Vessel';
date = datestr(now, 'mmm-dd-yyyy');
vertice_total = size(torus.vertices,1);                           % creates an array of indecies
face_total = size(torus.faces,1);

% prints to the file
    % HEADER:
    fprintf(fileID_t, 'MACHINE: %s \n', vessel_name);   % prints the macine name
    fprintf(fileID_t, 'DATE: %s \n', date);
    fprintf(fileID_t, 'Vertices: %.0d   Faces: %.0d\n\n', vertice_total, face_total);  
    % DATA:
    fprintf(fileID_t, '%20.10e %20.10e %20.10e\n', torus.vertices');    % sets up the format for vertex data
    fprintf(fileID_t, '%6.0d %6.0d %6.0d\n', torus.faces');             % sets up the format for face data
    fprintf(fileID_t, '/');
fclose(fileID_t); % closes the file