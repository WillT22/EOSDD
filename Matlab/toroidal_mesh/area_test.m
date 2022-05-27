% actual surface area of a torus is A = (2*pi*R) * (2*pi*r)
% where R is the major radius and r is the minor radius
R = 2;
r = 1;
torus_Area = (2*pi*R)*(2*pi*r)

% creating toroidal and poloidal divisions
torus_area(:,1) = linspace(90,360,28);
torus_area(:,2) = linspace(45,180,28);

for i = 1:size(p_in,2)
    torus_dat = torus_vd(R,r,p_in(i),t_in(i))
    torus_area(i,3) = sum(torus_dat.areas)
end

% finding the error in each area
torus_area(:,4) = torus_Area - torus_area(:,3);

% Graphing
%{
plot(x,torus_area(:,4))
set(gca, 'XScale', 'log');
set(gca, 'YScale', 'log');
xlabel('Number of Grid Points');
ylabel('Relative Error');
%}