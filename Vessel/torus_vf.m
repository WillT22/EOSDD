R = 5;  % outer radius of the torus
r = 2;  % inner radius of the torus

p = 36;
t = 18;

phi = linspace(0,2*pi,p);   % partition as measured in the toroidal direction
theta = linspace(0,2*pi,t); % partition as measured in the poloidal direction 

vertices= zeros((p-1)*(t-1),3);       % initializes torus array of zeros

m = 1;                      % initializes index for row element of torus array
for i = 1:p-1
    for j = 1:t-1
        vertices(m,1) = (R+r.*cos(theta(j))).*cos(phi(i)); % updates the x component in the mth row of the torus array
        vertices(m,2) = (R+r.*cos(theta(j))).*sin(phi(i)); % updates the y component in the mth row of the torus array
        vertices(m,3) = r.*sin(theta(j));                  % updates the z component in the mth row of the torus array
        m = m + 1;
    end
end
%{
% plot of the torus points
plot3(vertices(:,1),vertices(:,2),vertices(:,3), 'linestyle', 'none', 'marker', '.')
daspect([1 1 1]);                       % sets the aspect ratio to 1:1:1
title('Torus');                         % titles the graph
xlabel('X');ylabel('Y');zlabel('Z');    % labels the axes
%}

faces = delaunayTriangulation(vertices);

torus.Vertices = vertices;
torus.Faces = faces.ConnectivityList;

patch(torus, 'EdgeColor', [0 0 0], 'FaceColor', [0.5 0.5 0.5]);
view(3);                                % view in 3D
daspect([1 1 1]);                       % sets the aspect ratio to 1:1:1
title('Torus');                         % titles the graph
xlabel('X');ylabel('Y');zlabel('Z');    % labels the axes
