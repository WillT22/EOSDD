
filename = 'Figures/hfp_variance_colormap.gif'; % Specify the output file name

sample_files = [dv_tenthp,dv_fifthp,dv_halfp,dv_1p,dv_2p,dv_5p,dv_10p];
titles = [0.1,0.2,0.5,1,2,5,10];

for i = 1:size(sample_files,2)
   fig = figure;
   faces_cdata = abs(sample_files(i).hfd_variance);
   patch('Faces',grid.faces,'Vertices',grid.vertices,'FaceVertexCData',faces_cdata,'FaceColor','flat','EdgeColor','None');
   colorbar
   xticks([0 pi/4 pi/2 3*pi/4 pi 5*pi/4 3*pi/2 7*pi/4 2*pi])
   xticklabels({'0', '\pi/4', '\pi/2', '3\pi/4', '\pi', '5\pi/4', '3\pi/2', '7\pi/4', '2\pi'})
   xlim([0,2*pi]);
   yticks([0 pi/4 pi/2 3*pi/4 pi 5*pi/4 3*pi/2 7*pi/4 2*pi])
   yticklabels({'0', '\pi/4', '\pi/2', '3\pi/4', '\pi', '5\pi/4', '3\pi/2', '7\pi/4', '2\pi'})
   ylim([0,2*pi]);
   daspect([2 2 2]);
   xlabel('Phi');
   ylabel('Theta');
   title(sprintf('Heat Flux Density Variance for %2.1f Percent of Data',titles(i)));
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
