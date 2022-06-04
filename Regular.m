clc; clear
tic
H=200;
por=0.6;
way=4;
N=2;
nx1=H; ny1=H;
nx=N*nx1; ny=N*ny1;
Dr=H-4;
lx=H/2+1; ly=H/2+1;
%obst=zeros(nx,ny);
[y,x]=meshgrid(1:ny1,1:nx1);
obst1=(x-lx).^2 + (y-ly).^2 < (Dr/2).^2;
%%Way 1: 瀹屽叏闅忔満锛?
if way==1
    obst2=rand(nx1,ny1,1)>por;
end
%%Way 2锛氳鍒欏竷缃?
if way==2
    obst2=zeros(nx1,ny1);
    num=20;
    lx=nx1/num;
    Dp=round((lx^2*(1-por))^0.5);
    for numx=1:num
        for numy=1:num
            obst2(round((numx-0.5)*lx-Dp/2)+2:round((numx-0.5)*lx+Dp/2),round((numy-0.5)*lx-Dp/2)+2:round((numy-0.5)*lx+Dp/2))=1;
        end
    end
end
%%Way 3锛氶殢鏈哄弬鏁版瀯閫?
if way==3
    d_Mar=4;
    cDr=4*por/pi/d_Mar^2;
    d14=1;
    d58=0.25*d14;
    obst2=zeros(nx1,ny1);
    num_c=sum(obst1(:));  %鍦嗗舰鍐咃紒
    numtotal_need= (1-por) * num_c;   %鍥轰綋鏍稿績鏁扮洰
    numMarpore=0;
    MM=round(nx1*ny1*cDr*2);
    Marpore=zeros(MM,2);
    for i=1: nx1 %绗?1姝?, 閬嶅巻鎵�鏈夌綉鏍?, 鐢熸垚瀛旈殭鍐呮牳
        for j = 1:ny1
            if (i-lx)^2+(j-ly)^2<(Dr/2)^2
                if rand( ) < cDr %鍒ゆ柇鏄惁涓虹敓闀挎牳锛屽锛?0,1锛夐殢鏈烘暟灏忎簬鐢熼暱鏍稿垎甯冩鐜嘽Dr锛屽垯涓虹敓闀挎牳锛?
                    numMarpore= numMarpore+ 1;%瀛旈殭鍐呮牳鏁扮洰锛?
                    obst2(i,j) = 1;%鏍囪鏀规牸瀛愪负鍥轰綋锛?
                    Marpore(numMarpore,1) = i;%閲嶆柊鏍囪瀛旈殭鍐呮牳鐨勬í绾靛潗鏍囷紵
                    Marpore(numMarpore,2) = j;
                end % end if
            end
        end % end j
    end % end i
    TnumMarpore= numMarpore;
    % 绗?2 姝?, 浠庡瓟闅欏唴鏍稿悜鍛ㄥ洿8 涓柟鍚戠敓闀?
    while TnumMarpore< numtotal_need %鍒よ鏄惁杈惧埌棰勮鐨勫瓟闅欎唤棰?
        for index_Marpore= 1: TnumMarpore
            index_i= Marpore(index_Marpore, 1);
            index_j= Marpore(index_Marpore, 2);
            % 瀛旈殭鍐呮牳鍚戝彸杈圭敓闀?, 鍥?1 涓彸1 鏂瑰悜
            if index_j< ny1 &&(index_i-lx)^2+(index_j-ly)^2<(Dr/2)^2
                i= index_i; j = index_j + 1; % right 1
                if (obst2( i, j )== 0 && rand( ) < d14)
                    numMarpore= numMarpore+ 1; obst2( i, j ) = 1;
                    Marpore( numMarpore, 1) = i; Marpore(numMarpore, 2) = j;
                end
            end %index_j
            % 瀛旈殭鍐呮牳鍚戜笂杈圭敓闀?, 鍥?1 涓彸2 鏂瑰悜
            if index_i> 1 &&(index_i-lx)^2+(index_j-ly)^2<(Dr/2)^2
                i= index_i-1; j = index_j; % 2
                if (obst2( i, j )== 0 && rand( ) < d14)
                    numMarpore= numMarpore+ 1; obst2( i, j ) = 1;
                    Marpore( numMarpore, 1) = i; Marpore(numMarpore, 2) = j;
                end
            end %index_j
            % 瀛旈殭鍐呮牳鍚戝乏杈圭敓闀?, 鍥?1 涓彸3 鏂瑰悜
            if index_j> 1  &&(index_i-lx)^2+(index_j-ly)^2<(Dr/2)^2
                i= index_i; j = index_j-1; % 3
                if (obst2( i, j )== 0 && rand( ) < d14)
                    numMarpore= numMarpore+ 1; obst2( i, j ) = 1;
                    Marpore( numMarpore, 1) = i; Marpore(numMarpore, 2) = j;
                end
            end %index_j
            % 瀛旈殭鍐呮牳鍚戜笅杈圭敓闀?, 鍥?1 涓彸4 鏂瑰悜
            if index_i< nx1  &&(index_i-lx)^2+(index_j-ly)^2<(Dr/2)^2
                i= index_i+1; j = index_j; % 4
                if (obst2( i, j )== 0 && rand( ) < d14)
                    numMarpore= numMarpore+ 1; obst2( i, j ) = 1;
                    Marpore( numMarpore, 1) = i; Marpore(numMarpore, 2) = j;
                end
            end %index_j
            % 瀛旈殭鍐呮牳鍚戝彸涓婅竟鐢熼暱, 鍥?1 涓彸5 鏂瑰悜
            if index_j< ny1 && index_i>1  &&(index_i-lx)^2+(index_j-ly)^2<(Dr/2)^2
                i= index_i-1; j = index_j+1; % 5
                if (obst2( i, j )== 0 && rand( ) < d58)
                    numMarpore= numMarpore+ 1; obst2( i, j ) = 1;
                    Marpore( numMarpore, 1) = i; Marpore(numMarpore, 2) = j;
                end
            end %index_j
            % 瀛旈殭鍐呮牳鍚戝乏涓婅竟鐢熼暱, 鍥?1 涓彸6 鏂瑰悜
            if index_j>1 && index_i>1  &&(index_i-lx)^2+(index_j-ly)^2<(Dr/2)^2
                i= index_i-1; j = index_j-1; % 6
                if (obst2( i, j )== 0 && rand( ) < d58)
                    numMarpore= numMarpore+ 1; obst2( i, j ) = 1;
                    Marpore( numMarpore, 1) = i; Marpore(numMarpore, 2) = j;
                end
            end %index_j
            % 瀛旈殭鍐呮牳鍚戝乏涓嬭竟鐢熼暱, 鍥?1 涓彸7 鏂瑰悜
            if index_j>1 && index_i< nx1  &&(index_i-lx)^2+(index_j-ly)^2<(Dr/2)^2
                i= index_i+1; j = index_j-1; % 7
                if (obst2( i, j )== 0 && rand( ) < d58)
                    numMarpore= numMarpore+ 1; obst2( i, j ) = 1;
                    Marpore( numMarpore, 1) = i; Marpore(numMarpore, 2) = j;
                end
            end %index_j
            % 瀛旈殭鍐呮牳鍚戝彸涓嬭竟鐢熼暱, 鍥?1 涓彸8 鏂瑰悜
            if index_j< ny1 && index_i< nx1  &&(index_i-lx)^2+(index_j-ly)^2<(Dr/2)^2
                i= index_i+1; j = index_j+1; % 5
                if (obst2( i, j )== 0 && rand( ) < d58)
                    numMarpore= numMarpore+ 1; obst2( i, j ) = 1;
                    Marpore( numMarpore, 1) = i; Marpore(numMarpore, 2) = j;
                end
            end %index_j
        end % index _Marpore, 寰幆缁撴潫
        TnumMarpore=numMarpore;
    end %end while, 绗?2 姝ョ粨鏉?
