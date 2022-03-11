function toroidal_graph(toroidal_coordinates, option)
  % V = vessel structure

  %%%%%%%%%%%%%%% Default Parameters %%%%%%%%%%%%%%
  switch nargin         % creates a few default options
      case 1            % if all inputs are clear, use these default parameters
          option = 1;
      case 2
      otherwise         % else throw error
          error('2 inputs are accepted.')
  end
 
%%%%%%%%%%%%%%%%%%%% Graphing Options %%%%%%%%%%%%%%%%%%%%%%%
figure
g_option = option;
nfacetot = size(toroidal_coordinates.Faces,1);               % finds the number of faces that will be used by using the size of the first column of faces


if g_option == 0
    % Option 0: plot of the vertices
    plot3(toroidal_coordinates.Vertices(:,1),toroidal_coordinates.Vertices(:,2),toroidal_coordinates.Vertices(:,3), 'linestyle', 'none', 'marker', '.','color',[0.6 0.6 0.6])
elseif g_option == 1
    % Option 1: to see the whole torus
    patch('Faces',toroidal_coordinates.Faces,'Vertices',toroidal_coordinates.Vertices, 'EdgeColor', [0.6 0.6 0.6], 'FaceColor', [0.8 0.8 0.8]);
    %alpha(0);
elseif g_option == 2
    % Option 2: to see the front half of the torus
    patch('Faces',toroidal_coordinates.Faces(1:nfacetot/2,:),'Vertices',toroidal_coordinates.Vertices, 'EdgeColor', [0.6 0.6 0.6], 'FaceColor', [0.8 0.8 0.8]);
    %alpha(0.1);
elseif g_option == 3
    % Option 3: to look at only the lower half of the torus
    lvertices = find(toroidal_coordinates.Vertices(:,3) < 0);          % finds every vertex that has a negative z-component
    n = 0;                                          % initializes the row index for the for function
    for i=1:nfacetot                                % for every face,...
        if ismember(toroidal_coordinates.Faces(i,2), lvertices)        % if the face selected has a second vertex with a negative z-component
            n = n + 1;
            lfaces(n,:) = toroidal_coordinates.Faces(i,:);             % then add that face to the set of lower faces
        end
    end
    toroidal_coordinates.faces = lfaces(1:n,:);                  % set faces as only the lower faces

    patch('Faces',toroidal_coordinates.faces,'Vertices',toroidal_coordinates.vertices, 'EdgeColor', [0 0 0], 'FaceColor', [0.5 0.5 0.5]);
    %alpha(0.1);
end
    
% plot specifications
view(3)                                 % view in 3D
daspect([1 1 1]);                       % sets the aspect ratio to 1:1:1
%xlim([-2.2,2.2]);
%ylim([-2.2,2.2]);
zlim([-1,1]);
%c1 = camlight();
%c1 = camlight();
%title('Torus');                         % titles the graph
xlabel('X');ylabel('Y');zlabel('Z');    % labels the axes
end
