function data_variance = variability(hitpoint_data, Theta_data, vessel_data, percent_analysis, nsamples, rand_seed)

  % hitpoint_data is imported from FIELDLINES in the following format:
    %{
    hitpoint_data = [fieldline_forward_run1, fieldline_reverse_run1,...
                     fieldline_forward_run2, fieldline_reverse_run2,...];
    %}
  % Theta_data is data collected from least_squares function (see theta_coordinate.py)
  % vessel_data is created by the function toroidal_mesh from a nescin file
    % needed for triangular area calculation function located in the function
  % rand_stream is optional and if no stream is given, function is uniquely randomized every time
  % percent_analysis allows for calculations to be unique to statistical needs
    % use percent_analysis = 0 to output all hit point triangle index locations

  %%%%%%%%%%%%%%% Default Parameters %%%%%%%%%%%%%%
  switch nargin         % creates a few default options
      case 3            % if two inputs are empty, use these default parameters
          nsamples = 0;      
          percent_analysis = 0;
          rand_stream = RandStream.create('mt19937ar','Seed',randi(10000));
      case 5            % if one input is empty, use random stream
          rand_stream = RandStream.create('mt19937ar','Seed',randi(10000));
      case 6
          rand_stream = RandStream.create('mt19937ar','Seed',rand_seed);
      otherwise         % else throw error
          error('2 inputs are accepted.')
  end
data_variance.seed = rand_stream.Seed;
percent_analysis = percent_analysis/100;
trig_assign_data.THETA_coords = Theta_data;

%%%%%%%%%%%%%%%%%%%% Variability Options %%%%%%%%%%%%%%%%%%%%%%%
%% Assigning Hit Points to Triangles
p_div=180;
t_div=90;
ntrig = p_div*t_div*2;
phi = linspace(0,2*pi,p_div+1); % partition as measured in the toroidal direction 
theta = linspace(0,2*pi,t_div+1);   % partition as measured in the poloidal direction

%%% PHI
% extracting Phi data and reshaping
trig_assign_data.PHI_coords = [];
for i = 1:length(hitpoint_data)
    trig_assign_data.PHI_coords = [trig_assign_data.PHI_coords hitpoint_data(i).PHI_lines(:,2)];
end
trig_assign_data.PHI_coords = reshape(trig_assign_data.PHI_coords, 2*size(trig_assign_data.PHI_coords,1),0.5*size(trig_assign_data.PHI_coords,2));
% verifying all Phi data is in the bounds [0,2pi]
for f = 1:size(trig_assign_data.PHI_coords,2)
    for i = 1:size(trig_assign_data.PHI_coords,1)
        if trig_assign_data.PHI_coords(i,f) < 0
			trig_assign_data.PHI_coords(i,f) = trig_assign_data.PHI_coords(i,f) + 2*pi;
        end
    end
end
% assigning Phi
trig_assign_data.PHI_scale = (trig_assign_data.PHI_coords ./ phi(2))+1; % scaling phi in terms of phi variable (indexing starts at 1)
trig_assign_data.PHI_assign = floor(trig_assign_data.PHI_scale); % rounding to lower bound 

%%% THETA
trig_assign_data.THETA_scale = (trig_assign_data.THETA_coords ./ theta(2))+1; % scaling phi in terms of phi variable (indexing starts at 1)
trig_assign_data.THETA_assign = floor(trig_assign_data.THETA_scale); % rounding to lower bound

%%% HYPOTENUSE
for f = 1:size(trig_assign_data.PHI_assign,2)
   for i = 1:size(trig_assign_data.PHI_assign,1)
       if (trig_assign_data.PHI_scale(i,f) - trig_assign_data.PHI_assign(i,f))  ...
               + (trig_assign_data.THETA_scale(i,f) - trig_assign_data.THETA_assign(i,f)) < 1
           trig_assign_data.HYPO_assign(i,f) = 1; % lower left triangle
       else
           trig_assign_data.HYPO_assign(i,f) = 0; % upper right triangle
       end
   end
