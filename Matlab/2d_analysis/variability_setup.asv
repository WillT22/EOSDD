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

%% Setting up data for variability function %%
% compiling hit point data into a single matrix for used in functions
fieldline_file = [fldlns_Cbar1_f_10, fldlns_Cbar1_r_10, fldlns_Cbar2_f_10,...
    fldlns_Cbar2_r_10, fldlns_Cbar3_f_10, fldlns_Cbar3_r_10,...
    fldlns_Cbar4_f_10, fldlns_Cbar4_r_10, fldlns_Cbar5_f_10,...
    fldlns_Cbar5_r_10];
% importing theta data from least squares function
ls_trig_data = importdata('./EOSDD/Python/Theta_Cbar_10.dat');
% creating vessel facet data
pcs_10 = toroidal_mesh('../../p/stellopt/ANALYSIS/wteague/flux_surface/nvac_fldlns/fb_bnorm/nescin.fb_10');
% stating what percent of data to be analyzed 
    %(optional if only wanting total data analysis)
percent = 10;
% stating desired number of samples
    %(optional if only wanting total data analysis)
samples = 10;
% stating desired radomization stream (optional)
stream = load('/u/wteague/EOSDD/Matlab/2d_analysis/variability.mat');
stream = stream.stream;
% running data heat flux density analysis
data_variance_original = variability(fieldline_file,ls_trig_data,pcs_10);;
data_variance_test = variability(fieldline_file,ls_trig_data,pcs_10,percent,samples);

%{
%% Color Mapping Heat Flux Data %%
% PHI Lines
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
% THETA Lines
THETA_lines_10 = importdata('EOSDD/Python/Theta_Cbar_10.dat');

% plotting color mapping of total heat flux
plot_2d(PHI_lines_10, THETA_lines_10,1,data_variance_original)

% plotting color mapping of sample heat flux
plot_2d(PHI_lines_10, THETA_lines_10,1,data_variance_test,2)
%}