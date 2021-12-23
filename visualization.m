tic
jump = 1;
writerObj = VideoWriter('langevin_short_50.avi');
writerObj.FrameRate = 2;
[~,~,frames] = size(N_record);
frames = floor(frames/jump);
open(writerObj);
Framevideo(frames) = struct('cdata',[],'colormap',[]);

for ii = 1:frames
figure(1);
N_pos = N_record(:,:,ii);
for i = 1:N
    H2 = [N_pos(i*12-11) N_pos(i*12-10) N_pos(i*12-9)];
    H1 = [N_pos(i*12-8) N_pos(i*12-7) N_pos(i*12-6)];
    O = [N_pos(i*12-5) N_pos(i*12-4) N_pos(i*12-3)];
    xyz = vertcat(H1,O,H2);
    plot3(xyz(:,1),xyz(:,2),xyz(:,3),'-o')
    hold on 
    
end
hold off
fig = gcf;

xlim([-3 9])
ylim([-2 4])
zlim([-2 2])

drawnow
Framevideo(ii) = getframe(gcf);
writeVideo(writerObj,Framevideo(ii));
pause(.001)
shg
end

close(writerObj);
toc
clear writerObj
clear Framevideo
angle_OH = zeros(N,1);
for i = 1:N
    angle_OH(i) = rad2deg(angle(N_pos(i*12-11:i*12)));
    if(angle_OH(i)<0)
        angle_OH(i) = angle_OH(i) + 360;
    end
end
plot(angle_OH,"-o")