end

%%% Assigning to a Triangle
trig_assign_data.TRIG_assign = ((trig_assign_data.PHI_assign-1) * t_div + trig_assign_data.THETA_assign).* 2 - trig_assign_data.HYPO_assign;

%% Finding Hit Points/Unit Area/Total Number of Hit Points
%%%% Finding Variance for Hitpoints %%%%
% setting up universal variables
    % finding total number of hit points
    ndata_points = size(trig_assign_data.PHI_coords,1)*size(trig_assign_data.PHI_coords,2);
    % set up edges for counting the number of hit points in the triangle
    index_vector = linspace(1,p_div*t_div*2+1,p_div*t_div*2+1)';
    % count the number of hit points that are in each triangle
    data_variance.nhp_trig = histcounts(trig_assign_data.TRIG_assign,index_vector)';
    % finding ratio of hit points per triangular section
    data_variance.hp_ratio = data_variance.nhp_trig ./ ndata_points;
    % finding hitpoints/unit area/total number of hit points
        % heat flux density
        % ratio of hit points per triangular section per meter^2
    data_variance.hf_density = data_variance.nhp_trig ./ vessel_data.Areas ./ ndata_points;
    % finding percentage of heat flux in a facet
    data_variance.hf_percentage = data_variance.hf_density./sum(data_variance.hf_density).*100;
    
%% Finding Error and Variance for (nsamples) Samples of (percent_analysis)% of inputted data
if percent_analysis == 0
    data_variance.sample_nhp_trig = data_variance.nhp_trig;
elseif percent_analysis ~= 0
    nselection  = ceil(ndata_points * percent_analysis);
    rand_select_index = randi(rand_stream, ndata_points,[nselection,nsamples]);
    data_variance.sample_Phi   = trig_assign_data.PHI_coords(rand_select_index); 
    data_variance.sample_Theta = trig_assign_data.THETA_coords(rand_select_index);
    data_variance.sample_trig  = trig_assign_data.TRIG_assign(rand_select_index);
  
    % Finding Error and Variance for Samples %
    % count the number of hit points that are in each triangle
    for i = 1:nsamples
        data_variance.sample_nhp_trig(:,i) = histcounts(data_variance.sample_trig(:,i),index_vector)';
    end
    % finding ratio of hit points per triangular section
    data_variance.sample_hp_ratio = data_variance.sample_nhp_trig ./ nselection;
    % finding hitpoints/unit area/total number of hit points
        % heat flux density
        % ratio of hit points per triangular section per meter^2
    data_variance.sample_hf_density = data_variance.sample_nhp_trig ./ vessel_data.Areas ./ nselection;
    % true error between sample and data heat flux density
    for i = 1:nsamples
        data_variance.sample_error(:,i)= data_variance.hf_density - data_variance.sample_hf_density(:,i);
    end
    % average error over all samples
    data_variance.avg_sample_error = sum(data_variance.sample_error,2)./nsamples;
    % average error over all triangles
    data_variance.avg_error = sum(data_variance.avg_sample_error)./length(data_variance.avg_sample_error);
    % standard deviation of all triangles' error
    data_variance.std_dev = sqrt(sum((data_variance.avg_sample_error-data_variance.avg_error).^2,'all')/length(data_variance.avg_sample_error));
    % variance from total value for every sample
    for i = 1:size(data_variance.hf_density,1)
       data_variance.hfd_variance(i,1) =  sum((data_variance.sample_hf_density(i,:)-data_variance.hf_density(i)).^2)/(nsamples-1);
    end
    % variance of heat flux percentage
    for i = 1:size(data_variance.hf_density,1)
       data_variance.hfp_variance(i,1) =  sum((data_variance.hf_percentage(i,:)-data_variance.hf_percentage(i)).^2)/(nsamples-1);
    end
end
end %end of function