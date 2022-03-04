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
    R_lines_10 = [R_lines_10 fieldline_file(i).R_lines(:,2)];
end
R_lines_10 = reshape(R_lines_10, 40000,5);
% PHI_lines
PHI_lines_10 = [];
for i = 1:length(fieldline_file)
    PHI_lines_10 = [PHI_lines_10 fieldline_file(i).PHI_lines(:,2)];
end
PHI_lines_10 = reshape(PHI_lines_10, 40000,5);
% Z_lines
Z_lines_10 = [];
for i = 1:length(fieldline_file)
    Z_lines_10 = [Z_lines_10 fieldline_file(i).Z_lines(:,2)];
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
% relative error for R
relative_error_R = abs((R_lines_10 - calculated_coordinates.R)./R_lines_10);
max_error_R.relative = max(max(relative_error_R));
[max_error_R.relative_indicies(1), max_error_R.relative_indicies(2)] = ...
    find(relative_error_R == max_error_R.relative);
rel_error_arr_R = [linspace(0,2*pi,size(R_lines_10,1))', relative_error_R];
rel_error_arr_R = sortrows(rel_error_arr_R,1);

%{
figure
hold on
plot(rel_error_arr_R(:,1),rel_error_arr_R(:,2),'.','Color','red')
plot(rel_error_arr_R(:,1),rel_error_arr_R(:,3),'.','Color','red')
plot(rel_error_arr_R(:,1),rel_error_arr_R(:,4),'.','Color','red')
plot(rel_error_arr_R(:,1),rel_error_arr_R(:,5),'.','Color','red')
plot(rel_error_arr_R(:,1),rel_error_arr_R(:,6),'.','Color','red')
xlabel('Theta');
ylabel('Relative Error');
title('Relative Error for R v Theta')
xlim([0,2*pi]);
%}

% absolute error for R
absolute_error_R = (R_lines_10 - calculated_coordinates.R);
max_error_R.absolute = max(max(absolute_error_R));
[max_error_R.absolute_indicies(1), max_error_R.absolute_indicies(2)] = ...
    find(absolute_error_R == max_error_R.absolute);
abs_error_arr_R = [linspace(0,2*pi,size(R_lines_10,1))', absolute_error_R];
abs_error_arr_R = sortrows(abs_error_arr_R,1);
R_true_error.mean_error = sum(absolute_error_R,'all')/numel(absolute_error_R);
R_true_error.std_dev = sqrt(sum((absolute_error_R-R_true_error.mean_error).^2,'all')/numel(absolute_error_R));

figure
histogram(absolute_error_R,100000)
hold on
xline(R_true_error.mean_error, '--', 'Mean','Color','r')
xline(R_true_error.mean_error + R_true_error.std_dev, '-', '+1 Standard Deviation','Color','b')
xline(R_true_error.mean_error - R_true_error.std_dev, '-', '-1 Standard Deviation','Color','b')
xline(R_true_error.mean_error + 2*R_true_error.std_dev, '--', '+2 Standard Deviation','Color','b')
xline(R_true_error.mean_error - 2*R_true_error.std_dev, '--', '-2 Standard Deviation','Color','b')
xline(R_true_error.mean_error + 3*R_true_error.std_dev, '-.', '+3 Standard Deviation','Color','b')
xline(R_true_error.mean_error - 3*R_true_error.std_dev, '-.', '-3 Standard Deviation','Color','b')
xlim([-max_error_R.absolute,max_error_R.absolute])
xlabel('True Error for R')

%{
figure
hold on
plot(abs_error_arr_R(:,1),abs_error_arr_R(:,2),'.','Color','red')
plot(abs_error_arr_R(:,1),abs_error_arr_R(:,3),'.','Color','red')
plot(abs_error_arr_R(:,1),abs_error_arr_R(:,4),'.','Color','red')
plot(abs_error_arr_R(:,1),abs_error_arr_R(:,5),'.','Color','red')
plot(abs_error_arr_R(:,1),abs_error_arr_R(:,6),'.','Color','red')
xlabel('Theta');
ylabel('Absolute Error');
title('Absolute Error for R v Theta')
xlim([0,2*pi]);
%}

% relative error for Z
relative_error_Z = abs((Z_lines_10 - calculated_coordinates.Z)./Z_lines_10);
max_error_Z.relative = max(max(abs(relative_error_Z)));
[max_error_Z.relative_indicies(1), max_error_Z.relative_indicies(2)] = ...
    find(relative_error_Z == max_error_Z.relative);
rel_error_arr_Z = [linspace(0,2*pi,size(Z_lines_10,1))', relative_error_Z];
rel_error_arr_Z = sortrows(rel_error_arr_Z,1);


%{
figure
hold on
plot(rel_error_arr_Z(:,1),rel_error_arr_Z(:,2),'.','Color','red')
plot(rel_error_arr_Z(:,1),rel_error_arr_Z(:,3),'.','Color','red')
plot(rel_error_arr_Z(:,1),rel_error_arr_Z(:,4),'.','Color','red')
plot(rel_error_arr_Z(:,1),rel_error_arr_Z(:,5),'.','Color','red')
plot(rel_error_arr_Z(:,1),rel_error_arr_Z(:,6),'.','Color','red')
xlabel('Theta');
ylabel('Relative Error');
title('Relative Error for Z v Theta')
xlim([0,2*pi]);
%}

% absolute error for Z
absolute_error_Z = (Z_lines_10 - calculated_coordinates.Z);
max_error_Z.absolute = max(max(abs(absolute_error_Z)));
[max_error_Z.absolute_indicies(1), max_error_Z.absolute_indicies(2)] = ...
    find(absolute_error_Z == -max_error_Z.absolute);
abs_error_arr_Z = [linspace(0,2*pi,size(Z_lines_10,1))', absolute_error_Z];
abs_error_arr_Z = sortrows(abs_error_arr_Z,1);
Z_true_error.mean_error = sum(absolute_error_Z,'all')/numel(absolute_error_Z);
Z_true_error.std_dev = sqrt(sum((absolute_error_Z-Z_true_error.mean_error).^2,'all')/numel(absolute_error_R));

figure
histogram(absolute_error_Z,100000)
hold on
xline(Z_true_error.mean_error, '--', 'Mean','Color','r')
xline(Z_true_error.mean_error + Z_true_error.std_dev, '-', '+1 Standard Deviation','Color','b')
xline(Z_true_error.mean_error - Z_true_error.std_dev, '-', '-1 Standard Deviation','Color','b')
xline(Z_true_error.mean_error + 2*Z_true_error.std_dev, '--', '+2 Standard Deviation','Color','b')
xline(Z_true_error.mean_error - 2*Z_true_error.std_dev, '--', '-2 Standard Deviation','Color','b')
xline(Z_true_error.mean_error + 3*Z_true_error.std_dev, '-.', '+3 Standard Deviation','Color','b')
xline(Z_true_error.mean_error - 3*Z_true_error.std_dev, '-.', '-3 Standard Deviation','Color','b')
xlim([-max_error_Z.absolute,max_error_Z.absolute])
xlabel('True Error for Z')

%{
figure
hold on
plot(abs_error_arr_Z(:,1),abs_error_arr_Z(:,2),'.','Color','red')
plot(abs_error_arr_Z(:,1),abs_error_arr_Z(:,3),'.','Color','red')
plot(abs_error_arr_Z(:,1),abs_error_arr_Z(:,4),'.','Color','red')
plot(abs_error_arr_Z(:,1),abs_error_arr_Z(:,5),'.','Color','red')
plot(abs_error_arr_Z(:,1),abs_error_arr_Z(:,6),'.','Color','red')
xlabel('Theta');
ylabel('Absolute Error');
title('Absolute Error for Z v Theta')
xlim([0,2*pi]);
%}
