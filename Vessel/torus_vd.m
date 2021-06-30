function [torus_vd] = torus_vd(r, R, p, t)
  % r = the inner radius of the torus
  % R = the outer radius of the torus
  % p = number of toroidal segments
  % t = number of poloidal segments

  %%%%%%%%%%%%%%% Default Parameters %%%%%%%%%%%%%%
  switch nargin         % creates a few default options
      case 0            % if all inputs are clear, use these default parameters
          r = 4;
          R = 10;
          p = 35;
          t = 17;
      case 4    
      otherwise         % else throw error
          error('4 inputs are accepted.')
  end
 
 %%%%%%%%%%%%%%%% Create Vertex and Face Data %%%%%%%%%%%%%%%%%
a = (p-1) * (t-1); % number of vertices that will be used

phi = linspace(0,2*pi,p);   % partition as measured in the toroidal direction
theta = linspace(0,2*pi,t); % partition as measured in the poloidal direction 

[Phi,Theta]=meshgrid(phi(1:p-1),theta(1:t-1)); % creates an array from phi and theta 

% torus coordinate functions as 18x36 arrays 
vertices.x = (R+r.*cos(Theta)).*cos(Phi);
vertices.y = (R+r.*cos(Theta)).*sin(Phi);
vertices.z = r.*sin(Theta);

torus.vertices(:,1) = reshape(vertices.x,[a,1]);
torus.vertices(:,2) = reshape(vertices.y,[a,1]);
torus.vertices(:,3) = reshape(vertices.z,[a,1]);

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
      
torus.faces = reshape([faces.lower(:) faces.upper(:)]', [], 3);         % combines upper and lower triangular face arrays using every other row
torus_vd = torus;
end
