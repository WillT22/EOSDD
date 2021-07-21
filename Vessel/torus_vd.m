function [torus_vd] = torus_vd(r, R, t, p)
  % r = the inner radius of the torus
  % R = the outer radius of the torus
  % t = number of toroidal segments
  % p = number of poloidal segments

  %%%%%%%%%%%%%%% Default Parameters %%%%%%%%%%%%%%
  switch nargin         % creates a few default options
      case 0            % if all inputs are clear, use these default parameters
          r = 4;
          R = 10;
          t = 35;
          p = 17;
      case 2
          t = 35;
          p = 17;
      case 4    
      otherwise         % else throw error
          error('4 inputs are accepted.')
  end
 
 %%%%%%%%%%%%%%%% Create Vertex and Face Data %%%%%%%%%%%%%%%%%
a = (p-1) * (t-1); % number of vertices that will be used

theta = linspace(0,2*pi,t); % partition as measured in the toroidal direction 
phi = linspace(0,2*pi,p);   % partition as measured in the poloidal direction

[Theta, Phi]=meshgrid(theta(1:t-1),phi(1:p-1)); % creates an array from phi and theta 
Theta = reshape(Theta,[a,1]);
Phi = reshape(Phi,[a,1]);

torus_vd.vertices(:,1) = (R+r.*cos(Phi)).*cos(Theta);
torus_vd.vertices(:,2) = (R+r.*cos(Phi)).*sin(Theta);
torus_vd.vertices(:,3) = r.*sin(Phi);

% upper triangular faces
    faces.upper(:,1) = [1:a];
    % normal
    faces.upper(1:end,2) = [faces.upper(1:end,1) + 1];                  % the second vertex for each upper triangle equals n+1
    faces.upper(1:end,3) = [faces.upper(1:end,1) + p];                  % the third vertex for each upper triangle equals n+t
    % connect poloidally (row t-1 to row 1)
    faces.upper(p-1:p-1:end,2) = [faces.upper(p-1:p-1:end,1) - (p-2)];  % every p-1 elements, the second vertex of the upper triangle equals n-3
    faces.upper(p-1:p-1:end,3) = [faces.upper(p-1:p-1:end,1) + 1];      % every p-1 elements, the third vertex of the upper triangle equals n+1
    % connect toroidally (column p-1 to column 1)
    faces.upper(end-(p-2):end,3) = [faces.upper(a-(p-2):end,1)-a+p];    % for the last p-1 terms, the third vertex equals n-a+t
    faces.upper(end,3) = [1];                                           % the ath vertex of the third vertex column is always index 1
%lower triangular faces
    faces.lower(:,1) = [1:a];
    % normal
    faces.lower(1:end,2) = [faces.lower(1:end,1) + p];                  % the second vertex for each lower triangle equals n+t
    faces.lower(1:end,3) = [faces.lower(1:end,1) + (p-1)];              % the third vertex for each lower triangle equals n+(p-1)
    % connect poloidally (row t-1 to row 1)
    faces.lower(p-1:p-1:end,2) = [faces.lower(p-1:p-1:end,1) + 1];      % every p-1 elements, the second vertex of the upper triangle equals n+1
    % connect toroidally (column p-1 to column 1)
    faces.lower(end-(p-2):end,2) = [faces.lower(end-(p-2):end,1)-a+p];      % for the last p-1 terms, the second vertex equals n-a+p
    faces.lower(end-(p-2):end,3) = [faces.lower(end-(p-2):end,1)-a+p-1];    % for the last p-1 terms, the third vertex equals n-a+p-1
    faces.lower(end,2) = [1];                                               % the last vertex of the second vertex column is always index 1
    
torus_vd.faces = reshape([faces.lower(:) faces.upper(:)]', [], 3);         % combines upper and lower triangular face arrays using every other row
end
