R = 10;  % outer radius of the torus
r = 4;  % inner radius of the torus

p = 35;
t = 16;
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
% plot of the vertices
plot3(torus.vertices(:,1),torus.vertices(:,2),torus.vertices(:,3), 'linestyle', 'none', 'marker', '.')
daspect([1 1 1]);                       % sets the aspect ratio to 1:1:1
title('Torus');                         % titles the graph
xlabel('X');ylabel('Y');zlabel('Z');    % labels the axes
%}

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

% to see the whole torus
patch(torus, 'EdgeColor', [0 0 0], 'FaceColor', [0.5 0.5 0.5]);

% to see the front half of the torus
% patch('Faces',torus.faces(1:a,:),'Vertices',torus.vertices, 'EdgeColor', [0 0 0], 'FaceColor', [0.5 0.5 0.5]);


% to look at only the lower half of the torus
%{
lvertices = find(torus.vertices(:,3) < 0);         % finds every vertex that has a negative z-component
    lfaces = zeros(size(torus.faces));             % initializes an array of zeros the size of the number of faces
    n = 0;                                         % initializes the row index for the for function
    for i=1:2*a                              % for every face,...
        if ismember(torus.faces(i,1), lInds)       % if the face selected has a first vertex with a negative z-component
            n = n + 1;
            lfaces(n,:) = torus.faces(i,:);        % then add that face to the set of lower faces
        end
    end
    torus.faces = lfaces(1:n,:);                   % set faces as only the lower faces

patch('Faces',torus.faces,'Vertices',torus.vertices, 'EdgeColor', [0 0 0], 'FaceColor', [0.5 0.5 0.5]);
%}

% plot specifications
view(3)                                 % view in 3D
daspect([1 1 1]);                       % sets the aspect ratio to 1:1:1
c1 = camlight();
c1 = camlight();
title('Torus');                         % titles the graph
xlabel('X');ylabel('Y');zlabel('Z');    % labels the axes
