R = 5;  % outer radius of the torus
r = 2;  % inner radius of the torus

p = 36;
t = 18;
a = (p-1) * (t-1);

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

% plot of the torus points
plot3(torus.vertices(:,1),torus.vertices(:,2),torus.vertices(:,3), 'linestyle', 'none', 'marker', '.')
daspect([1 1 1]);                       % sets the aspect ratio to 1:1:1
title('Torus');                         % titles the graph
xlabel('X');ylabel('Y');zlabel('Z');    % labels the axes

%{
faces = delaunayTriangulation(vertices);

torus.Vertices = vertices;
torus.Faces = faces.ConnectivityList;

patch(torus, 'EdgeColor', [0 0 0], 'FaceColor', [0.5 0.5 0.5]);
view(3);                                % view in 3D
daspect([1 1 1]);                       % sets the aspect ratio to 1:1:1
title('Torus');                         % titles the graph
xlabel('X');ylabel('Y');zlabel('Z');    % labels the axes
%}
