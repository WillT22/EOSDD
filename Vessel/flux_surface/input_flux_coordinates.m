% puts the cylindrical coordinates made by the flux_coordinates function into a .dat file

fileID = fopen('SULI21/Vessel/flux_surface/input_flux_coords.dat','w');   % opens the file for modification

    % DATA
    NR = 201;                                       % Number of radial gridpoints
    NZ = 201;                                       % Number of vertical gridpoints
    NPHI = 36;                                      % Number of toroidal gridpoints
    RMIN = floor(min(flux_co(10).r)*10)/10;         % Minimum extend of radial grid
    RMAX = ceil(max(flux_co(10).r)*10)/10;          % Maximum extent of radial grid
    ZMIN = floor(min(flux_co(10).z)*10)/10;         % Minimum extent of vertical grid
    ZMAX = ceil(max(flux_co(10).z)*10)/10;          % Maximum extent of vertical grid
    PHIMIN = floor(min(flux_co(10).phi)*10)/10;     % Minimum extent of toroidal grid (overwritten by mgrid or coils file)
    PHIMAX = 2*pi;                                  % Maximum extent of toroidal grid (overwritten by mgrid or coils file)
    MU = 1E-6;                                         % Fieldline diffusion 
    
    % Variable start points for R, Z, and PHI
    size_r = size(flux_co(10).r,1);
    arr_index = [1:size_r]';                           % creates an array of indecies
    file_data = [arr_index, flux_co(10).r, arr_index,...            % creates an array of alternating index columns and coordinate columns
        flux_co(10).z, arr_index, flux_co(10).phi];
    
    PHI_END = ceil(max(flux_co(10).phi)*10)/10;     % Maximum distance in the toroidal direction to follow fieldlines
    NPOINC = 120;                                   % Number of toroidal points per-period to output the field line trajectory
    INT_TYPE = 'LSODE';                             % Fieldline integration method (NAG, RKH68, LSODE)
    FOLLOW_TOL = 1E-9;                              % Fieldline following tollerance
    VC_ADAPT_TOL = 1E-7;
    
% sets up the format for the file to populate
    % FIELDLINES_INPUT
    fprintf(fileID, '/\n');
    fprintf(fileID, '&FIELDLINES_INPUT\n');
    fprintf(fileID, 'NR = %.0f \n', NR);
    fprintf(fileID, 'NZ = %.0f \n', NZ);
    fprintf(fileID, 'NPHI = %.0f \n', NPHI);
    fprintf(fileID, 'RMIN = %.3f \n', RMIN);
    fprintf(fileID, 'RMAX = %.3f \n', RMAX);
    fprintf(fileID, 'ZMIN = %.1f \n', ZMIN);
    fprintf(fileID, 'ZMAX = %.1f \n', ZMAX);
    fprintf(fileID, 'PHIMIN = %.1f \n', PHIMIN);
    fprintf(fileID, 'PHIMAX = %.10f \n', PHIMAX);
    fprintf(fileID, 'MU = %.1d \n', MU);
    fprintf(fileID, 'R_START(%.0d) = %20.12e    Z_START(%.0d) = %20.12e    PHI_START(%.0d) = %20.12e\n', file_data');
    fprintf(fileID, 'PHIEND = %.0d*%.1f \n', size_r, PHI_END);
    fprintf(fileID, 'NPOINC = %.0f \n', NPOINC);
    fprintf(fileID, 'INT_TYPE = ''%s'' \n', INT_TYPE);
    fprintf(fileID, 'FOLLOW_TOL = %.1d \n', FOLLOW_TOL);
    fprintf(fileID, 'VC_ADAPT_TOL = %.1d \n', VC_ADAPT_TOL);
    fprintf(fileID, '&END');
    
fclose(fileID); % closes the file
