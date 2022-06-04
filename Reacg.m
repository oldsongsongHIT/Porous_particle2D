function [g1,Rs]=Reacg(nx,ny,g1,g1pre,kr,rhog1,alphag1,Cs,w,solidf,Rs)
%表面反应函数，组分浓度
%简化反应：R->S+P;
%R=kr*(C_reac-C_s);
b1=alphag1; b2=kr;  b3=kr*Cs;
cw1=zeros(nx,ny,18);
d=[0.5,0.5,0.5,0.5,0.5*2^0.5,0.5*2^0.5,0.5*2^0.5,0.5*2^0.5,0,0,0.5,0.5,0.5,0.5,0.5*2^0.5,0.5*2^0.5,0.5*2^0.5,0.5*2^0.5];
[row,line]=find(solidf>=1);
for i=1:size(row)
    cw1(row(i),line(i),:)=(rhog1(row(i),line(i))+d*b3/b1)./(1.0+d*b2/b1);
%     cw2(row(i),line(i),:)=alphag1/alphag2*(rhog1(row(i),line(i))-cw1(row(i),line(i),:))+rhog2(row(i),line(i));
end
[row,line]=find(solidf==1);
for i=1:size(row)
    Rs(row(i)-1,line(i))=kr*(Cs-cw1(row(i),line(i),1));
    g1(row(i),line(i),1)=(w(1)+w(3))*cw1(row(i),line(i),1)-g1pre(row(i),line(i),3);
    g1(row(i),line(i),8)=(w(6)+w(8))*cw1(row(i),line(i),1)-g1pre(row(i),line(i),6);
    g1(row(i),line(i),5)=(w(5)+w(7))*cw1(row(i),line(i),1)-g1pre(row(i),line(i),7);
%     g2(row(i),line(i),1)=(w(1)+w(3))*cw2(row(i),line(i),1)-g2pre(row(i),line(i),3);
%     g2(row(i),line(i),8)=(w(6)+w(8))*cw2(row(i),line(i),1)-g2pre(row(i),line(i),6);
%     g2(row(i),line(i),5)=(w(5)+w(7))*cw2(row(i),line(i),1)-g2pre(row(i),line(i),7);
end
[row,line]=find(solidf==2);
for i=1:size(row)
    Rs(row(i),line(i)-1)=kr*(Cs-cw1(row(i),line(i),2));
    g1(row(i),line(i),2)=(w(2)+w(4))*cw1(row(i),line(i),2)-g1pre(row(i),line(i),4);
    g1(row(i),line(i),5)=(w(5)+w(7))*cw1(row(i),line(i),2)-g1pre(row(i),line(i),7);
    g1(row(i),line(i),6)=(w(6)+w(8))*cw1(row(i),line(i),2)-g1pre(row(i),line(i),8);
%     g2(row(i),line(i),2)=(w(2)+w(4))*cw2(row(i),line(i),2)-g2pre(row(i),line(i),4);
%     g2(row(i),line(i),5)=(w(5)+w(7))*cw2(row(i),line(i),2)-g2pre(row(i),line(i),7);
%     g2(row(i),line(i),6)=(w(6)+w(8))*cw2(row(i),line(i),2)-g2pre(row(i),line(i),8);
end
[row,line]=find(solidf==3);
for i=1:size(row)
    Rs(row(i)+1,line(i))=kr*(Cs-cw1(row(i),line(i),3));
    g1(row(i),line(i),3)=(w(1)+w(3))*cw1(row(i),line(i),3)-g1pre(row(i),line(i),1);
    g1(row(i),line(i),6)=(w(6)+w(8))*cw1(row(i),line(i),3)-g1pre(row(i),line(i),8);
    g1(row(i),line(i),7)=(w(5)+w(7))*cw1(row(i),line(i),3)-g1pre(row(i),line(i),5);
