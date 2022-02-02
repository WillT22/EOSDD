R = 1.5;
r = 0.5;
torus_test = torus_vd(R,r,180,90);
%toroidal_graph(torus_test)

perturbed_torus = least_squares_test(torus_test);
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

relative_error = abs((torus_theta_test - perturbed_torus.exact_theta)./perturbed_torus.exact_theta);
relative_error_nonzero_theta = [];
relative_error_nonzero_temp = [];
for i = 1:size(relative_error(:,1))    
    if relative_error(i,1) > 0
        relative_error_nonzero_theta = [relative_error_nonzero_theta; perturbed_torus.exact_theta(i)];
        relative_error_nonzero_temp = [relative_error_nonzero_temp; relative_error(i,1)];    
    end
end
relative_error_nonzero(:,2) = relative_error_nonzero_temp;
relative_error_nonzero(:,1) = relative_error_nonzero_theta;
relative_error_nonzero = sortrows(relative_error_nonzero,1);

relative_error_nonzero1 = [];
relative_error_nonzero2 = [];
for i = 1:size(relative_error_nonzero(:,1))    
    if relative_error_nonzero(i,2) > 10
        relative_error_nonzero1 = [relative_error_nonzero1; relative_error_nonzero(i,:)];
    else    
        relative_error_nonzero2 = [relative_error_nonzero2; relative_error_nonzero(i,:)];    
    end
end

figure
plot(relative_error_nonzero1(:,1),relative_error_nonzero1(:,2),'Color','red')
hold on
plot(perturbed_torus.exact_theta,relative_error(:,1),'.','Color','red')
xlabel('Exact Theta');
ylabel('Relative Error');
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




