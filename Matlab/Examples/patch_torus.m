R = 5;  % outer radius of the torus
r = 2;  % inner radius of the torus

phi = linspace(0,2*pi,36);   % partition as measured in the toroidal direction
theta = linspace(0,2*pi,18); % partition as measured in the poloidal direction

[Phi,Theta]=meshgrid(phi,theta); % creates an array from phi and theta 

% torus coordinate functions 
x=(R+r.*cos(Theta)).*cos(Phi);
y=(R+r.*cos(Theta)).*sin(Phi);
z=r.*sin(Theta);

patch(surf2patch(x,y,z,z,'traingles')); % created the patch figure from the torus equations
view(3)                                 % view in 3D
daspect([1 1 1]);                       % sets the aspect ratio to 1:1:1
shading faceted;                        % provides shading of the torus based on color map
colormap('parula');                     % change color map used
title('Torus');                         % titles the graph
xlabel('X');ylabel('Y');zlabel('Z');    % labels the axes

% https://www.mathworks.com/matlabcentral/answers/95230-how-do-i-plot-a-toroid-in-matlab
% Used MATLAB Introduction to Patch Objects, Multifaceted Patches, patch,surf2patch, shading, and colormap help pages