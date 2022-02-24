%{
function variation = variability(hitpoint_data, option)

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
option = 0;
%%%%%%%%%%%%%%%%%%%% Variability Options %%%%%%%%%%%%%%%%%%%%%%%
%% Assigning all Hit Points to a Triangle
p=180;
t=90;
phi = linspace(0,2*pi,p+1); % partition as measured in the toroidal direction 
theta = linspace(0,2*pi,t+1);   % partition as measured in the poloidal direction
for file = 1:length(fieldline_file)
   % for every hit point in each of the files, assign them in a triangle
   % may make sense to put into the forward on top reverse on bottom format
   % you've had going on.
end

%% Finding Hit Points/Unit Area/Total Number of Hit Points
if option == 0
    
%% Finding Variance for 10 Samples of 10% of inputted data
elseif option == 1
    
%% Finding Varianve for 100 Samples of 1% of inputed data
elseif option == 2
    
end
%end