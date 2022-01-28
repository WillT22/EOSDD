function perturbed_toroidal = least_squares_test(toroidal_data)

number_of_coordinates = length(toroidal_data.phi);
%%% Initializing Randomization Stream %%%
stream = load('/u/wteague/EOSDD/Matlab/least_squares/least_squares_stream.mat');
stream = stream.stream;

%%% Setting up Randomization %%%
% for Phi variable
min_phi = -(2*pi/180);   % minimum value to add to phi
max_phi =  (2*pi/180);   % maximum value to add to phi
rv_phi = (max_phi-min_phi).*rand(stream, number_of_coordinates, 1) + min_phi; % random number calculation
rand_co.phi = toroidal_data.phi + rv_phi;
    idx.low = (rand_co.phi)<0;
    idx.high = (rand_co.phi)>(2*pi);
    idxi.low = find(idx.low);
    idxi.high = find(idx.high);      
rand_co.phi(idxi.low) = rand_co.phi(idxi.low) + (2*pi);
rand_co.phi(idxi.high) = rand_co.phi(idxi.high) - (2*pi);
clear idx
clear idxi

% for Theta variable
min_phi = -(2*pi/90);   % minimum value to add to theta
max_phi =  (2*pi/90);   % maximum value to add to theta
rv_theta = (max_phi-min_phi).*rand(stream, number_of_coordinates, 1) + min_phi; % random number calculation
rand_co.theta = toroidal_data.theta + rv_theta;
    idx.low = (rand_co.theta)<0;
    idx.high = (rand_co.theta)>(2*pi);
    idxi.low = find(idx.low);
    idxi.high = find(idx.high);      
rand_co.theta(idxi.low) = rand_co.theta(idxi.low) + (2*pi);
rand_co.theta(idxi.high) = rand_co.theta(idxi.high) - (2*pi);
clear idx
clear idxi

% outputing data for use
perturbed_toroidal.coords(:,1) = (ones(number_of_coordinates,1)*R) + (r*cos(rand_co.theta));
perturbed_toroidal.coords(:,2) = rand_co.phi;
perturbed_toroidal.coords(:,3) = r.*sin(rand_co.theta);
perturbed_toroidal.exact_theta = rand_co.theta;

% plotting created hitpoints
%{
% in Cartesian coordinates
X = (R+r.*cos(rand_co.theta)).*cos(rand_co.phi);
Y = (R+r.*cos(rand_co.theta)).*sin(rand_co.phi);
Z = r.*sin(rand_co.theta);
hold on
plot3(X,Y,Z,'.','Color','red')
%}

%{
% in cylindrical coordinates
X = random_torus_hitpoints.coords(:,1).*cos(rand_co.phi);
Y = random_torus_hitpoints.coords(:,1).*sin(rand_co.phi);
Z = random_torus_hitpoints.coords(:,3);
hold on
plot3(X,Y,Z,'.','Color','red')
%}

%plot_2d(random_torus_hitpoints.coords(:,2),random_torus_hitpoints.exact_theta);

%%% Perturbing Theta %%%
% Initializing Randomization Stream for theta perturbation 
stream_theta = load('/u/wteague/EOSDD/Matlab/least_squares/theta_perturb_stream.mat');
stream_theta = stream_theta.stream_theta;

% perturbation within 1 division
min_phi = -(2*pi/90);   % minimum value to add to theta
max_phi =  (2*pi/90);   % maximum value to add to theta
rv_theta = (max_phi-min_phi).*rand(stream_theta, number_of_coordinates, 1) + min_phi; % random number calculation
perturbed_toroidal.perturbed_theta(:,1) = perturbed_toroidal.exact_theta + rv_theta;
    idx.low = (perturbed_toroidal.perturbed_theta(:,1))<0;
    idx.high = (perturbed_toroidal.perturbed_theta(:,1))>(2*pi);
    idxi.low = find(idx.low);
    idxi.high = find(idx.high);      
perturbed_toroidal.perturbed_theta(idxi.low,1) = perturbed_toroidal.perturbed_theta(idxi.low,1) + (2*pi);
perturbed_toroidal.perturbed_theta(idxi.high,1) = perturbed_toroidal.perturbed_theta(idxi.high,1) - (2*pi);
clear idx
clear idxi

%plot_2d(random_torus_hitpoints.coords(:,2),random_torus_hitpoints.perturbed_theta(:,1));

% perturbation within 1/2 division
min_phi = -(2*pi/180);   % minimum value to add to theta
max_phi =  (2*pi/180);   % maximum value to add to theta
rv_theta = (max_phi-min_phi).*rand(stream_theta, number_of_coordinates, 1) + min_phi; % random number calculation
perturbed_toroidal.perturbed_theta(:,2) = perturbed_toroidal.exact_theta + rv_theta;
    idx.low = (perturbed_toroidal.perturbed_theta(:,2))<0;
    idx.high = (perturbed_toroidal.perturbed_theta(:,2))>(2*pi);
    idxi.low = find(idx.low);
    idxi.high = find(idx.high);      
perturbed_toroidal.perturbed_theta(idxi.low,2) = perturbed_toroidal.perturbed_theta(idxi.low,2) + (2*pi);
perturbed_toroidal.perturbed_theta(idxi.high,2) = perturbed_toroidal.perturbed_theta(idxi.high,2) - (2*pi);
clear idx
clear idxi