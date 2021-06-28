function [] = w7x_view_1()

    w7xDivFile = 'w7x_divertor_op12b_fullres.dat';  % names data file
    w7xDivStr = importdata(w7xDivFile, ' ', 3);     % imports 3 column data from file
    w7xDivData = w7xDivStr.data;                    % extracts data from file
    nVertices = 33340;                              % sets number of vertices

    w7xDiv.Vertices = w7xDivData(1:nVertices,:);    % sets vertice data as the first 33340 lines of data
    w7xDiv.Faces = w7xDivData(nVertices+1:end,:);   % sets face data as lines 33341 to the end

    lInds = find(w7xDiv.Vertices(:,3) < 0);         % finds every vertex that has a negative z-component
    lFaces = zeros(size(w7xDiv.Faces));             % initializes an array of zeros the size of the number of faces
    nFacesTot = size(w7xDiv.Faces,1);               % finds the number of faces that will be used bt using the size of the first column of faces
    n = 0;                                          % initializes the row index for the for function
    for i=1:nFacesTot                               % for every face,...
        if ismember(w7xDiv.Faces(i,1), lInds)       % if the face selected has a first vertex with a negative z-component
            n = n + 1;
            lFaces(n,:) = w7xDiv.Faces(i,:);        % then add that face to the set of lower faces
        end
    end
    w7xDiv.Faces = lFaces(1:n,:);                   % set faces as only the lower faces

    f1 = figure('PaperPosition', [0 0 6 6], 'PaperSize', [6 6]);                % set the size and location of the graph
    ax1 = gca();                                                                % get current axis
    set(ax1, 'DataAspectRatio', [1 1 1], 'NextPlot', 'Add', 'Visible', 'On');   % set ascpect ratio to 1:1:1, adds new graphic objects to existing figure, and sets the axis lables to invisible

    set(ax1, 'CameraPosition', [5.4 -1.8 -0.2], ...     % sets where exactly the figure camera position is when figure is created
             'CameraTarget',   [5.4 1.0 -0.6], ...
             'CameraUpVector', [0 0 1], ...
             'CameraViewAngle', 30);

    hdiv = patch(w7xDiv, 'EdgeColor', [0 0 0], 'FaceColor', [0.5 0.5 0.5]); % sets edge color to black and face color to gray
    
    c1 = camlight();
    c1 = camlight();
end
