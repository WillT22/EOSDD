function plot_2d_approx(fieldline_file_array, nescin_file_string)
    % fieldline_file_array example:
    %{
    fieldline_file = [fldlns_Cbar1_f_10, fldlns_Cbar1_r_10, fldlns_Cbar2_f_10,...
    fldlns_Cbar2_r_10, fldlns_Cbar3_f_10, fldlns_Cbar3_r_10,...
    fldlns_Cbar4_f_10, fldlns_Cbar4_r_10, fldlns_Cbar5_f_10,...
    fldlns_Cbar5_r_10];
    %}

%%%%%%%%%%%%%%% Default Parameters %%%%%%%%%%%%%%
  switch nargin         % creates a few default options
      case 2    
      otherwise         % else throw error
          error('Files are required.')
  end

%%% Creating the mesh grid in 2D %%%
clear grid;
p=180;
t=90;
a = p*t; % number of vertices that will be used
b = a+p+t+1;
phi = linspace(0,2*pi,p+1); % partition as measured in the toroidal direction 
theta = linspace(0,2*pi,t+1);   % partition as measured in the poloidal direction
[Phi, Theta]=meshgrid(phi(1:p+1),theta(1:t+1)); % creates an array from phi and theta 
Phi = reshape(Phi,[b,1]);
Theta = reshape(Theta,[b,1]);
grid.vertices(:,1) = Phi;
grid.vertices(:,2) = Theta;

clear faces
faces.lower(:,1) = [1:b-(t+1)];
faces.lower(:,2) = [2:b-t];
faces.lower(:,3) = [t+2:b];
faces.lower(t+1:t+1:end,:) = [];

faces.upper(:,1) = [2:b-t];
faces.upper(:,2) = [t+3:b+1];
faces.upper(:,3) = [t+2:b];
faces.upper(t+1:t+1:end,:) = [];

grid.faces = reshape([faces.lower(:) faces.upper(:)]', [], 3); % combines upper and lower triangular face arrays using every other row

%%% Plotting the Figure %%%
figure;

% plotting the vessel on a 2D grid of Theta vs. Phi
vessel_coords = grid;
% plotting only the vertices
    %plot(vessel_coords.vertices(:,1),vessel_coords.vertices(:,2),'.');
% plotting connected vertices in faces
    patch('Faces',vessel_coords.faces,'Vertices',vessel_coords.vertices, 'EdgeColor', [0.6 0.6 0.6], 'FaceColor', [1 1 1]);
hold on

% for adjusting the Phi values to be on the interval of [0,2*pi]
for i = 1:size(fieldline_file_array,2)
    Phi_lines_temp(:,i) = fieldline_file_array(i).PHI_lines(:,2);
    for p_0 = 1:size(Phi_lines_temp,1)
        if Phi_lines_temp(p_0,i) < 0
            Phi_lines_temp(p_0,i) = Phi_lines_temp(p_0,i) + 2*pi;
        end
    end
    if mod(i,2) == 1
       Phi_lines(1:p_0,(i/2+1/2)) = Phi_lines_temp(:,i);
    elseif mod(i,2) == 0
       Phi_lines(p_0+1:2*p_0,(i/2)) = Phi_lines_temp(:,i);
    end
end
 
% finding R_0 in the nescin file
fileID = fopen(nescin_file_string);
nescin_cell = textscan(fileID, '%f%f%f%f%f%f', 'Headerlines', 172, 'CollectOutput', true);
fclose(fileID);
nescin.M = nescin_cell{1}(:,1);
nescin.N = nescin_cell{1}(:,2);
nescin.crc2 = nescin_cell{1}(:,3);
for mode = 1:size(nescin.M,1)
    if nescin.M(mode) == 0 && nescin.N(mode) == 0
        R_0 = nescin.crc2(mode); % major radius in meters
    end
end

% for finding Theta values simplistically by using 
% Theta = atan(z/(r-r_0))
R_0 = 1.405322310372; % meters
for i = 1:size(fieldline_file_array,2)
    Theta_lines_temp(:,i) = atan2(fieldline_file_array(i).Z_lines(:,2),(fieldline_file_array(i).R_lines(:,2)-R_0));
    for t_0 = 1:size(Theta_lines_temp,1)
        if Theta_lines_temp(t_0,i) < 0
            Theta_lines_temp(t_0,i) = Theta_lines_temp(t_0,i) + 2*pi;
        end
    end
    if mod(i,2) == 1
       Theta_lines(1:t_0,(i/2+1/2)) = Theta_lines_temp(:,i);
    elseif mod(i,2) == 0
       Theta_lines(t_0+1:2*t_0,(i/2)) = Theta_lines_temp(:,i);
    end
end

plot(Phi_lines, Theta_lines, 'linestyle', 'none', 'marker', '.','color','red');

xlim([0,2*pi]);
ylim([0,2*pi]);
daspect([1 1 1]);
xlabel('Phi');
ylabel('Theta');

