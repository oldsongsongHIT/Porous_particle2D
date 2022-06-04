%function [obst] = QSGS(nx,ny,por,d14,d58,cDr,N)
%UNTITLED �˴���ʾ�йش˺�����ժҪ
% d14; d58; %%����������ʣ����᷽��1-4�����᷽��5-8�������Ǹ���ͬ�ԡ��������ԣ�
% por;   %��϶��
% cDr;%�����˷ֲ����ʣ�ֵԽ�󣬹Ǽֲܷ�Խ���ȣ�Խ��ɢ��
clc; clear
nx=100; ny=100;
Dr=100;
Dx=nx/2; Dy=ny/2;
por=0.4;
por_Mar=0.2;
cDr=0.01;
d14=0.1;
d58=0.25*d14;
d_Mar=(4*por_Mar/pi/cDr)^0.5;
B_d=4;
%d_mes=round(d_Mar/B_d);
d_mes=2;
obst=zeros(nx,ny);
for i=1:nx
    for j=1:ny
        if (i-Dx)^2+(j-Dy)^2<=Dr^2
            obst(i,j)=1.0;
        end
    end
end
num_c=sum(obst(:));  %Բ���ڣ�
%obst=ones(nx,ny);
numtotal_need= por * num_c;
numtotal_need_Mar= por_Mar * num_c;
numMarpore=0;
MM=nx*ny*cDr*2;
Marpore=zeros(MM,2);
for i=1: nx %��1 ��, ������������, ���ɿ�϶�ں�
    for j = 1:ny
        if (i-Dx)^2+(j-Dy)^2<Dr^2
            if rand( ) < cDr %�ж��Ƿ�Ϊ�����ˣ��磨0,1�������С�������˷ֲ�����cDr����Ϊ�����ˣ�
                numMarpore= numMarpore+ 1;%��϶�ں���Ŀ��
                obst(i,j) = 0;%��Ǹĸ���Ϊ��϶��
                Marpore(numMarpore,1) = i;%���±�ǿ�϶�ں˵ĺ������ꣿ
                Marpore(numMarpore,2) = j;
            end % end if
        end
    end % end j
end % end i
TnumMarpore= numMarpore;
N_Marpore=numMarpore;
imshow(rot90(1-obst));
%%
% ��2 ��, �ӿ�϶�ں�����Χ8 ����������
while TnumMarpore< numtotal_need_Mar %�ж��Ƿ�ﵽԤ��Ŀ�϶�ݶ�
    for index_Marpore= 1: TnumMarpore
        index_i= Marpore(index_Marpore, 1);
        index_j= Marpore(index_Marpore, 2);
        % ��϶�ں����ұ�����, ͼ1 ����1 ����
        if index_j< ny &&(index_i-Dx)^2+(index_j-Dy)^2<=Dr^2
            i= index_i; j = index_j + 1; % right 1
            if (obst( i, j )== 1 && rand( ) < d14)
                numMarpore= numMarpore+ 1; obst( i, j ) = 0;
                Marpore( numMarpore, 1) = i; Marpore(numMarpore, 2) = j;
            end
        end %index_j
        % ��϶�ں����ϱ�����, ͼ1 ����2 ����
        if index_i> 1 &&(index_i-Dx)^2+(index_j-Dy)^2<=Dr^2
            i= index_i-1; j = index_j; % 2
            if (obst( i, j )== 1 && rand( ) < d14)
                numMarpore= numMarpore+ 1; obst( i, j ) = 0;
                Marpore( numMarpore, 1) = i; Marpore(numMarpore, 2) = j;
            end
        end %index_j
        % ��϶�ں����������, ͼ1 ����3 ����
        if index_j> 1  &&(index_i-Dx)^2+(index_j-Dy)^2<=Dr^2
            i= index_i; j = index_j-1; % 3
            if (obst( i, j )== 1 && rand( ) < d14)
                numMarpore= numMarpore+ 1; obst( i, j ) = 0;
                Marpore( numMarpore, 1) = i; Marpore(numMarpore, 2) = j;
            end
        end %index_j
        % ��϶�ں����±�����, ͼ1 ����4 ����
        if index_i< nx  &&(index_i-Dx)^2+(index_j-Dy)^2<=Dr^2
            i= index_i+1; j = index_j; % 4
            if (obst( i, j )== 1 && rand( ) < d14)
                numMarpore= numMarpore+ 1; obst( i, j ) = 0;
                Marpore( numMarpore, 1) = i; Marpore(numMarpore, 2) = j;
            end
        end %index_j
        
        % ��϶�ں������ϱ�����, ͼ1 ����5 ����
        if index_j< ny && index_i>1  &&(index_i-Dx)^2+(index_j-Dy)^2<=Dr^2
            i= index_i-1; j = index_j+1; % 5
            if (obst( i, j )== 1 && rand( ) < d58)
                numMarpore= numMarpore+ 1; obst( i, j ) = 0;
                Marpore( numMarpore, 1) = i; Marpore(numMarpore, 2) = j;
            end
        end %index_j
        % ��϶�ں������ϱ�����, ͼ1 ����6 ����
        if index_j>1 && index_i>1  &&(index_i-Dx)^2+(index_j-Dy)^2<=Dr^2
            i= index_i-1; j = index_j-1; % 6
            if (obst( i, j )== 1 && rand( ) < d58)
                numMarpore= numMarpore+ 1; obst( i, j ) = 0;
                Marpore( numMarpore, 1) = i; Marpore(numMarpore, 2) = j;
            end
        end %index_j
        % ��϶�ں������±�����, ͼ1 ����7 ����
        if index_j>1 && index_i< nx  &&(index_i-Dx)^2+(index_j-Dy)^2<=Dr^2
            i= index_i+1; j = index_j-1; % 7
            if (obst( i, j )== 1 && rand( ) < d58)
                numMarpore= numMarpore+ 1; obst( i, j ) = 0;
                Marpore( numMarpore, 1) = i; Marpore(numMarpore, 2) = j;
            end
        end %index_j
        % ��϶�ں������±�����, ͼ1 ����8 ����
        if index_j< ny && index_i< nx  &&(index_i-Dx)^2+(index_j-Dy)^2<=Dr^2
            i= index_i+1; j = index_j+1; % 5
            if (obst( i, j )== 1 && rand( ) < d58)
                numMarpore= numMarpore+ 1; obst( i, j ) = 0;
                Marpore( numMarpore, 1) = i; Marpore(numMarpore, 2) = j;
            end
        end %index_j
    end % index _Marpore, ѭ������
    TnumMarpore=numMarpore;
