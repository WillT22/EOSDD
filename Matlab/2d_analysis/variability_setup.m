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
% stating desired radomization stream (optional)
seed = 128;
%{
% running data heat flux density analysis
dv_original = variability(fieldline_file,ls_trig_data,pcs_10);

dv_10p    = variability(fieldline_file,ls_trig_data,pcs_10,10,1000,seed);
dv_5p     = variability(fieldline_file,ls_trig_data,pcs_10,5,1000,seed);
dv_2p     = variability(fieldline_file,ls_trig_data,pcs_10,2,1000,seed);
dv_1p     = variability(fieldline_file,ls_trig_data,pcs_10,1,1000,seed);
dv_halfp  = variability(fieldline_file,ls_trig_data,pcs_10,0.5,1000,seed);
dv_fifthp = variability(fieldline_file,ls_trig_data,pcs_10,0.2,1000,seed);
dv_tenthp = variability(fieldline_file,ls_trig_data,pcs_10,0.1,1000,seed);
%}
%% Color Mapping Heat Flux Data %%
%{
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
clear f
clear i
% THETA Lines
THETA_lines_10 = importdata('EOSDD/Python/Theta_Cbar_10.dat');

% plotting color mapping of total heat flux
%plot_2d(PHI_lines_10, THETA_lines_10,1,dv_original)

% plotting color mapping of sample heat flux
%plot_2d(PHI_lines_10, THETA_lines_10,1,dv_tenthp,2)

%plotting color mapping of variance for sample heat flux
%plot_2d(PHI_lines_10, THETA_lines_10,2,dv_2p)
%}

%% Plotting Error
%{
figure
hold on
plot(linspace(1,length(dv_10p.nhp_trig),length(dv_10p.nhp_trig)),dv_10p.sample_error,'.','Color','red')
xlabel('Triangle Number');
ylabel('Error');
title('10 Percent Data Error')
xlim([0,length(dv_10p.nhp_trig)]);
%}
%{
figure
hold on
histogram(dv_10p.sample_error,100000)
xlabel('Error');
title('10 Percent Data Error')
ylim([0,150]);

figure
hold on
histogram(dv_1p.sample_error,100000)
xlabel('Error');
title('1 Percent Data Error')
ylim([0,1500]);

figure
hold on
histogram(dv_halfp.sample_error,100000)
xlabel('Error');
title('1/2 Percent Data Error')
ylim([0,3000]);
%}
%{
% get sample size
x_vari = [size(dv_10p.sample_trig,1),size(dv_5p.sample_trig,1),...
    size(dv_2p.sample_trig,1),size(dv_1p.sample_trig,1),...
    size(dv_halfp.sample_trig,1),size(dv_fifthp.sample_trig,1),size(dv_tenthp.sample_trig,1)];
% get average variance across all samples
y_mean_vari = [dv_10p.avg_error,dv_5p.avg_error,dv_2p.avg_error,...
    dv_1p.avg_error,dv_halfp.avg_error,dv_fifthp.avg_error,dv_tenthp.avg_error];
% get standard deviation of variance across samples
y_std_dev = [dv_10p.std_dev,dv_5p.std_dev,dv_2p.std_dev,dv_1p.std_dev,...
    dv_halfp.std_dev,dv_fifthp.std_dev,dv_tenthp.std_dev];
% plot
figure
hold on
plot(x_vari,abs(y_mean_vari),'.','Color','black')
%errorbar(x_vari,y_mean_vari,y_std_dev,'.','Color','black');
set(gca, 'XScale','log')
xlim([100,30000]);
xlabel('Sample Size (Log Scale)');
xticks(sort(x_vari));
xticklabels({'200','400','1000','2000','4000','10000','20000'})
ylabel('Error (Hit points/Triangle/m^2)');
title('Error v. Sample Size')
%}

%% Plotting Variance for number of hitpoints/cell
% for every sample
samples = [dv_tenthp,dv_fifthp,dv_halfp,dv_1p,dv_2p,dv_5p,dv_10p];
for i = 1:size(samples,2)
    % temporary ordered array where maximum number will be deleted through each itteration
    ordered = sortrows([linspace(1,size(samples(i).nhp_trig,1),size(samples(i).nhp_trig,1))',samples(i).nhp_trig],2);
    % bin array to keep track of number of hit points and variance
    samples(i).bin_array = linspace(0,max(ordered(:,2)),max(ordered(:,2))+1)';
    for j = 1:size(unique(ordered(:,2)),1);
        [r,c] = find(ordered(:,2) == max(ordered(:,2)));
        temp_sum = 0;
        for k = 1:size(r,1)
            temp_sum = temp_sum + sum((samples(i).sample_hf_density(ordered(r(k),1),:)-samples(i).hf_density(ordered(r(k),1))).^2);
            ordered(r(k),2) = 0;
        end
        disp(temp_sum);
        samples(i).bin_array(max(ordered(:,2))+1,2) = temp_sum/(size(r,1)*size(samples(i).sample_nhp_trig,2)-1);
    end
end