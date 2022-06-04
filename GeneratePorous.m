function [obstN]=GeneratePorous(Dd,N,por,way,nx,ny)
nx1=nx/N;
ny1=ny/N;
lx=nx1/4+1;
ly=ny1/2+1;
%zuoxiaojiao
nx0=lx-Dd/2;
ny0=ly-Dd/2;
[y,x]=meshgrid(1:ny1,1:nx1);
obst1=(x-lx).^2 + (y-ly).^2 < (Dd/2).^2;
%%Way 1: 完全随机�?
if way==1
    obst2=rand(nx1,ny1,1)>por;
end
%%Way 2：规则布�?
if way==2
    obst2=zeros(nx1,ny1);
    num=10;
    lxx=Dd/num;
    Dp=round((lxx^2*(1-por))^0.5);
    for numx=1:num
        for numy=1:num
            obst2(nx0+round((numx-0.5)*lxx-Dp/2):nx0+round((numx-0.5)*lxx+Dp/2),ny0+round((numy-0.5)*lxx-Dp/2):ny0+round((numy-0.5)*lxx+Dp/2))=1;
        end
    end
end
if way==4
    d_Mar=4;
    cDr=4*por/pi/d_Mar^2;
    d14=0.1;
    d58=0.25*d14;
    obst2=ones(nx1,ny1);
    num_c=sum(obst1(:));  %圆形内！
    numtotal_need= por * num_c;   %孔隙核心数目
    numMarpore=0;
    MM=round(nx1*ny1*cDr*2);
    Marpore=zeros(MM,2);
    for i=1: nx1 %�?1�?, 遍历�?有网�?, 生成孔隙内核
        for j = 1:ny1
            if (i-lx)^2+(j-ly)^2<(Dr/2)^2
                if rand( ) < cDr %判断是否为生长核，如�?0,1）随机数小于生长核分布概率cDr，则为生长核�?
                    numMarpore= numMarpore+ 1;%孔隙内核数目�?
                    obst2(i,j) = 0;%标记改格子为固体�?
                    Marpore(numMarpore,1) = i;%重新标记孔隙内核的横纵坐标？
                    Marpore(numMarpore,2) = j;
                end % end if
            end
        end % end j
    end % end i
    TnumMarpore= numMarpore;
    % �?2 �?, 从孔隙内核向周围8 个方向生�?
    while TnumMarpore< numtotal_need %判读是否达到预设的孔隙份�?
        for index_Marpore= 1: TnumMarpore
            index_i= Marpore(index_Marpore, 1);
            index_j= Marpore(index_Marpore, 2);
            % 孔隙内核向右边生�?, �?1 中右1 方向
            if index_j< ny1 &&(index_i-lx)^2+(index_j-ly)^2<(Dr/2)^2
                i= index_i; j = index_j + 1; % right 1
                if (obst2( i, j )== 1 && rand( ) < d14)
                    numMarpore= numMarpore+ 1; obst2( i, j ) = 0;
                    Marpore( numMarpore, 1) = i; Marpore(numMarpore, 2) = j;
                end
            end %index_j
            % 孔隙内核向上边生�?, �?1 中右2 方向
            if index_i> 1 &&(index_i-lx)^2+(index_j-ly)^2<(Dr/2)^2
                i= index_i-1; j = index_j; % 2
                if (obst2( i, j )== 1 && rand( ) < d14)
                    numMarpore= numMarpore+ 1; obst2( i, j ) = 0;
                    Marpore( numMarpore, 1) = i; Marpore(numMarpore, 2) = j;
                end
            end %index_j
            % 孔隙内核向左边生�?, �?1 中右3 方向
            if index_j> 1  &&(index_i-lx)^2+(index_j-ly)^2<(Dr/2)^2
                i= index_i; j = index_j-1; % 3
                if (obst2( i, j )== 1 && rand( ) < d14)
                    numMarpore= numMarpore+ 1; obst2( i, j ) = 0;
                    Marpore( numMarpore, 1) = i; Marpore(numMarpore, 2) = j;
                end
            end %index_j
            % 孔隙内核向下边生�?, �?1 中右4 方向
            if index_i< nx1  &&(index_i-lx)^2+(index_j-ly)^2<(Dr/2)^2
                i= index_i+1; j = index_j; % 4
                if (obst2( i, j )== 1 && rand( ) < d14)
                    numMarpore= numMarpore+ 1; obst2( i, j ) = 0;
                    Marpore( numMarpore, 1) = i; Marpore(numMarpore, 2) = j;
                end
            end %index_j
            % 孔隙内核向右上边生长, �?1 中右5 方向
            if index_j< ny1 && index_i>1  &&(index_i-lx)^2+(index_j-ly)^2<(Dr/2)^2
                i= index_i-1; j = index_j+1; % 5
                if (obst2( i, j )== 1 && rand( ) < d58)
                    numMarpore= numMarpore+ 1; obst2( i, j ) = 0;
                    Marpore( numMarpore, 1) = i; Marpore(numMarpore, 2) = j;
                end
            end %index_j
            % 孔隙内核向左上边生长, �?1 中右6 方向
            if index_j>1 && index_i>1  &&(index_i-lx)^2+(index_j-ly)^2<(Dr/2)^2
                i= index_i-1; j = index_j-1; % 6
                if (obst2( i, j )== 1 && rand( ) < d58)
                    numMarpore= numMarpore+ 1; obst2( i, j ) = 0;
                    Marpore( numMarpore, 1) = i; Marpore(numMarpore, 2) = j;
                end
            end %index_j
            % 孔隙内核向左下边生长, �?1 中右7 方向
            if index_j>1 && index_i< nx1  &&(index_i-lx)^2+(index_j-ly)^2<(Dr/2)^2
                i= index_i+1; j = index_j-1; % 7
                if (obst2( i, j )== 1 && rand( ) < d58)
                    numMarpore= numMarpore+ 1; obst2( i, j ) = 0;
                    Marpore( numMarpore, 1) = i; Marpore(numMarpore, 2) = j;
                end
            end %index_j
            % 孔隙内核向右下边生长, �?1 中右8 方向
            if index_j< ny1 && index_i< nx1  &&(index_i-lx)^2+(index_j-ly)^2<(Dr/2)^2
                i= index_i+1; j = index_j+1; % 5
                if (obst2( i, j )== 1 && rand( ) < d58)
                    numMarpore= numMarpore+ 1; obst2( i, j ) = 0;
                    Marpore( numMarpore, 1) = i; Marpore(numMarpore, 2) = j;
                end
            end %index_j
        end % index _Marpore, 循环结束
        TnumMarpore=numMarpore;
    end %end while, �?2 步结�?
end
obst=obst1&obst2;
porYan=1-sum(obst(:))/sum(obst1(:));
%网格扩展�?
obstN=zeros(nx,ny);
[line,row]=find(obst==1);
for i=1:N
    for j=1:N
        obstN(N*line(:)-i+1,N*row(:)-j+1)=obst(line(:),row(:));
    end
end
imshow(rot90(1-obstN));
end
