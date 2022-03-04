%{
function variation = variability(hitpoint_data, Theta_data, stream, option)

  %%%%%%%%%%%%%%% Default Parameters %%%%%%%%%%%%%%
  switch nargin         % creates a few default options
      case 1            % if two inputs are empty, use these default parameters
          stream = load('/u/wteague/EOSDD/Matlab/least_squares/least_squares_stream.mat');
          stream = stream.stream;
          option = 0;
      case 2
      otherwise         % else throw error
          error('2 inputs are accepted.')
  end
%}
fieldline_file = [fldlns_Cbar1_f_10, fldlns_Cbar1_r_10, fldlns_Cbar2_f_10,...
    fldlns_Cbar2_r_10, fldlns_Cbar3_f_10, fldlns_Cbar3_r_10,...
    fldlns_Cbar4_f_10, fldlns_Cbar4_r_10, fldlns_Cbar5_f_10,...
    fldlns_Cbar5_r_10];
hitpoint_data = fieldline_file;
data.THETA_coords = importdata('./EOSDD/Python/Theta_Cbar_10.dat');
option = 3;
stream = load('/u/wteague/EOSDD/Matlab/2d_analysis/variability.mat');
stream = stream.stream;
%%%%%%%%%%%%%%%%%%%% Variability Options %%%%%%%%%%%%%%%%%%%%%%%
%% Assigning Hit Points to Triangles
p_div=180;
t_div=90;
ntrig = p_div*t_div*2;
phi = linspace(0,2*pi,p_div+1); % partition as measured in the toroidal direction 
theta = linspace(0,2*pi,t_div+1);   % partition as measured in the poloidal direction

%%% PHI
% extracting Phi data and reshaping
data.PHI_coords = [];
for i = 1:length(fieldline_file)
    data.PHI_coords = [data.PHI_coords fieldline_file(i).PHI_lines(:,2)];
end
data.PHI_coords = reshape(data.PHI_coords, 2*size(data.PHI_coords,1),0.5*size(data.PHI_coords,2));
% verifying all Phi data is in the bounds [0,2pi]
for f = 1:size(data.PHI_coords,2)
    for i = 1:size(data.PHI_coords,1)
        if data.PHI_coords(i,f) < 0
			data.PHI_coords(i,f) = data.PHI_coords(i,f) + 2*pi;
        end
    end
end
% assigning Phi
data.PHI_scale = (data.PHI_coords ./ phi(2))+1; % scaling phi in terms of phi variable (indexing starts at 1)
data.PHI_assign = floor(data.PHI_scale); % rounding to lower bound 

%%% THETA
data.THETA_scale = (data.THETA_coords ./ theta(2))+1; % scaling phi in terms of phi variable (indexing starts at 1)
data.THETA_assign = floor(data.THETA_scale); % rounding to lower bound

%%% HYPOTENUSE
for f = 1:size(data.PHI_assign,2)
   for i = 1:size(data.PHI_assign,1)
       if (data.PHI_scale(i,f) - data.PHI_assign(i,f))  ...
               + (data.THETA_scale(i,f) - data.THETA_assign(i,f)) < 1
           data.HYPO_assign(i,f) = 1; % lower left triangle
       else
           data.HYPO_assign(i,f) = 0; % upper right triangle
       end
   end
end

%%% Assigning to a Triangle
data.TRIG_assign = ((data.PHI_assign-1) * t_div + data.THETA_assign) .* 2 - data.HYPO_assign

%%%% Finding Variance for Hitpoints %%%%
% setting up universal variables
ndata_points = size(data.PHI_coords,1)*size(data.PHI_coords,2);

%% Finding Hit Points/Unit Area/Total Number of Hit Points
if option == 0
    
%% Finding Variance for 10 Samples of 10% of inputted data
elseif option == 1
    nselection  = ceil(ndata_points * 0.1);
    
%% Finding Variance for 100 Samples of 1% of inputed data
elseif option == 2
    nselection  = ceil(ndata_points * 0.01);
    
%% Finding Variance for 1000 Samples of 0.1% of inputed data
elseif option == 3
    nselection  = ceil(ndata_points * 0.001);
    rand_select.index = randi(stream, ndata_points,[nselection,1]);
    rand_select.Phi   = data.PHI_coords(rand_select.index); 
    rand_select.Theta = data.THETA_coords(rand_select.index);
    faces = grid.faces(data.TRIG_assign(rand_select.index),:);
    figure
    plot_2d(rand_select.Phi, rand_select.Theta);
    hold on
    patch('Faces',grid.faces(data.TRIG_assign(rand_select.index),:),'Vertices',grid.vertices,'EdgeColor', 'b', 'FaceColor', 'b')
    alpha(0.5);
end
%end