clear
dx=1.0; dt=1.0;  c2=1./3.;
w=[1/9 1/9 1/9 1/9 1/36 1/36 1/36 1/36 4/9];
cx = [1 0 -1 0 1 -1 -1 1 0];
cy = [0 1 0 -1 1 1 -1 -1 0];
c=[cx;cy]';
opp = [3, 4, 1, 2, 7, 8, 5, 6, 9];
arf0=1.0;
%输入参数————————————————————————————
H=50;
N=2;
way=2;
Dd=N*H;
nx=40*Dd;
ny=30*Dd;
Re=20;
Pr=0.715;
Bgs=100;   %固体与气体热扩散系数 Bsg=DT_s/DT_g
por=0.6;
Sc=1;
Da=1;
Vmave=1;
Dt=1;
nx1=nx/N;
ny1=ny/N;
lx=nx1/4+1;
ly=ny1/2+1;
nx0=lx-H/2;
ny0=ly-H/2;
[y,x]=meshgrid(1:ny1,1:nx1);
obst1=(x-lx).^2 + (y-ly).^2 < (Dd/2).^2;
if way==2
    obst2=zeros(nx1,ny1);
    num=10;
    lxx=H/num;
    Dp=round((lxx^2*(1-por))^0.5);
    for numx=1:num
        for numy=1:num
            obst2(nx0+round((numx-0.5)*lxx-Dp/2):nx0+round((numx-0.5)*lxx+Dp/2),ny0+round((numy-0.5)*lxx-Dp/2):ny0+round((numy-0.5)*lxx+Dp/2))=1;
        end
    end
end
obst=obst1&obst2;
porYan=1-sum(obst(:))/sum(obst1(:));