%     g2(row(i),line(i),3)=(w(1)+w(3))*cw2(row(i),line(i),3)-g2pre(row(i),line(i),1);
%     g2(row(i),line(i),6)=(w(6)+w(8))*cw2(row(i),line(i),3)-g2pre(row(i),line(i),8);
%     g2(row(i),line(i),7)=(w(5)+w(7))*cw2(row(i),line(i),3)-g2pre(row(i),line(i),5);
end
[row,line]=find(solidf==4);
for i=1:size(row)
    Rs(row(i),line(i)+1)=kr*(Cs-cw1(row(i),line(i),4));
    g1(row(i),line(i),4)=(w(2)+w(4))*cw1(row(i),line(i),4)-g1pre(row(i),line(i),2);
    g1(row(i),line(i),7)=(w(5)+w(7))*cw1(row(i),line(i),4)-g1pre(row(i),line(i),5);
    g1(row(i),line(i),8)=(w(6)+w(8))*cw1(row(i),line(i),4)-g1pre(row(i),line(i),6);
%     g2(row(i),line(i),4)=(w(2)+w(4))*cw2(row(i),line(i),4)-g2pre(row(i),line(i),2);
%     g2(row(i),line(i),7)=(w(5)+w(7))*cw2(row(i),line(i),4)-g2pre(row(i),line(i),5);
%     g2(row(i),line(i),8)=(w(6)+w(8))*cw2(row(i),line(i),4)-g2pre(row(i),line(i),6);
end
[row,line]=find(solidf==5);
for i=1:size(row)
    Rs(row(i)-1,line(i)-1)=kr*(Cs-cw1(row(i),line(i),5));
    g1(row(i),line(i),5)=(w(5)+w(7))*cw1(row(i),line(i),5)-g1pre(row(i),line(i),7);
%     g2(row(i),line(i),5)=(w(5)+w(7))*cw2(row(i),line(i),5)-g2pre(row(i),line(i),7);
end
[row,line]=find(solidf==6);
for i=1:size(row)
    Rs(row(i)+1,line(i)-1)=kr*(Cs-cw1(row(i),line(i),6));
    g1(row(i),line(i),6)=(w(6)+w(8))*cw1(row(i),line(i),6)-g1pre(row(i),line(i),8);
%     g2(row(i),line(i),6)=(w(6)+w(8))*cw2(row(i),line(i),6)-g2pre(row(i),line(i),8);
end
[row,line]=find(solidf==7);
for i=1:size(row)
    Rs(row(i)+1,line(i)+1)=kr*(Cs-cw1(row(i),line(i),7));
    g1(row(i),line(i),7)=(w(5)+w(7))*cw1(row(i),line(i),7)-g1pre(row(i),line(i),5);
%     g2(row(i),line(i),7)=(w(5)+w(7))*cw2(row(i),line(i),7)-g2pre(row(i),line(i),5);
end
[row,line]=find(solidf==8);
for i=1:size(row)
    Rs(row(i)-1,line(i)+1)=kr*(Cs-cw1(row(i),line(i),8));
    g1(row(i),line(i),8)=(w(6)+w(8))*cw1(row(i),line(i),8)-g1pre(row(i),line(i),6);
%     g2(row(i),line(i),8)=(w(6)+w(8))*cw2(row(i),line(i),8)-g2pre(row(i),line(i),6);
end
[row,line]=find(solidf==11);
for i=1:size(row)
    Rs(row(i)-1,line(i))=kr*(Cs-cw1(row(i),line(i),11));
    g1(row(i),line(i),1)=(w(1)+w(3))*cw1(row(i),line(i),11)-g1pre(row(i),line(i),3);
    g1(row(i),line(i),8)=(w(6)+w(8))*cw1(row(i),line(i),11)-g1pre(row(i),line(i),6);
    g1(row(i),line(i),5)=(w(5)+w(7))*cw1(row(i),line(i),11)-g1pre(row(i),line(i),7);
    g1(row(i),line(i),2)=(w(2)+w(4))*cw1(row(i),line(i),11)-g1pre(row(i),line(i),4);
    g1(row(i),line(i),4)=(w(2)+w(4))*cw1(row(i),line(i),11)-g1pre(row(i),line(i),2);
