fileID = fopen('SULI21/Vessel/flux_coords.dat','w');
fprintf(fileID, 'Flux Surface Cylindrical Coordinates\n\n');
arr_index = [1:size(flux_co(10).r)]';
fluxcoords = [flux_co(10).r flux_co(10).z flux_co(10).phi];

for i = 1:size(flux_co(10).r)
    fprintf(fileID, 'R(%.0d) = %14.12d    Z(%.0d) = %14.12d     PHI(%.0d) = %14.12d\n',...
        arr_index(i), fluxcoords(i,1)', arr_index(i), fluxcoords(i,2)', arr_index(i), fluxcoords(i,3)');
end
fclose(fileID);