end %end while, ��2 ������
por0=1-sum(obst(:))/nx/ny;
imshow(rot90(1-obst));
%+++++++++++++++++++���ϴ�׹�����ϣ�+++++++++++++++++++++
%%
ind=zeros(1,N_Marpore);
dis=nx*ny*ones(N_Marpore,N_Marpore);
for num1=1:N_Marpore
    for num2=1:N_Marpore
        if num1~=num2
            vp=[(Marpore(num1,1)-Marpore(num2,1)),(Marpore(num1,2)-Marpore(num2,2))];
            dis(num1,num2)=norm(vp);
        end
    end
end
%%+++++++++++++++++���ϼ�����Ϊnum1�Ĵ�׺��ĺ�������num2�ľ���+++++++++++++++++++++++++
while (num_c-sum(obst(:)))<numtotal_need
    for num1=1:N_Marpore
        num1_dis=dis(num1,:);   
        [dis1,ind(num1)]=min(num1_dis);   %����ĺ��ĵ�2�ı��ind(num1)
        vp=[(Marpore(num1,1)-Marpore(ind(num1),1)),(Marpore(num1,2)-Marpore(ind(num1),2))];
        for i=1:nx
            for j=1:ny
                p1=[(i-Marpore(ind(num1),1)),(j-Marpore(ind(num1),2))];
                p2=[(i-Marpore(num1,1)),(j-Marpore(num1,2))];
                dis1=abs(det([vp;p1]))/norm(vp);
                dis2=norm(p1);  dis3=norm(p2);
                if obst(i,j)==1
                    if dis2<=d_mes||dis3<=d_mes
                        obst(i,j)=0.0;
                    elseif dis1<=d_mes&&i>=min([Marpore(num1,1),Marpore(ind(num1),1)])&&i<=max([Marpore(num1,1),Marpore(ind(num1),1)])&&j>=min([Marpore(num1,2),Marpore(ind(num1),2)])&&j<=max([Marpore(num1,2),Marpore(ind(num1),2)])
                        obst(i,j)=0.0;
                    end
                end
            end
        end
        dis(num1,ind(num1))=ny*ny;
        if (num_c-sum(obst(:)))>numtotal_need
            break
        end
    end  
end
obst=imfill(obst,'holes');
imshow(rot90(1-obst));  %��ʾ��ɫΪ��϶
por0=(num_c-sum(obst(:)))/num_c;
save obst.mat;
%end