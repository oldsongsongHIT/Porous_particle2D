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
%%Way 1: å®å¨éæºï¼?
if way==1
    obst2=rand(nx1,ny1,1)>por;
end
%%Way 2ï¼è§åå¸ç½?
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
    num_c=sum(obst1(:));  %åå½¢åï¼
    numtotal_need= por * num_c;   %å­éæ ¸å¿æ°ç®
    numMarpore=0;
    MM=round(nx1*ny1*cDr*2);
    Marpore=zeros(MM,2);
    for i=1: nx1 %ç¬?1æ­?, éåæ?æç½æ ?, çæå­éåæ ¸
        for j = 1:ny1
            if (i-lx)^2+(j-ly)^2<(Dr/2)^2
                if rand( ) < cDr %å¤æ­æ¯å¦ä¸ºçé¿æ ¸ï¼å¦ï¼?0,1ï¼éæºæ°å°äºçé¿æ ¸åå¸æ¦çcDrï¼åä¸ºçé¿æ ¸ï¼?
                    numMarpore= numMarpore+ 1;%å­éåæ ¸æ°ç®ï¼?
                    obst2(i,j) = 0;%æ è®°æ¹æ ¼å­ä¸ºåºä½ï¼?
                    Marpore(numMarpore,1) = i;%éæ°æ è®°å­éåæ ¸çæ¨ªçºµåæ ï¼
                    Marpore(numMarpore,2) = j;
                end % end if
            end
        end % end j
    end % end i
    TnumMarpore= numMarpore;
    % ç¬?2 æ­?, ä»å­éåæ ¸åå¨å´8 ä¸ªæ¹åçé?
    while TnumMarpore< numtotal_need %å¤è¯»æ¯å¦è¾¾å°é¢è®¾çå­éä»½é¢?
        for index_Marpore= 1: TnumMarpore
            index_i= Marpore(index_Marpore, 1);
            index_j= Marpore(index_Marpore, 2);
            % å­éåæ ¸åå³è¾¹çé?, å?1 ä¸­å³1 æ¹å
            if index_j< ny1 &&(index_i-lx)^2+(index_j-ly)^2<(Dr/2)^2
                i= index_i; j = index_j + 1; % right 1
                if (obst2( i, j )== 1 && rand( ) < d14)
                    numMarpore= numMarpore+ 1; obst2( i, j ) = 0;
                    Marpore( numMarpore, 1) = i; Marpore(numMarpore, 2) = j;
                end
            end %index_j
            % å­éåæ ¸åä¸è¾¹çé?, å?1 ä¸­å³2 æ¹å
            if index_i> 1 &&(index_i-lx)^2+(index_j-ly)^2<(Dr/2)^2
                i= index_i-1; j = index_j; % 2
                if (obst2( i, j )== 1 && rand( ) < d14)
                    numMarpore= numMarpore+ 1; obst2( i, j ) = 0;
                    Marpore( numMarpore, 1) = i; Marpore(numMarpore, 2) = j;
                end
            end %index_j
            % å­éåæ ¸åå·¦è¾¹çé?, å?1 ä¸­å³3 æ¹å
            if index_j> 1  &&(index_i-lx)^2+(index_j-ly)^2<(Dr/2)^2
                i= index_i; j = index_j-1; % 3
                if (obst2( i, j )== 1 && rand( ) < d14)
                    numMarpore= numMarpore+ 1; obst2( i, j ) = 0;
                    Marpore( numMarpore, 1) = i; Marpore(numMarpore, 2) = j;
                end
            end %index_j
            % å­éåæ ¸åä¸è¾¹çé?, å?1 ä¸­å³4 æ¹å
            if index_i< nx1  &&(index_i-lx)^2+(index_j-ly)^2<(Dr/2)^2
                i= index_i+1; j = index_j; % 4
                if (obst2( i, j )== 1 && rand( ) < d14)
                    numMarpore= numMarpore+ 1; obst2( i, j ) = 0;
                    Marpore( numMarpore, 1) = i; Marpore(numMarpore, 2) = j;
                end
            end %index_j
            % å­éåæ ¸åå³ä¸è¾¹çé¿, å?1 ä¸­å³5 æ¹å
            if index_j< ny1 && index_i>1  &&(index_i-lx)^2+(index_j-ly)^2<(Dr/2)^2
                i= index_i-1; j = index_j+1; % 5
                if (obst2( i, j )== 1 && rand( ) < d58)
                    numMarpore= numMarpore+ 1; obst2( i, j ) = 0;
                    Marpore( numMarpore, 1) = i; Marpore(numMarpore, 2) = j;
                end
            end %index_j
            % å­éåæ ¸åå·¦ä¸è¾¹çé¿, å?1 ä¸­å³6 æ¹å
            if index_j>1 && index_i>1  &&(index_i-lx)^2+(index_j-ly)^2<(Dr/2)^2
                i= index_i-1; j = index_j-1; % 6
                if (obst2( i, j )== 1 && rand( ) < d58)
                    numMarpore= numMarpore+ 1; obst2( i, j ) = 0;
                    Marpore( numMarpore, 1) = i; Marpore(numMarpore, 2) = j;
                end
            end %index_j
            % å­éåæ ¸åå·¦ä¸è¾¹çé¿, å?1 ä¸­å³7 æ¹å
            if index_j>1 && index_i< nx1  &&(index_i-lx)^2+(index_j-ly)^2<(Dr/2)^2
                i= index_i+1; j = index_j-1; % 7
                if (obst2( i, j )== 1 && rand( ) < d58)
                    numMarpore= numMarpore+ 1; obst2( i, j ) = 0;
                    Marpore( numMarpore, 1) = i; Marpore(numMarpore, 2) = j;
                end
            end %index_j
            % å­éåæ ¸åå³ä¸è¾¹çé¿, å?1 ä¸­å³8 æ¹å
            if index_j< ny1 && index_i< nx1  &&(index_i-lx)^2+(index_j-ly)^2<(Dr/2)^2
                i= index_i+1; j = index_j+1; % 5
                if (obst2( i, j )== 1 && rand( ) < d58)
                    numMarpore= numMarpore+ 1; obst2( i, j ) = 0;
                    Marpore( numMarpore, 1) = i; Marpore(numMarpore, 2) = j;
                end
            end %index_j
        end % index _Marpore, å¾ªç¯ç»æ
        TnumMarpore=numMarpore;
    end %end while, ç¬?2 æ­¥ç»æ?
end
obst=obst1&obst2;
porYan=1-sum(obst(:))/sum(obst1(:));
%ç½æ ¼æ©å±ï¼?
obstN=zeros(nx,ny);
[line,row]=find(obst==1);
for i=1:N
    for j=1:N
        obstN(N*line(:)-i+1,N*row(:)-j+1)=obst(line(:),row(:));
    end
end
imshow(rot90(1-obstN));
end
