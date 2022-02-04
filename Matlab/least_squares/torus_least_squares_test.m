R = 1.5;
r = 0.5;
torus_test = torus_vd(R,r,180,90);
%toroidal_graph(torus_test)


%%%%%% Perturbing Theta and Phi %%%%%%
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
min_phi = -(2*pi/90);   % minimum value to add to theta
max_phi =  (2*pi/90);   % maximum value to add to theta
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

R = torus_test.R;
r = torus_test.r;
% outputing data for use
perturbed_torus.coords(:,1) = (ones(number_of_coordinates,1)*R) + (r*cos(rand_co.theta));
perturbed_torus.coords(:,2) = rand_co.phi;
perturbed_torus.coords(:,3) = r.*sin(rand_co.theta);
perturbed_torus.R = (ones(number_of_coordinates,1)*R) + (r*cos(rand_co.theta));
perturbed_torus.Phi = rand_co.phi;
perturbed_torus.Z = r.*sin(rand_co.theta);
perturbed_torus.exact_theta = rand_co.theta;

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
perturbed_torus.perturbed_theta(:,1) = perturbed_torus.exact_theta + rv_theta;
    idx.low = (perturbed_torus.perturbed_theta(:,1))<0;
    idx.high = (perturbed_torus.perturbed_theta(:,1))>(2*pi);
    idxi.low = find(idx.low);
    idxi.high = find(idx.high);      
perturbed_torus.perturbed_theta(idxi.low,1) = perturbed_torus.perturbed_theta(idxi.low,1) + (2*pi);
perturbed_torus.perturbed_theta(idxi.high,1) = perturbed_torus.perturbed_theta(idxi.high,1) - (2*pi);
clear idx
clear idxi

%plot_2d(random_torus_hitpoints.coords(:,2),random_torus_hitpoints.perturbed_theta(:,1));

% perturbation within 1/2 division
min_phi = -(2*pi/180);   % minimum value to add to theta
max_phi =  (2*pi/180);   % maximum value to add to theta
rv_theta = (max_phi-min_phi).*rand(stream_theta, number_of_coordinates, 1) + min_phi; % random number calculation
perturbed_torus.perturbed_theta(:,2) = perturbed_torus.exact_theta + rv_theta;
    idx.low = (perturbed_torus.perturbed_theta(:,2))<0;
    idx.high = (perturbed_torus.perturbed_theta(:,2))>(2*pi);
    idxi.low = find(idx.low);
    idxi.high = find(idx.high);      
perturbed_torus.perturbed_theta(idxi.low,2) = perturbed_torus.perturbed_theta(idxi.low,2) + (2*pi);
perturbed_torus.perturbed_theta(idxi.high,2) = perturbed_torus.perturbed_theta(idxi.high,2) - (2*pi);
clear idx
clear idxi

%plot_2d(perturbed_torus.Phi, perturbed_torus.exact_theta)

torus_theta_test = importdata('EOSDD/Python/torus_theta_test.dat');
%plot_2d(perturbed_torus.Phi, torus_theta_test(:,1))

Phi_ne = [];
exact_Theta_ne = [];
test_Theta_ne = [];
for i = 1:size(perturbed_torus.Phi)
    if perturbed_torus.exact_theta(i) ~= torus_theta_test(i,1)
        Phi_ne = [Phi_ne; perturbed_torus.Phi(i)];
        exact_Theta_ne = [exact_Theta_ne; perturbed_torus.exact_theta(i)];
        test_Theta_ne = [test_Theta_ne; torus_theta_test(i,1)];
    end
end
%plot_2d(Phi_ne, exact_Theta_ne);
%plot_2d(Phi_ne, test_Theta_ne);


%%%%%% Error Analysis %%%%%%
relative_error = abs((torus_theta_test - perturbed_torus.exact_theta)./perturbed_torus.exact_theta);
%error = [perturbed_torus.exact_theta,relative_error]
absolute_error = abs((torus_theta_test - perturbed_torus.exact_theta));
error = [perturbed_torus.exact_theta,absolute_error];
error = sortrows(error,1);

error_nonzero_theta = [];
error_nonzero_temp = [];
for i = 1:size(error(:,1))    
    if error(i,2) > 0
        error_nonzero_theta = [error_nonzero_theta; error(i,1)];
        error_nonzero_temp = [error_nonzero_temp; error(i,2)];    
    end
end
error_nonzero(:,2) = error_nonzero_temp;
error_nonzero(:,1) = error_nonzero_theta;

error_nonzero1 = [];
error_nonzero2 = [];
for i = 1:size(error_nonzero(:,1))    
    if error_nonzero(i,2) > 10
        error_nonzero1 = [error_nonzero1; error_nonzero(i,:)];
    else    
        error_nonzero2 = [error_nonzero2; error_nonzero(i,:)];    
    end
end

figure
%plot(relative_error_nonzero1(:,1),relative_error_nonzero1(:,2),'Color','red')
hold on
plot(error(:,1),error(:,2),'.','Color','red')
xlabel('Exact Theta');
ylabel('Absolute Error');
xlim([0,2*pi]);

%{
% for examining the error as theta approaches 0
figure
plot(relative_error_nonzero1(:,1),relative_error_nonzero1(:,2),'Marker','.','Color','red')
set(gca, 'YScale', 'log');
xlabel('Exact Theta');
ylabel('Relative Error');
xlim([0,0.06]);
ylim([0,2.5*10^4]);
%}




