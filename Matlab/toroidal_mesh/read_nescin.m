function [fourier_coeff] = read_necsin(nescin_file)
% Reads the data under the Current Surface Fourier Coefficients in a given
% nescin file

fileID = fopen(nescin_file);
fourier_cell = textscan(fileID, '%f%f%f%f%f%f', 'Headerlines', 172, 'CollectOutput', true);
                % change the number of header lines depending on the file?
fclose(fileID);

fourier_coeff.m = fourier_cell{1}(:,1);
fourier_coeff.n = fourier_cell{1}(:,2);
fourier_coeff.crc2 = fourier_cell{1}(:,3);
fourier_coeff.czs2 = fourier_cell{1}(:,4);
fourier_coeff.crs2 = fourier_cell{1}(:,5);
fourier_coeff.czc2 = fourier_cell{1}(:,6);
