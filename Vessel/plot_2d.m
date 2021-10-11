figure;

vessel_coords = grid;
%plot(vessel_coords.vertices(:,1),vessel_coords.vertices(:,2),'.');
patch('Faces',vessel_coords.faces,'Vertices',vessel_coords.vertices, 'EdgeColor', [0.6 0.6 0.6], 'FaceColor', [0.8 0.8 0.8]);

xlim([0,2*pi]);
ylim([0,2*pi]);
daspect([1 1 1]);
grid on;
xlabel('Phi');
ylabel('Theta');