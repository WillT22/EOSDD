toroidal_test = toroidal_mesh('../../p/stellopt/ANALYSIS/wteague/flux_surface/nvac_fldlns/fb_bnorm/nescin.fb_10',180,90);

%% Perturbing Theta and Phi %%
number_of_coordinates = length(toroidal_test.phi);
% Initializing Randomization Stream %
stream = load('/u/wteague/EOSDD/Matlab/least_squares/least_squares_stream.mat');
stream = stream.stream;

% Setting up Randomization %
% for Phi variable
min_phi = -(2*pi/180);   % minimum value to add to phi
max_phi =  (2*pi/180);   % maximum value to add to phi
rv_phi = (max_phi-min_phi).*rand(stream, number_of_coordinates, 1) + min_phi; % random number calculation
rand_co.phi = toroidal_test.phi + rv_phi;
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
rand_co.theta = toroidal_test.theta + rv_theta;
    idx.low = (rand_co.theta)<0;
    idx.high = (rand_co.theta)>(2*pi);
    idxi.low = find(idx.low);
    idxi.high = find(idx.high);      
rand_co.theta(idxi.low) = rand_co.theta(idxi.low) + (2*pi);
rand_co.theta(idxi.high) = rand_co.theta(idxi.high) - (2*pi);
clear idx
clear idxi


fileID = fopen('../../p/stellopt/ANALYSIS/wteague/flux_surface/nvac_fldlns/fb_bnorm/nescin.fb_10');
fourier_cell = textscan(fileID, '%f%f%f%f%f%f', 'Headerlines', 172, 'CollectOutput', true);
fclose(fileID);
fourier_coeff.m = fourier_cell{1}(:,1);
fourier_coeff.n = fourier_cell{1}(:,2);
fourier_coeff.crc2 = fourier_cell{1}(:,3);
fourier_coeff.czs2 = fourier_cell{1}(:,4);
fourier_coeff.crs2 = fourier_cell{1}(:,5);
fourier_coeff.czc2 = fourier_cell{1}(:,6);
clear fourier_cell;

[M, Theta] = meshgrid(fourier_coeff.m, rand_co.theta);
[N, Phi] = meshgrid(fourier_coeff.n, rand_co.phi);

% radial component
r_mnc = repmat(fourier_coeff.crc2',number_of_coordinates,1);
r_elementarr = r_mnc .* cos(M .* Theta + 3 * N .* Phi); 

% z component
z_mns = repmat(fourier_coeff.czs2',number_of_coordinates,1);
z_elementarr = z_mns .* sin(M .* Theta + 3 * N .* Phi);

% outputing data for use
perturbed_toroidal.R = sum(r_elementarr,2);
perturbed_toroidal.Phi = rand_co.phi;
perturbed_toroidal.Z = sum(z_elementarr,2);
perturbed_toroidal.coords(:,1) = perturbed_toroidal.R;
perturbed_toroidal.coords(:,2) = perturbed_toroidal.Phi;
perturbed_toroidal.coords(:,3) = perturbed_toroidal.Z;
perturbed_toroidal.exact_theta = rand_co.theta;

toroidal_theta_test = importdata('./EOSDD/Python/tests/toroidal_test/toroidal_theta_test.dat');
%plot_2d(perturbed_toroidal.Phi, perturbed_toroidal.exact_theta)
%plot_2d(perturbed_toroidal.Phi, toroidal_theta_test(:,1))


%% Error Analysis %%
% relative error
relative_error = abs((toroidal_theta_test - perturbed_toroidal.exact_theta)./perturbed_toroidal.exact_theta);
rel_error_arr = [perturbed_toroidal.exact_theta, relative_error];
rel_error_arr = sortrows(rel_error_arr,1);

figure
plot(rel_error_arr(:,1),rel_error_arr(:,2),'.','Color','red')
xlabel('Exact Theta');
ylabel('Relative Error');
xlim([0,2*pi]);

% absolute error
absolute_error = abs((toroidal_theta_test - perturbed_toroidal.exact_theta));
abs_error_arr = [perturbed_toroidal.exact_theta, absolute_error];
abs_error_arr = sortrows(abs_error_arr,1);

figure
plot(abs_error_arr(:,1),abs_error_arr(:,2),'.','Color','red')
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

