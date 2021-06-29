function [] = w7x_view_1()

    w7xDivFile = 'w7x_divertor_op12b_fullres.dat';
    w7xDivStr = importdata(w7xDivFile, ' ', 3);
    w7xDivData = w7xDivStr.data;
    nVertices = 33340;

    w7xDiv.Vertices = w7xDivData(1:nVertices,:);
    w7xDiv.Faces = w7xDivData(nVertices+1:end,:);

    lInds = find(w7xDiv.Vertices(:,3) < 0);
    lFaces = zeros(size(w7xDiv.Faces));
    nFacesTot = size(w7xDiv.Faces,1);
    n = 0;
    for i=1:nFacesTot
        if ismember(w7xDiv.Faces(i,1), lInds)
            n = n + 1;
            lFaces(n,:) = w7xDiv.Faces(i,:);
        end
    end
    w7xDiv.Faces = lFaces(1:n,:);

    f1 = figure('PaperPosition', [0 0 6 6], 'PaperSize', [6 6]);
    ax1 = gca();
    set(ax1, 'DataAspectRatio', [1 1 1], 'NextPlot', 'Add', 'Visible', 'Off');

    set(ax1, 'CameraPosition', [5.4 -1.8 -0.2], ...
             'CameraTarget',   [5.4 1.0 -0.6], ...
             'CameraUpVector', [0 0 1], ...
             'CameraViewAngle', 30);

    hdiv = patch(w7xDiv, 'EdgeColor', [0 0 0], 'FaceColor', [0.5 0.5 0.5]);

    c1 = camlight();
    c1 = camlight();

end
