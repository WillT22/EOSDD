function [torus_vd] = torus_vd(r, R, p, t)
  % r = the inner radius of the torus
  % R = the outer radius of the torus
  % p = number of toroidal segments
  % t = number of poloidal segments

  %%%%%%%%%%%%%%% Default Parameters %%%%%%%%%%%%%%
  switch nargin         % creates a few default options
      case 0            % if all inputs are clear, use these default parameters
          r = 1;
          R = 2;
          p = 36;
          t = 18;
      case 2
          p = 36;
          t = 18;
      case 4    
      otherwise         % else throw error
          error('4 inputs are accepted.')
  end
 
 %%%%%%%%%%%%%%%% Create Vertex and Face Data %%%%%%%%%%%%%%%%%
a = p*t; % number of vertices that will be used

phi = linspace(0,2*pi,p+1); % partition as measured in the toroidal direction 
theta = linspace(0,2*pi,t+1);   % partition as measured in the poloidal direction

[Phi, Theta]=meshgrid(phi(1:p),theta(1:t)); % creates an array from phi and theta 
Phi = reshape(Phi,[a,1]);
Theta = reshape(Theta,[a,1]);

torus_vd.vertices(:,1) = (R+r.*cos(Theta)).*cos(Phi);
torus_vd.vertices(:,2) = (R+r.*cos(Theta)).*sin(Phi);
torus_vd.vertices(:,3) = r.*sin(Theta);

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
   
torus_vd.faces = reshape([faces.lower(:) faces.upper(:)]', [], 3);         % combines upper and lower triangular face arrays using every other row
end