%     g2(row(i),line(i),1)=(w(1)+w(3))*cw2(row(i),line(i),11)-g2pre(row(i),line(i),3);
%     g2(row(i),line(i),8)=(w(6)+w(8))*cw2(row(i),line(i),11)-g2pre(row(i),line(i),6);
%     g2(row(i),line(i),5)=(w(5)+w(7))*cw2(row(i),line(i),11)-g2pre(row(i),line(i),7);
%     g2(row(i),line(i),2)=(w(2)+w(4))*cw2(row(i),line(i),11)-g2pre(row(i),line(i),4);
%     g2(row(i),line(i),4)=(w(2)+w(4))*cw2(row(i),line(i),11)-g2pre(row(i),line(i),2);
end
[row,line]=find(solidf==12);
for i=1:size(row)
    Rs(row(i),line(i)-1)=kr*(Cs-cw1(row(i),line(i),12));
    g1(row(i),line(i),2)=(w(2)+w(4))*cw1(row(i),line(i),12)-g1pre(row(i),line(i),4);
    g1(row(i),line(i),5)=(w(5)+w(7))*cw1(row(i),line(i),12)-g1pre(row(i),line(i),7);
    g1(row(i),line(i),6)=(w(6)+w(8))*cw1(row(i),line(i),12)-g1pre(row(i),line(i),8);
    g1(row(i),line(i),1)=(w(1)+w(3))*cw1(row(i),line(i),12)-g1pre(row(i),line(i),3);
    g1(row(i),line(i),3)=(w(1)+w(3))*cw1(row(i),line(i),12)-g1pre(row(i),line(i),1);
%     g2(row(i),line(i),2)=(w(2)+w(4))*cw2(row(i),line(i),12)-g2pre(row(i),line(i),4);
%     g2(row(i),line(i),5)=(w(5)+w(7))*cw2(row(i),line(i),12)-g2pre(row(i),line(i),7);
%     g2(row(i),line(i),6)=(w(6)+w(8))*cw2(row(i),line(i),12)-g2pre(row(i),line(i),8);
%     g2(row(i),line(i),1)=(w(1)+w(3))*cw2(row(i),line(i),12)-g2pre(row(i),line(i),3);
%     g2(row(i),line(i),3)=(w(1)+w(3))*cw2(row(i),line(i),12)-g2pre(row(i),line(i),1);
end
[row,line]=find(solidf==13);
for i=1:size(row)
    Rs(row(i)+1,line(i))=kr*(Cs-cw1(row(i),line(i),13));
    g1(row(i),line(i),3)=(w(1)+w(3))*cw1(row(i),line(i),13)-g1pre(row(i),line(i),1);
    g1(row(i),line(i),6)=(w(6)+w(8))*cw1(row(i),line(i),13)-g1pre(row(i),line(i),8);
    g1(row(i),line(i),7)=(w(5)+w(7))*cw1(row(i),line(i),13)-g1pre(row(i),line(i),5);
    g1(row(i),line(i),2)=(w(2)+w(4))*cw1(row(i),line(i),13)-g1pre(row(i),line(i),4);
    g1(row(i),line(i),4)=(w(2)+w(4))*cw1(row(i),line(i),13)-g1pre(row(i),line(i),2);
%     g2(row(i),line(i),3)=(w(1)+w(3))*cw2(row(i),line(i),13)-g2pre(row(i),line(i),1);
%     g2(row(i),line(i),6)=(w(6)+w(8))*cw2(row(i),line(i),13)-g2pre(row(i),line(i),8);
%     g2(row(i),line(i),7)=(w(5)+w(7))*cw2(row(i),line(i),13)-g2pre(row(i),line(i),5);
%     g2(row(i),line(i),2)=(w(2)+w(4))*cw2(row(i),line(i),13)-g2pre(row(i),line(i),4);
%     g2(row(i),line(i),4)=(w(2)+w(4))*cw2(row(i),line(i),13)-g2pre(row(i),line(i),2);
end
[row,line]=find(solidf==14);
for i=1:size(row)
    Rs(row(i),line(i)+1)=kr*(Cs-cw1(row(i),line(i),14));
    g1(row(i),line(i),4)=(w(2)+w(4))*cw1(row(i),line(i),14)-g1pre(row(i),line(i),2);
    g1(row(i),line(i),7)=(w(5)+w(7))*cw1(row(i),line(i),14)-g1pre(row(i),line(i),5);
    g1(row(i),line(i),8)=(w(6)+w(8))*cw1(row(i),line(i),14)-g1pre(row(i),line(i),6);
    g1(row(i),line(i),1)=(w(1)+w(3))*cw1(row(i),line(i),14)-g1pre(row(i),line(i),3);
    g1(row(i),line(i),3)=(w(1)+w(3))*cw1(row(i),line(i),14)-g1pre(row(i),line(i),1);
