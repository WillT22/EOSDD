function [toroidal_vd] = toroidal_mesh(nescin_file, p, t)

%%%%%%%%%%%%%%% Default Parameters %%%%%%%%%%%%%%
  switch nargin         % creates a few default options
      case 1            % if p and t are empty, use default parameters
          p = 35;
          t = 17;
      case 3    
      otherwise         % else throw error
          error('4 inputs are accepted.')
  end

% read and extract relevant data from the nescin file
fileID = fopen(nescin_file);
fourier_cell = textscan(fileID, '%f%f%f%f%f%f', 'Headerlines', 172, 'CollectOutput', true);
fclose(fileID);
fourier_coeff.m = fourier_cell{1}(:,1);
fourier_coeff.n = fourier_cell{1}(:,2);
fourier_coeff.crc2 = fourier_cell{1}(:,3);
fourier_coeff.czs2 = fourier_cell{1}(:,4);
fourier_coeff.crs2 = fourier_cell{1}(:,5);
fourier_coeff.czc2 = fourier_cell{1}(:,6);
clear fourier_cell;

% translate Fourier data into Cartesian coordinates
a = (p-1) * (t-1); % number of vertices that will be used
phi = linspace(0,2*pi,p);   % partition as measured in the toroidal direction
theta = linspace(0,2*pi,t); % partition as measured in the poloidal direction 
[Phi,Theta]=meshgrid(phi(1:p-1),theta(1:t-1)); % creates an array from phi and theta 
Phi = reshape(Phi,[a,1]);
Theta = reshape(Theta,[a,1]);
[M, Theta] = meshgrid(fourier_coeff.m, Theta(:,1));
[N, Phi] = meshgrid(fourier_coeff.n, Phi(:,1));

% radial component
r_mnc = repmat(fourier_coeff.crc2',a,1);
r_elementarr = r_mnc .* cos(M .* Theta + 3 * N .* Phi); 
coords.r = sum(r_elementarr,2);

% z component
z_mns = repmat(fourier_coeff.czs2',a,1);
z_elementarr = z_mns .* sin(M .* Theta + 3 * N .* Phi);
coords.z = sum(z_elementarr,2);

% create vessel data from Cartesian coordinates
toroidal_vd.vertices(:,1) = coords.r .* cos(Theta(:,1));
toroidal_vd.vertices(:,2) = coords.r .* sin(Theta(:,1));
toroidal_vd.vertices(:,3) = sum(z_elementarr,2);

% upper triangular faces
    faces.upper(:,1) = [1:a];
    % normal
    faces.upper(1:end,2) = [faces.upper(1:end,1) + 1];                  % the second vertex for each upper triangle equals n+1
    faces.upper(1:end,3) = [faces.upper(1:end,1) + t];                  % the third vertex for each upper triangle equals n+t
    % connect poloidally (row t-1 to row 1)
    faces.upper(t-1:t-1:end,2) = [faces.upper(t-1:t-1:end,1) - (t-2)];  % every t-1 elements, the second vertex of the upper triangle equals n-3
    faces.upper(t-1:t-1:end,3) = [faces.upper(t-1:t-1:end,1) + 1];      % every t-1 elements, the third vertex of the upper triangle equals n+1
    % connect toroidally (column p-1 to column 1)
    faces.upper(end-(t-2):end,3) = [faces.upper(a-(t-2):end,1)-a+t];    % for the last t-1 terms, the third vertex equals n-a+t
    faces.upper(end,3) = [1];                                           % the ath vertex of the third vertex column is always index 1
%lower triangular faces
    faces.lower(:,1) = [1:a];
    % normal
    faces.lower(1:end,2) = [faces.lower(1:end,1) + t];                  % the second vertex for each lower triangle equals n+t
    faces.lower(1:end,3) = [faces.lower(1:end,1) + (t-1)];              % the third vertex for each lower triangle equals n+(t-1)
    % connect poloidally (row t-1 to row 1)
    faces.lower(t-1:t-1:end,2) = [faces.lower(t-1:t-1:end,1) + 1];      % every t-1 elements, the second vertex of the upper triangle equals n+1
    % connect toroidally (column p-1 to column 1)
    faces.lower(end-(t-2):end,2) = [faces.lower(end-(t-2):end,1)-a+t];      % for the last t-1 terms, the second vertex equals n-a+t
    faces.lower(end-(t-2):end,3) = [faces.lower(end-(t-2):end,1)-a+t-1];    % for the last t-1 terms, the third vertex equals n-a+t-1
    faces.lower(end,2) = [1];                                               % the last vertex of the second vertex column is always index 1
      
toroidal_vd.faces = reshape([faces.lower(:) faces.upper(:)]', [], 3);         % combines upper and lower triangular face arrays using every other row
end