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

%{
% plot of the torus points
%plot3(torus.vertices(:,1),torus.vertices(:,2),torus.vertices(:,3), 'linestyle', 'none', 'marker', '.')
%plot3(torus.vertices(1:17:end,1),torus.vertices(1:17:end,2),torus.vertices(1:17:end,3), 'linestyle', 'none', 'marker', '.')
daspect([1 1 1]);                       % sets the aspect ratio to 1:1:1
title('Torus');                         % titles the graph
xlabel('X');ylabel('Y');zlabel('Z');    % labels the axes
%}

% first vertex for each face / initialize the array
torus.faces(:,1) = [1:a]; %1:a];
% upper triangular faces
    % normal
    torus.faces(1:a,2) = [torus.faces(1:a,1) + 1];                  % the second vertex for each upper triangle equals n+1
    torus.faces(1:a,3) = [torus.faces(1:a,1) + t];                  % the third vertex for each upper triangle equals n+t
    % connect poloidally (row t-1 to row 1)
    torus.faces(t-1:t-1:a,2) = [torus.faces(t-1:t-1:a,1) - (t-2)];  % every t-1 elements, the second vertex of the upper triangle equals n-3
    torus.faces(t-1:t-1:a,3) = [torus.faces(t-1:t-1:a,1) + 1];      % every t-1 elements, the third vertex of the upper triangle equals n+1
    % connect toroidally (column p-1 to column 1)
    torus.faces(a-(t-2):end,3) = [torus.faces(a-(t-2):end,1)-a+t];  % to connect the last column of vertices with the first, the third vertex equals n-a+t
    torus.faces(a,3) = [1];                                         % the last vertex of the third vertex column is always index 1
%lower triangular faces
    % normal
    % connect poloidally (row t-1 to row 1)
    % connect toroidally (column p-1 to column 1)
    

patch(torus, 'EdgeColor', [0 0 0], 'FaceColor', [0.5 0.5 0.5]);
%patch('Faces',torus.faces(562:end,:),'Vertices',torus.vertices, 'EdgeColor', [0 0 0], 'FaceColor', [0.5 0.5 0.5]);
view(3)                                 % view in 3D
daspect([1 1 1]);                       % sets the aspect ratio to 1:1:1
title('Torus');                         % titles the graph
xlabel('X');ylabel('Y');zlabel('Z');    % labels the axes
