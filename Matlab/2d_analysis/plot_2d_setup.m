%% Importing hitpoint data from fieldlines %%
% importing hit point data from FIELDLINES simulations
%{
fldlns_Cbar1_f_10 = read_fieldlines('../../../p/stellopt/ANALYSIS/wteague/flux_surface/simulations/fieldlines/Cbar/fieldlines_Cbar1_f_10.h5');
fldlns_Cbar2_f_10 = read_fieldlines('../../../p/stellopt/ANALYSIS/wteague/flux_surface/simulations/fieldlines/Cbar/fieldlines_Cbar2_f_10.h5');
fldlns_Cbar3_f_10 = read_fieldlines('../../../p/stellopt/ANALYSIS/wteague/flux_surface/simulations/fieldlines/Cbar/fieldlines_Cbar3_f_10.h5');
fldlns_Cbar4_f_10 = read_fieldlines('../../../p/stellopt/ANALYSIS/wteague/flux_surface/simulations/fieldlines/Cbar/fieldlines_Cbar4_f_10.h5');
fldlns_Cbar5_f_10 = read_fieldlines('../../../p/stellopt/ANALYSIS/wteague/flux_surface/simulations/fieldlines/Cbar/fieldlines_Cbar5_f_10.h5');

fldlns_Cbar1_r_10 = read_fieldlines('../../../p/stellopt/ANALYSIS/wteague/flux_surface/simulations/fieldlines/Cbar/fieldlines_Cbar1_r_10.h5');
fldlns_Cbar2_r_10 = read_fieldlines('../../../p/stellopt/ANALYSIS/wteague/flux_surface/simulations/fieldlines/Cbar/fieldlines_Cbar2_r_10.h5');
fldlns_Cbar3_r_10 = read_fieldlines('../../../p/stellopt/ANALYSIS/wteague/flux_surface/simulations/fieldlines/Cbar/fieldlines_Cbar3_r_10.h5');
fldlns_Cbar4_r_10 = read_fieldlines('../../../p/stellopt/ANALYSIS/wteague/flux_surface/simulations/fieldlines/Cbar/fieldlines_Cbar4_r_10.h5');
fldlns_Cbar5_r_10 = read_fieldlines('../../../p/stellopt/ANALYSIS/wteague/flux_surface/simulations/fieldlines/Cbar/fieldlines_Cbar5_r_10.h5');
%}

% compiling hit point data into a single matrix for used in functions
fieldline_file = [fldlns_Cbar1_f_10, fldlns_Cbar1_r_10, fldlns_Cbar2_f_10,...
    fldlns_Cbar2_r_10, fldlns_Cbar3_f_10, fldlns_Cbar3_r_10,...
    fldlns_Cbar4_f_10, fldlns_Cbar4_r_10, fldlns_Cbar5_f_10,...
    fldlns_Cbar5_r_10];

%% PHI Lines
PHI_lines_10 = [];
for i = 1:length(fieldline_file)
    PHI_lines_10 = [PHI_lines_10 fieldline_file(i).PHI_lines(:,2)];
end
PHI_lines_10 = reshape(PHI_lines_10, 40000,5);
for f = 1:size(PHI_lines_10,2)
    for i = 1:size(PHI_lines_10,1)
        if PHI_lines_10(i,f) < 0
			PHI_lines_10(i,f) = PHI_lines_10(i,f) + 2*pi;
        end
    end
end
%% THETA Lines
THETA_lines_10 = importdata('EOSDD/Python/Theta_Cbar_10.dat');

%% plot_2d
plot_2d(PHI_lines_10, THETA_lines_10)

%% Plotting a Color Mapping of Heat Flux on the Surface
plot_2d(PHI_lines_10, THETA_lines_10, 1, data_variance, 2)