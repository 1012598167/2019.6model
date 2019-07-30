%%
load('matrix.mat');
%%
%matrix(1)1to 1046 (2)score (345)(678)(91011)expert score standardscore
imax=1046;jmax=11,exmax=45;
x=[];
x(imax,exmax)=0;
t=matrix(:,2);%meanx =t
for i=1:imax
    for j=[5;8;11]
        x(i,matrix(i,j-2))=matrix(i,j);
    end
end
believe=[];
for j=1:exmax
    sum_=0;
    ex_take_num=0;
    for i=1:imax
        if x(i,j)~=0
            absolute=abs(x(i,j)-t(i));
            maxe=max([matrix(i,5),matrix(i,8),matrix(i,11)]);
            mine=min([matrix(i,5),matrix(i,8),matrix(i,11)]);
            sum_=sum_+1-absolute/(maxe-mine);
            ex_take_num=ex_take_num+1;
        end
    end
    sum_=sum_/ex_take_num;
    believe=[believe;sum_];
end
%%
R=[];
for j=1:exmax
    R(j)=exmax*believe(j)/(1+(exmax-1)*believe(j));
end
R=R';%1-2节的R为法1的专家信度
%%
for i=1,3
    disp(i)
end