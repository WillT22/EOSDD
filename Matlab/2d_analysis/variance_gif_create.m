
filename = 'Figures/sample_variance.gif'; % Specify the output file name

sample_files = [dv_tenthp,dv_fifthp,dv_halfp,dv_1p,dv_2p,dv_5p,dv_10p];
titles = [0.1,0.2,0.5,1,2,5,10];

clear grid;
p=180;
t=90;
a = p*t; % number of vertices that will be used
b = a+p+t+1;
phi = linspace(0,2*pi,p+1); % partition as measured in the toroidal direction 
theta = linspace(0,2*pi,t+1);   % partition as measured in the poloidal direction
[Phi, Theta]=meshgrid(phi(1:p+1),theta(1:t+1)); % creates an array from phi and theta 
Phi = reshape(Phi,[b,1]);
Theta = reshape(Theta,[b,1]);
grid.vertices(:,1) = Phi;
grid.vertices(:,2) = Theta;

clear faces
faces.lower(:,1) = [1:b-(t+1)];
faces.lower(:,2) = [2:b-t];
faces.lower(:,3) = [t+2:b];
faces.lower(t+1:t+1:end,:) = [];

faces.upper(:,1) = [2:b-t];
faces.upper(:,2) = [t+3:b+1];
faces.upper(:,3) = [t+2:b];
faces.upper(t+1:t+1:end,:) = [];

grid.faces = reshape([faces.lower(:) faces.upper(:)]', [], 3); % combines upper and lower triangular face arrays using every other row

for i = 1:size(sample_files,2)
   fig = figure;
   faces_cdata = abs(sample_files(i).sample_variance);
   patch('Faces',grid.faces,'Vertices',grid.vertices,'FaceVertexCData',faces_cdata,'FaceColor','flat','EdgeColor','None');
   xticks([0 pi/4 pi/2 3*pi/4 pi 5*pi/4 3*pi/2 7*pi/4 2*pi])
   xticklabels({'0', '\pi/4', '\pi/2', '3\pi/4', '\pi', '5\pi/4', '3\pi/2', '7\pi/4', '2\pi'})
   xlim([0,2*pi]);
   yticks([0 pi/4 pi/2 3*pi/4 pi 5*pi/4 3*pi/2 7*pi/4 2*pi])
   yticklabels({'0', '\pi/4', '\pi/2', '3\pi/4', '\pi', '5\pi/4', '3\pi/2', '7\pi/4', '2\pi'})
   ylim([0,2*pi]);
   daspect([2 2 2]);
   xlabel('Phi');
   ylabel('Theta');
   title(sprintf('Variance for %2.1f Percent of Data',titles(i)));
   frame = getframe(fig);
   im{i} = frame2im(frame);
end

clear fig;
clear frame;

figure;
for idx = 1:size(sample_files,2)
    subplot(3,3,idx)
    imshow(im{idx});
end

for idx = 1:size(sample_files,2)
    [A,map] = rgb2ind(im{idx},256);
    if idx == 1
        imwrite(A,map,filename,'gif','LoopCount',Inf,'DelayTime',1);
    else
        imwrite(A,map,filename,'gif','WriteMode','append','DelayTime',1);
    end
end