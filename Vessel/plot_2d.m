figure;

% plotting the vessel on a 2D grid of Theta vs. Phi
vessel_coords = grid;
% plotting only the vertices
    %plot(vessel_coords.vertices(:,1),vessel_coords.vertices(:,2),'.');
% plotting connected vertices in faces
    patch('Faces',vessel_coords.faces,'Vertices',vessel_coords.vertices, 'EdgeColor', [0.6 0.6 0.6], 'FaceColor', [1 1 1]);
  
hold on
% plotting hit points on the 2D grid
fieldline_file_f  = [fldlns_Cbar1_f_20, fldlns_Cbar2_f_20, fldlns_Cbar3_f_20,...
    fldlns_Cbar4_f_20, fldlns_Cbar5_f_20];
fieldline_file_r = [fldlns_Cbar1_r_20, fldlns_Cbar2_r_20, fldlns_Cbar3_r_20,...
    fldlns_Cbar4_r_20, fldlns_Cbar5_r_20];
hold on
for i = 1:size(fieldline_file_f,2)
plot(fieldline_file_f(i).PHI_lines(:,2), sqrt(fieldline_file_f(i).R_lines(:,2).^2 + fieldline_file_f(i).Z_lines(:,2).^2), 'linestyle', 'none', 'marker', '.','color','red');
plot(fieldline_file_r(i).PHI_lines(:,2), sqrt(fieldline_file_r(i).R_lines(:,2).^2 + fieldline_file_r(i).Z_lines(:,2).^2), 'linestyle', 'none', 'marker', '.','color','red');
end

xlim([-pi,pi]);
ylim([-pi,pi]);
daspect([1 1 1]);
grid on;
xlabel('Phi');
ylabel('Theta');