%{
function variation = variability(hitpoint_data, Theta_data, option)

  %%%%%%%%%%%%%%% Default Parameters %%%%%%%%%%%%%%
  switch nargin         % creates a few default options
      case 1            % if all inputs are clear, use these default parameters
          option = 0;
      case 2
      otherwise         % else throw error
          error('2 inputs are accepted.')
  end
%}
hitpoint_data = fieldline_file;
THETA_data = importdata('../EOSDD/Python/Theta_Cbar_10.dat');
option = 0;
%%%%%%%%%%%%%%%%%%%% Variability Options %%%%%%%%%%%%%%%%%%%%%%%
%% Assigning all Hit Points to a Triangle
p_div=180;
t_div=90;
ntrig = p_div*t_div*2;
phi = linspace(0,2*pi,p_div+1); % partition as measured in the toroidal direction 
theta = linspace(0,2*pi,t_div+1);   % partition as measured in the poloidal direction

%%% PHI
% extracting Phi data and reshaping
PHI_data = [];
for i = 1:length(fieldline_file)
    PHI_data = [PHI_data fieldline_file(i).PHI_lines(:,2)];
end
PHI_data = reshape(PHI_data, 2*size(PHI_data,1),0.5*size(PHI_data,2));
% verifying all Phi data is in the bounds [0,2pi]
for f = 1:size(PHI_data,2)
    for i = 1:size(PHI_data,1)
        if PHI_data(i,f) < 0
			PHI_data(i,f) = PHI_data(i,f) + 2*pi;
        end
    end
end
% assigning Phi
for f = 1:size(PHI_data,2)
   for i = 1:size(PHI_data,1)
       % Determining lower bound Phi coordinate
       for p = length(phi)-1:-1:1
           if PHI_data(i,f) < phi(p)
               PHI_assign(i,f) = p-1;
           else
               break
           end
       end
   end
end

%%% THETA
for f = 1:size(THETA_data,2)
   for i = 1:size(THETA_data,1)
       % Determining lower bound Theta coordinate
       for t = length(theta)-1:-1:1
           if THETA_data(i,f) < theta(t)
               THETA_assign(i,f) = t-1;
           else
               break
           end
       end
   end
end

%%% HYPOTENUSE
for f = 1:size(PHI_assign,2)
   for i = 1:size(PHI_assign,1)
       if PHI_assign(i,f) + THETA_assign(i,f) <= phi(PHI_assign(i,f)) + theta(THETA_assign(i,f))
           trig_assign(i,f) = 1;
       else
           trig_assign(i,f) = 2;
       end
   end
end

%% Finding Hit Points/Unit Area/Total Number of Hit Points
if option == 0
    
%% Finding Variance for 10 Samples of 10% of inputted data
elseif option == 1
    
%% Finding Varianve for 100 Samples of 1% of inputed data
elseif option == 2
    
end
%end