end
if way==4
    d_Mar=4;
    cDr=4*por/pi/d_Mar^2;
    d14=0.1;
    d58=0.25*d14;
    obst2=ones(nx1,ny1);
    num_c=sum(obst1(:));  %鍦嗗舰鍐咃紒
    numtotal_need= por * num_c;   %瀛旈殭鏍稿績鏁扮洰
    numMarpore=0;
    MM=round(nx1*ny1*cDr*2);
    Marpore=zeros(MM,2);
    for i=1: nx1 %绗?1姝?, 閬嶅巻鎵�鏈夌綉鏍?, 鐢熸垚瀛旈殭鍐呮牳
        for j = 1:ny1
            if (i-lx)^2+(j-ly)^2<(Dr/2)^2
                if rand( ) < cDr %鍒ゆ柇鏄惁涓虹敓闀挎牳锛屽锛?0,1锛夐殢鏈烘暟灏忎簬鐢熼暱鏍稿垎甯冩鐜嘽Dr锛屽垯涓虹敓闀挎牳锛?
                    numMarpore= numMarpore+ 1;%瀛旈殭鍐呮牳鏁扮洰锛?
                    obst2(i,j) = 0;%鏍囪鏀规牸瀛愪负鍥轰綋锛?
                    Marpore(numMarpore,1) = i;%閲嶆柊鏍囪瀛旈殭鍐呮牳鐨勬í绾靛潗鏍囷紵
                    Marpore(numMarpore,2) = j;
                end % end if
            end
        end % end j
    end % end i
    TnumMarpore= numMarpore;
    % 绗?2 姝?, 浠庡瓟闅欏唴鏍稿悜鍛ㄥ洿8 涓柟鍚戠敓闀?
    while TnumMarpore< numtotal_need %鍒よ鏄惁杈惧埌棰勮鐨勫瓟闅欎唤棰?
        for index_Marpore= 1: TnumMarpore
            index_i= Marpore(index_Marpore, 1);
            index_j= Marpore(index_Marpore, 2);
            % 瀛旈殭鍐呮牳鍚戝彸杈圭敓闀?, 鍥?1 涓彸1 鏂瑰悜
            if index_j< ny1 &&(index_i-lx)^2+(index_j-ly)^2<(Dr/2)^2
                i= index_i; j = index_j + 1; % right 1
                if (obst2( i, j )== 1 && rand( ) < d14)
                    numMarpore= numMarpore+ 1; obst2( i, j ) = 0;
                    Marpore( numMarpore, 1) = i; Marpore(numMarpore, 2) = j;
                end
            end %index_j
            % 瀛旈殭鍐呮牳鍚戜笂杈圭敓闀?, 鍥?1 涓彸2 鏂瑰悜
            if index_i> 1 &&(index_i-lx)^2+(index_j-ly)^2<(Dr/2)^2
                i= index_i-1; j = index_j; % 2
                if (obst2( i, j )== 1 && rand( ) < d14)
                    numMarpore= numMarpore+ 1; obst2( i, j ) = 0;
                    Marpore( numMarpore, 1) = i; Marpore(numMarpore, 2) = j;
                end
            end %index_j
            % 瀛旈殭鍐呮牳鍚戝乏杈圭敓闀?, 鍥?1 涓彸3 鏂瑰悜
            if index_j> 1  &&(index_i-lx)^2+(index_j-ly)^2<(Dr/2)^2
                i= index_i; j = index_j-1; % 3
                if (obst2( i, j )== 1 && rand( ) < d14)
                    numMarpore= numMarpore+ 1; obst2( i, j ) = 0;
                    Marpore( numMarpore, 1) = i; Marpore(numMarpore, 2) = j;
                end
            end %index_j
            % 瀛旈殭鍐呮牳鍚戜笅杈圭敓闀?, 鍥?1 涓彸4 鏂瑰悜
            if index_i< nx1  &&(index_i-lx)^2+(index_j-ly)^2<(Dr/2)^2
                i= index_i+1; j = index_j; % 4
                if (obst2( i, j )== 1 && rand( ) < d14)
                    numMarpore= numMarpore+ 1; obst2( i, j ) = 0;
                    Marpore( numMarpore, 1) = i; Marpore(numMarpore, 2) = j;
                end
            end %index_j
            % 瀛旈殭鍐呮牳鍚戝彸涓婅竟鐢熼暱, 鍥?1 涓彸5 鏂瑰悜
            if index_j< ny1 && index_i>1  &&(index_i-lx)^2+(index_j-ly)^2<(Dr/2)^2
                i= index_i-1; j = index_j+1; % 5
                if (obst2( i, j )== 1 && rand( ) < d58)
                    numMarpore= numMarpore+ 1; obst2( i, j ) = 0;
                    Marpore( numMarpore, 1) = i; Marpore(numMarpore, 2) = j;
                end
            end %index_j
            % 瀛旈殭鍐呮牳鍚戝乏涓婅竟鐢熼暱, 鍥?1 涓彸6 鏂瑰悜
            if index_j>1 && index_i>1  &&(index_i-lx)^2+(index_j-ly)^2<(Dr/2)^2
                i= index_i-1; j = index_j-1; % 6
                if (obst2( i, j )== 1 && rand( ) < d58)
                    numMarpore= numMarpore+ 1; obst2( i, j ) = 0;
                    Marpore( numMarpore, 1) = i; Marpore(numMarpore, 2) = j;
                end
            end %index_j
            % 瀛旈殭鍐呮牳鍚戝乏涓嬭竟鐢熼暱, 鍥?1 涓彸7 鏂瑰悜
            if index_j>1 && index_i< nx1  &&(index_i-lx)^2+(index_j-ly)^2<(Dr/2)^2
                i= index_i+1; j = index_j-1; % 7
                if (obst2( i, j )== 1 && rand( ) < d58)
                    numMarpore= numMarpore+ 1; obst2( i, j ) = 0;
                    Marpore( numMarpore, 1) = i; Marpore(numMarpore, 2) = j;
                end
            end %index_j
            % 瀛旈殭鍐呮牳鍚戝彸涓嬭竟鐢熼暱, 鍥?1 涓彸8 鏂瑰悜
            if index_j< ny1 && index_i< nx1  &&(index_i-lx)^2+(index_j-ly)^2<(Dr/2)^2
                i= index_i+1; j = index_j+1; % 5
                if (obst2( i, j )== 1 && rand( ) < d58)
                    numMarpore= numMarpore+ 1; obst2( i, j ) = 0;
                    Marpore( numMarpore, 1) = i; Marpore(numMarpore, 2) = j;
                end
            end %index_j
        end % index _Marpore, 寰幆缁撴潫
        TnumMarpore=numMarpore;
    end %end while, 绗?2 姝ョ粨鏉?
end
obst=obst1&obst2;
porYan=1-sum(obst(:))/sum(obst1(:));
%imshow(rot90(1-obst));
%bsthole=imfill(obst,'holes');
%% 缃戞牸鎵╁睍锛?
obstN=zeros(nx,ny);
[line,row]=find(obst==1);
for i=1:N
    for j=1:N
        obstN(N*line(:)-i+1,N*row(:)-j+1)=obst(line(:),row(:));
    end
end
toc
way
%imshow(rot90(1-obstN));