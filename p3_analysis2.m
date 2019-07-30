%%
load('matrix.mat');
%%
%matrix(1)1to 1046 (2)score (345)(678)(91011)expert score standardscore
imax=1046;jmax=11;exmax=45;
x=[];e=nan*ones(imax,exmax);
x(imax,exmax)=0;
t=matrix(:,2);%meanx =t
for i=1:imax
    for j=[5;8;11]
        x(i,matrix(i,j-2))=matrix(i,j);
        e(i,matrix(i,j-2))=t(i)-x(i,matrix(i,j-2));
    end
end
believe=[];
for j=1:exmax
    error=[];
assess=[];
    ex_take_num=0;
    for i=1:imax
        if x(i,j)~=0
%             absolute=abs(x(i,j)-t(i));
%             maxe=max([matrix(i,5),matrix(i,8),matrix(i,11)]);
%             mine=min([matrix(i,5),matrix(i,8),matrix(i,11)]);
%             sum=sum+1-absolute/(maxe-mine);
            error=[error;e(i,j)];
            assess=[assess;x(i,j)];
            ex_take_num=ex_take_num+1;
        end
    end
    believe=[believe;1-var(error)/var(assess)];
end
%%
R=[];
for j=1:exmax
    R(j)=exmax*believe(j)/(1+(exmax-1)*believe(j));
end
R=R';%1-2节的R为法2的专家信度