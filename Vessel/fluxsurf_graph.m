function fluxsurf_graph(flux_coordinates, line_number)

x = (flux_coordinates(line_number).r).*cos(flux_coordinates(line_number).phi);
y = (flux_coordinates(line_number).r).*sin(flux_coordinates(line_number).phi);
z = (flux_coordinates(line_number).z);

%fig1 = figure();
plot3(x,y,z);

% plot specifications
view(3)                                 % view in 3D
daspect([1 1 1]);                       % sets the aspect ratio to 1:1:1
title('Flux Surface');                  % titles the graph
xlabel('X');ylabel('Y');zlabel('Z');    % labels the axes
end