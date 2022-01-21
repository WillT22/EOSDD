R = 1.5;
r = 0.5;
torus_test = torus_vd(R,r,180,90);
toroidal_graph(torus_test)

number_of_coordinates = length(torus_test.phi);
%%% Initializing Randomization Stream %%%
stream = load('/u/wteague/EOSDD/Matlab/least_squares/least_squares_stream.mat');
stream = stream.stream;

%%% Setting up Randomization %%%
% for Phi variable
min_phi = -(2*pi/180);   % minimum value to add to phi
max_phi =  (2*pi/180);   % maximum value to add to phi
rv_phi = (max_phi-min_phi).*rand(stream, number_of_coordinates, 1) + min_phi; % random number calculation

rand_co.phi = torus_test.phi + rv_phi;
    idx.low = (rand_co.phi)<0;
    idx.high = (rand_co.phi)>(2*pi);
    idxi.low = find(idx.low);
    idxi.high = find(idx.high);      
rand_co.phi(idxi.low) = rand_co.phi(idxi.low) + (2*pi);
rand_co.phi(idxi.high) = rand_co.phi(idxi.high) - (2*pi);
clear idx
clear idxi

% for Theta variable
min_phi = -(2*pi/90);   % minimum value to add to phi
max_phi =  (2*pi/90);   % maximum value to add to phi
rv_theta = (max_phi-min_phi).*rand(stream, number_of_coordinates, 1) + min_phi; % random number calculation

rand_co.theta = torus_test.theta + rv_theta;
    idx.low = (rand_co.theta)<0;
    idx.high = (rand_co.theta)>(2*pi);
    idxi.low = find(idx.low);
    idxi.high = find(idx.high);      
rand_co.theta(idxi.low) = rand_co.theta(idxi.low) + (2*pi);
rand_co.theta(idxi.high) = rand_co.theta(idxi.high) - (2*pi);
clear idx
clear idxi

% outputing data for use
random_torus_hitpoints(:,1) = ones(number_of_coordinates,1) * R;
random_torus_hitpoints(:,2) = rand_co.theta;
random_torus_hitpoints(:,3) = rand_co.phi;

% plotting created hitpoints
X = (R+r.*cos(rand_co.theta)).*cos(rand_co.phi);
Y = (R+r.*cos(rand_co.theta)).*sin(rand_co.phi);
Z = r.*sin(rand_co.theta);

hold on
plot3(X,Y,Z,'.','Color','red')


