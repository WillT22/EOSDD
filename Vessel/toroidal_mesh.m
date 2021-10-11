function [toroidal_vd] = toroidal_mesh(nescin_file, p, t)
    % p = number of toroidal segments
    % t = number of poloidal segments

%%%%%%%%%%%%%%% Default Parameters %%%%%%%%%%%%%%
  switch nargin         % creates a few default options
      case 1            % if t and p are empty, use default parameters
          p = 36;
          t = 18;
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
a = p*t; % number of vertices that will be used
phi = linspace(0,2*pi,p+1); % partition as measured in the toroidal direction 
theta = linspace(0,2*pi,t+1);   % partition as measured in the poloidal direction
[Phi, Theta]=meshgrid(phi(1:p),theta(1:t)); % creates an array from phi and theta 
Phi = reshape(Phi,[a,1]);
Theta = reshape(Theta,[a,1]);

[M, Theta] = meshgrid(fourier_coeff.m, Theta(:,1));
[N, Phi] = meshgrid(fourier_coeff.n, Phi(:,1));

% radial component
r_mnc = repmat(fourier_coeff.crc2',a,1);
r_elementarr = r_mnc .* cos(M .* Theta + 3 * N .* Phi); 
toroidal_vd.r = sum(r_elementarr,2);

% z component
z_mns = repmat(fourier_coeff.czs2',a,1);
z_elementarr = z_mns .* sin(M .* Theta + 3 * N .* Phi);
toroidal_vd.z = sum(z_elementarr,2);

% convert polar coordinates to Cartesian coordinates
toroidal_vd.x = toroidal_vd.r .* cos(Phi(:,1));
toroidal_vd.y = toroidal_vd.r .* sin(Phi(:,1));

% create vessel data from Cartesian coordinates
toroidal_vd.vertices(:,1) = toroidal_vd.x;
toroidal_vd.vertices(:,2) = toroidal_vd.y;
toroidal_vd.vertices(:,3) = sum(z_elementarr,2);

% triangular faces
    % lower triangles:
    faces.lower(:,1) = [1:a];
    faces.lower(:,2) = [2:a,1];
        faces.lower(t:t:end,2) = [faces.lower(t:t:end,1)-(t-1)]; % exceptions
    faces.lower(:,3) = [t+1:a,1:t];
    % upper triangles
    faces.upper(:,1) = [2:a+1];
        faces.upper(t:t:end,1) = [faces.upper(t:t:end,1)-t];     % exceptions
    faces.upper(:,2) = [faces.upper(1:end-t,1)+t;(2:t)';1];
    faces.upper(:,3) = [t+1:a,1:t];
    
toroidal_vd.faces = reshape([faces.lower(:) faces.upper(:)]', [], 3); % combines upper and lower triangular face arrays using every other row
end