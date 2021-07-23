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
p = p+1;
t = t+1;
a = p*t; % number of vertices that will be used

phi = linspace(0,2*pi,p); % partition as measured in the toroidal direction 
theta = linspace(0,2*pi,t);   % partition as measured in the poloidal direction

[Phi, Theta]=meshgrid(phi(1:p),theta(1:t)); % creates an array from phi and theta 
Phi = reshape(Phi,[a,1]);
Theta = reshape(Theta,[a,1]);

torus_vd.vertices(:,1) = (R+r.*cos(Theta)).*cos(Phi);
torus_vd.vertices(:,2) = (R+r.*cos(Theta)).*sin(Phi);
torus_vd.vertices(:,3) = r.*sin(Theta);

% triangular faces
    lower_lefts = [1:a-1]';         % indexes the lower left vertices
    upper_lefts = [2:a]';           % indexes the upper left vertices
    lower_rights = [t:a-1,1:t-1]';  % indexes the lower right vertices
    upper_rights = [t+1:a,2:t]';    % indexes the upper right vertices
    
    faces.upper = [lower_lefts(:) upper_lefts(:) upper_rights(:)];      % makes the upper triangles
    faces.lower = [lower_lefts(:) upper_rights(:) lower_rights(:)];     % makes the lower triangles
    
torus_vd.faces = reshape([faces.lower(:) faces.upper(:)]', [], 3);         % combines upper and lower triangular face arrays using every other row
end