%     g2(row(i),line(i),4)=(w(2)+w(4))*cw2(row(i),line(i),14)-g2pre(row(i),line(i),2);
%     g2(row(i),line(i),7)=(w(5)+w(7))*cw2(row(i),line(i),14)-g2pre(row(i),line(i),5);
%     g2(row(i),line(i),8)=(w(6)+w(8))*cw2(row(i),line(i),14)-g2pre(row(i),line(i),6);
%     g2(row(i),line(i),1)=(w(1)+w(3))*cw2(row(i),line(i),14)-g2pre(row(i),line(i),3);
%     g2(row(i),line(i),3)=(w(1)+w(3))*cw2(row(i),line(i),14)-g2pre(row(i),line(i),1);
end
[row,line]=find(solidf==15);
for i=1:size(row)
    Rs(row(i)-1,line(i)-1)=kr*(Cs-cw1(row(i),line(i),15));
    g1(row(i),line(i),5)=(w(5)+w(7))*cw1(row(i),line(i),15)-g1pre(row(i),line(i),7);
    g1(row(i),line(i),1)=(w(1)+w(3))*cw1(row(i),line(i),15)-g1pre(row(i),line(i),3);
    g1(row(i),line(i),2)=(w(2)+w(4))*cw1(row(i),line(i),15)-g1pre(row(i),line(i),4);
    g1(row(i),line(i),6)=(w(6)+w(8))*cw1(row(i),line(i),15)-g1pre(row(i),line(i),8);
    g1(row(i),line(i),8)=(w(8)+w(6))*cw1(row(i),line(i),15)-g1pre(row(i),line(i),6);
%     g2(row(i),line(i),5)=(w(5)+w(7))*cw2(row(i),line(i),15)-g2pre(row(i),line(i),7);
%     g2(row(i),line(i),1)=(w(1)+w(3))*cw2(row(i),line(i),15)-g2pre(row(i),line(i),3);
%     g2(row(i),line(i),2)=(w(2)+w(4))*cw2(row(i),line(i),15)-g2pre(row(i),line(i),4);
%     g2(row(i),line(i),6)=(w(6)+w(8))*cw2(row(i),line(i),15)-g2pre(row(i),line(i),8);
%     g2(row(i),line(i),8)=(w(8)+w(6))*cw2(row(i),line(i),15)-g2pre(row(i),line(i),6);
end
[row,line]=find(solidf==16);
for i=1:size(row)
    Rs(row(i)+1,line(i)-1)=kr*(Cs-cw1(row(i),line(i),16));
    g1(row(i),line(i),6)=(w(6)+w(8))*cw1(row(i),line(i),16)-g1pre(row(i),line(i),8);
    g1(row(i),line(i),2)=(w(2)+w(4))*cw1(row(i),line(i),16)-g1pre(row(i),line(i),4);
    g1(row(i),line(i),3)=(w(1)+w(3))*cw1(row(i),line(i),16)-g1pre(row(i),line(i),1);
    g1(row(i),line(i),5)=(w(5)+w(7))*cw1(row(i),line(i),16)-g1pre(row(i),line(i),7);
    g1(row(i),line(i),7)=(w(5)+w(7))*cw1(row(i),line(i),16)-g1pre(row(i),line(i),5);
