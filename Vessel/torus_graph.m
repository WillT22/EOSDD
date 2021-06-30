function torus_graph(V, option)
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

g_option = option;
nfacetot = size(V.faces,1);               % finds the number of faces that will be used by using the size of the first column of faces
f1 = figure();

if g_option == 0
    % Option 0: plot of the vertices
    plot3(V.vertices(:,1),V.vertices(:,2),V.vertices(:,3), 'linestyle', 'none', 'marker', '.')
elseif g_option == 1
    % Option 1: to see the whole torus
    patch(V, 'EdgeColor', [0 0 0], 'FaceColor', [0.5 0.5 0.5]);
elseif g_option == 2
    % Option 2: to see the front half of the torus
    patch('Faces',V.faces(1:nfacetot/2,:),'Vertices',V.vertices, 'EdgeColor', [0 0 0], 'FaceColor', [0.5 0.5 0.5]);
elseif g_option == 3
    % Option 3: to look at only the lower half of the torus
    lvertices = find(V.vertices(:,3) < 0);          % finds every vertex that has a negative z-component
    lfaces = zeros(size(V.faces));                  % initializes an array of zeros the size of the number of faces
    n = 0;                                          % initializes the row index for the for function
    for i=1:nfacetot                                % for every face,...
        if ismember(V.faces(i,1), lvertices)        % if the face selected has a first vertex with a negative z-component
            n = n + 1;
            lfaces(n,:) = V.faces(i,:);             % then add that face to the set of lower faces
        end
    end
    V.faces = lfaces(1:n,:);                  % set faces as only the lower faces

    patch('Faces',V.faces,'Vertices',V.vertices, 'EdgeColor', [0 0 0], 'FaceColor', [0.5 0.5 0.5]);
end
    
% plot specifications
view(3)                                 % view in 3D
daspect([1 1 1]);                       % sets the aspect ratio to 1:1:1
c1 = camlight();
c1 = camlight();
title('Torus');                         % titles the graph
xlabel('X');ylabel('Y');zlabel('Z');    % labels the axes
end
