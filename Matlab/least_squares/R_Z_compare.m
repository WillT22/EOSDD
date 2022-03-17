%% Importing hitpoint data from fieldlines %%
fldlns_Cbar1_f_10 = read_fieldlines('../../p/stellopt/ANALYSIS/wteague/flux_surface/simulations/fieldlines/Cbar/fieldlines_Cbar1_f_10.h5');
fldlns_Cbar2_f_10 = read_fieldlines('../../p/stellopt/ANALYSIS/wteague/flux_surface/simulations/fieldlines/Cbar/fieldlines_Cbar2_f_10.h5');
fldlns_Cbar3_f_10 = read_fieldlines('../../p/stellopt/ANALYSIS/wteague/flux_surface/simulations/fieldlines/Cbar/fieldlines_Cbar3_f_10.h5');
fldlns_Cbar4_f_10 = read_fieldlines('../../p/stellopt/ANALYSIS/wteague/flux_surface/simulations/fieldlines/Cbar/fieldlines_Cbar4_f_10.h5');
fldlns_Cbar5_f_10 = read_fieldlines('../../p/stellopt/ANALYSIS/wteague/flux_surface/simulations/fieldlines/Cbar/fieldlines_Cbar5_f_10.h5');

fldlns_Cbar1_r_10 = read_fieldlines('../../p/stellopt/ANALYSIS/wteague/flux_surface/simulations/fieldlines/Cbar/fieldlines_Cbar1_r_10.h5');
fldlns_Cbar2_r_10 = read_fieldlines('../../p/stellopt/ANALYSIS/wteague/flux_surface/simulations/fieldlines/Cbar/fieldlines_Cbar2_r_10.h5');
fldlns_Cbar3_r_10 = read_fieldlines('../../p/stellopt/ANALYSIS/wteague/flux_surface/simulations/fieldlines/Cbar/fieldlines_Cbar3_r_10.h5');
fldlns_Cbar4_r_10 = read_fieldlines('../../p/stellopt/ANALYSIS/wteague/flux_surface/simulations/fieldlines/Cbar/fieldlines_Cbar4_r_10.h5');
fldlns_Cbar5_r_10 = read_fieldlines('../../p/stellopt/ANALYSIS/wteague/flux_surface/simulations/fieldlines/Cbar/fieldlines_Cbar5_r_10.h5');

fieldline_file = [fldlns_Cbar1_f_10, fldlns_Cbar1_r_10, fldlns_Cbar2_f_10,...
    fldlns_Cbar2_r_10, fldlns_Cbar3_f_10, fldlns_Cbar3_r_10,...
    fldlns_Cbar4_f_10, fldlns_Cbar4_r_10, fldlns_Cbar5_f_10,...
    fldlns_Cbar5_r_10];
% R_lines
R_lines_10 = [];
for i = 1:length(fieldline_file)
    R_lines_10 = [R_lines_10, fieldline_file(i).R_lines(:,2)];
end
R_lines_10 = reshape(R_lines_10, 40000,5);
% PHI_lines
PHI_lines_10 = [];
for i = 1:length(fieldline_file)
    PHI_lines_10 = [PHI_lines_10, fieldline_file(i).PHI_lines(:,2)];
end
PHI_lines_10 = reshape(PHI_lines_10, 40000,5);
% Z_lines
Z_lines_10 = [];
for i = 1:length(fieldline_file)
    Z_lines_10 = [Z_lines_10, fieldline_file(i).Z_lines(:,2)];
end
Z_lines_10 = reshape(Z_lines_10, 40000,5);

%% Importing Approximate Theta from least_squares function %%
THETA_lines_10 = importdata('./EOSDD/Python/Theta_Cbar_10.dat');

%% Calculating R and Z based on fourier coeffecients and PHI and THETA %%
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