%     g2(row(i),line(i),6)=(w(6)+w(8))*cw2(row(i),line(i),16)-g2pre(row(i),line(i),8);
%     g2(row(i),line(i),2)=(w(2)+w(4))*cw2(row(i),line(i),16)-g2pre(row(i),line(i),4);
%     g2(row(i),line(i),3)=(w(1)+w(3))*cw2(row(i),line(i),16)-g2pre(row(i),line(i),1);
%     g2(row(i),line(i),5)=(w(5)+w(7))*cw2(row(i),line(i),16)-g2pre(row(i),line(i),7);
%     g2(row(i),line(i),7)=(w(5)+w(7))*cw2(row(i),line(i),16)-g2pre(row(i),line(i),5);
end
[row,line]=find(solidf==17);
for i=1:size(row)
    Rs(row(i)+1,line(i)+1)=kr*(Cs-cw1(row(i),line(i),17));
    g1(row(i),line(i),7)=(w(5)+w(7))*cw1(row(i),line(i),17)-g1pre(row(i),line(i),5);
    g1(row(i),line(i),3)=(w(1)+w(3))*cw1(row(i),line(i),17)-g1pre(row(i),line(i),1);
    g1(row(i),line(i),4)=(w(2)+w(4))*cw1(row(i),line(i),17)-g1pre(row(i),line(i),2);
    g1(row(i),line(i),6)=(w(6)+w(8))*cw1(row(i),line(i),17)-g1pre(row(i),line(i),8);
    g1(row(i),line(i),8)=(w(6)+w(8))*cw1(row(i),line(i),17)-g1pre(row(i),line(i),6);
%     g2(row(i),line(i),7)=(w(5)+w(7))*cw2(row(i),line(i),17)-g2pre(row(i),line(i),5);
%     g2(row(i),line(i),3)=(w(1)+w(3))*cw2(row(i),line(i),17)-g2pre(row(i),line(i),1);
%     g2(row(i),line(i),4)=(w(2)+w(4))*cw2(row(i),line(i),17)-g2pre(row(i),line(i),2);
%     g2(row(i),line(i),6)=(w(6)+w(8))*cw2(row(i),line(i),17)-g2pre(row(i),line(i),8);
%     g2(row(i),line(i),8)=(w(6)+w(8))*cw2(row(i),line(i),17)-g2pre(row(i),line(i),6);
end
[row,line]=find(solidf==18);
for i=1:size(row)
    Rs(row(i)-1,line(i)+1)=kr*(Cs-cw1(row(i),line(i),18));
    g1(row(i),line(i),8)=(w(6)+w(8))*cw1(row(i),line(i),18)-g1pre(row(i),line(i),6);
    g1(row(i),line(i),1)=(w(1)+w(3))*cw1(row(i),line(i),18)-g1pre(row(i),line(i),3);
    g1(row(i),line(i),4)=(w(2)+w(4))*cw1(row(i),line(i),18)-g1pre(row(i),line(i),2);
    g1(row(i),line(i),5)=(w(5)+w(7))*cw1(row(i),line(i),18)-g1pre(row(i),line(i),7);
    g1(row(i),line(i),7)=(w(5)+w(7))*cw1(row(i),line(i),18)-g1pre(row(i),line(i),5);
%     g2(row(i),line(i),8)=(w(6)+w(8))*cw2(row(i),line(i),18)-g2pre(row(i),line(i),6);
%     g2(row(i),line(i),1)=(w(1)+w(3))*cw2(row(i),line(i),18)-g2pre(row(i),line(i),3);
%     g2(row(i),line(i),4)=(w(2)+w(4))*cw2(row(i),line(i),18)-g2pre(row(i),line(i),2);
%     g2(row(i),line(i),5)=(w(5)+w(7))*cw2(row(i),line(i),18)-g2pre(row(i),line(i),7);
%     g2(row(i),line(i),7)=(w(5)+w(7))*cw2(row(i),line(i),18)-g2pre(row(i),line(i),5);
end
Rs(:,[1,ny])=0.0;
end