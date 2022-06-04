clc;
clear; 
por=0.6;
nx=22;
ny=22;
Dp=20;
N=11;
[y,x] = meshgrid(1:ny,1:nx);
lx=nx/2+0.5;
ly=ny/2+0.5;
obst1 = (x-lx).^2 + (y-ly).^2 < (Dp/2).^2;
obst1=obst1+0;
[y1,x1] = meshgrid(1:N*ny,1:N*nx);
obst2=(x1-N*nx/2-0.5).^2 + (y1-N*ny/2-0.5).^2 < (N*Dp/2).^2;
obst3=(x1-N*nx/2-0.5).^2 + (y1-N*ny/2-0.5).^2 < (N*Dp/2+1).^2;
obst4=obst3-obst2;
[line,row]=find(obst1==1);
obstN=zeros(nx*N,ny*N); 
% for dis=1:N
% for k=1:size(line)
%     obstN(round(N*line(k)-N/2-dis)+1:round(N*line(k)-N/2+dis),round(N*row(k)-N/2-dis)+1:round(N*row(k)-N/2+dis))=1;
% end
% porYan=sum(obstN(:))/sum(obst2(:));
% if porYan>(1-por)*0.98
%     break
% end
% end
dis=0.5*N*(1-por)^0.5;
for k=1:size(line)
    obstN(round(N*line(k)-N/2-dis)+1:round(N*line(k)-N/2+dis),round(N*row(k)-N/2-dis)+1:round(N*row(k)-N/2+dis))=1;
end
porYan1=1-sum(obstN(:))/sum(obst2(:));
porYan2=1-sum(obstN(:))/sum(obst3(:));
Hs=round(2*dis);
Hp=N-Hs;
obst=obstN+obst4;
imshow(rot90(1-obstN));