for i = 1:size(PHI_lines_10,2)
    [M, Theta] = meshgrid(fourier_coeff.m, THETA_lines_10(:,i));
    [N, Phi] = meshgrid(fourier_coeff.n, PHI_lines_10(:,i));

    % radial component
    r_mnc = repmat(fourier_coeff.crc2',size(Phi,1),1);
    r_elementarr = r_mnc .* cos(M .* Theta + 3 * N .* Phi);
    calculated_coordinates.R(:,i) = sum(r_elementarr,2);

    % z component
    z_mns = repmat(fourier_coeff.czs2',size(Phi,1),1);
    z_elementarr = z_mns .* sin(M .* Theta + 3 * N .* Phi);
    calculated_coordinates.Z(:,i) = sum(z_elementarr,2);
end

%% Error Analysis %%
% absolute error for R
error_R = R_lines_10 - calculated_coordinates.R;
absolute_error_R = abs(error_R);
max_error_R.true = max(max(error_R));
min_error_R.true = min(min(error_R));
[max_error_R.absolute_indicies(1), max_error_R.absolute_indicies(2)] = ...
    find(absolute_error_R == max_error_R.absolute);

%{
angle_a = 5*pi/12;
angle_b = 19*pi/12
% points of the exterior of the surface
R_lines_10_out = [];
calculated_coordinates.R_out = [];
for j = 1:size(THETA_lines_10,2)
    for i = 1:size(THETA_lines_10,1)
        if THETA_lines_10(i,j) <= angle_a || THETA_lines_10(i,j) > angle_b
            R_lines_10_out = [R_lines_10_out, R_lines_10(i,j)];
            calculated_coordinates.R_out = [calculated_coordinates.R_out, calculated_coordinates.R(i,j)];
        end
    end
end
absolute_error_R = (R_lines_10_out - calculated_coordinates.R_out);


% points of the interior of the surface
R_lines_10_in = [];
calculated_coordinates.R_in = [];
for j = 1:size(THETA_lines_10,2)
    for i = 1:size(THETA_lines_10,1)
        if THETA_lines_10(i,j) > angle_a && THETA_lines_10(i,j) <= angle_b
            R_lines_10_in = [R_lines_10_in, R_lines_10(i,j)];
            calculated_coordinates.R_in = [calculated_coordinates.R_in, calculated_coordinates.R(i,j)];
        end
    end
end
absolute_error_R = (R_lines_10_in - calculated_coordinates.R_in);
%}

R_true_error.mean_error = sum(error_R,'all')/numel(error_R);
R_true_error.std_dev = sqrt(sum((error_R-R_true_error.mean_error).^2,'all')/numel(error_R));
    
figure
histogram(error_R,10000)
hold on
xline(R_true_error.mean_error, '--', 'Mean','Color','r')
xline(R_true_error.mean_error + R_true_error.std_dev, '-', '+1 Standard Deviation','Color','b')
xline(R_true_error.mean_error - R_true_error.std_dev, '-', '-1 Standard Deviation','Color','b')
xline(R_true_error.mean_error + 2*R_true_error.std_dev, '--', '+2 Standard Deviation','Color','b')
xline(R_true_error.mean_error - 2*R_true_error.std_dev, '--', '-2 Standard Deviation','Color','b')
xline(R_true_error.mean_error + 3*R_true_error.std_dev, '-.', '+3 Standard Deviation','Color','b')
xline(R_true_error.mean_error - 3*R_true_error.std_dev, '-.', '-3 Standard Deviation','Color','b')
xlim([min_error_R.true,max_error_R.true])
xlabel('Error for R')
ylabels = linspace(0,100,11);
set(gca,'YTickLabel',ylabels);

%{
% plotting absolute error
figure
hold on
plot(THETA_lines_10,absolute_error_R,'.','Color','red')
xlabel('Theta');
ylabel('Absolute Error');
title('Absolute Error for R v Theta')
xlim([0,2*pi]);
%}

% relative error for R
%{
relative_error_R = abs((R_lines_10 - calculated_coordinates.R)./R_lines_10);
max_error_R.relative = max(max(relative_error_R));
[max_error_R.relative_indicies(1), max_error_R.relative_indicies(2)] = ...
    find(relative_error_R == max_error_R.relative);
rel_error_arr_R = [linspace(0,2*pi,size(R_lines_10,1))', relative_error_R];
rel_error_arr_R = sortrows(rel_error_arr_R,1);

figure
hold on
plot(THETA_lines_10,relative_error_R,'.','Color','red')
xlabel('Theta');
ylabel('Relative Error');
title('Relative Error for R v Theta')
xlim([0,2*pi]);
%}

% absolute error for Z
error_Z = Z_lines_10 - calculated_coordinates.Z;
absolute_error_Z = abs(error_Z);
max_error_Z.true = max(max(error_Z));
min_error_Z.true = min(min(error_Z));
[max_error_Z.absolute_indicies(1), max_error_Z.absolute_indicies(2)] = ...
    find(absolute_error_Z == max_error_Z.absolute);
Z_true_error.mean_error = sum(error_Z,'all')/numel(error_Z);
Z_true_error.std_dev = sqrt(sum((error_Z-Z_true_error.mean_error).^2,'all')/numel(error_R));


figure
histogram(error_Z,10000)
hold on
xline(Z_true_error.mean_error, '--', 'Mean','Color','r')
xline(Z_true_error.mean_error + Z_true_error.std_dev, '-', '+1 Standard Deviation','Color','b')
xline(Z_true_error.mean_error - Z_true_error.std_dev, '-', '-1 Standard Deviation','Color','b')
xline(Z_true_error.mean_error + 2*Z_true_error.std_dev, '--', '+2 Standard Deviation','Color','b')
xline(Z_true_error.mean_error - 2*Z_true_error.std_dev, '--', '-2 Standard Deviation','Color','b')
xline(Z_true_error.mean_error + 3*Z_true_error.std_dev, '-.', '+3 Standard Deviation','Color','b')
xline(Z_true_error.mean_error - 3*Z_true_error.std_dev, '-.', '-3 Standard Deviation','Color','b')
xlim([-max_error_Z.true,max_error_Z.true])
xlabel('Error for Z')
ylabels = linspace(0,100,11);
set(gca,'YTickLabel',ylabels);


%{
figure
hold on
plot(THETA_lines_10,absolute_error_Z,'.','Color','red')
xlabel('Theta');
ylabel('Absolute Error');
title('Absolute Error for Z v Theta')
xlim([0,2*pi]);
%}

% relative error for Z
%{
relative_error_Z = abs((Z_lines_10 - calculated_coordinates.Z)./Z_lines_10);
max_error_Z.relative = max(max(abs(relative_error_Z)));
[max_error_Z.relative_indicies(1), max_error_Z.relative_indicies(2)] = ...
    find(relative_error_Z == max_error_Z.relative);

figure
hold on
plot(THETA_lines_10,relative_error_Z,'.','Color','red')
xlabel('Theta');
ylabel('Relative Error');
title('Relative Error for Z v Theta')
xlim([0,2*pi]);
%}
