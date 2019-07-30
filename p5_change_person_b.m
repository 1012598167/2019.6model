%%
load('matrix.mat');
load('believe_rank.mat');
%先把matrix更新成matrix2 专家编号直接换成专家排名
imax=1046;jmax=11;exmax=45;
themap = containers.Map(believe_rank,[1:exmax]);
matrix2=matrix;
for i=1:imax
    for j=[3,6,9]
        matrix2(i,j)=themap(matrix(i,j));
    end
end
%%
%x_=[];%x_(专家)={[预估分数]}
%y_=[];%y_(专家)={[实际分数]}
ite1=1;
for i=1:imax
    for j=[3,6,9]
        x_(matrix2(i,j),ite1)=matrix2(i,j+2);
        y_(matrix2(i,j),ite1)=matrix2(i,2);
        ite1=ite1+1;
    end
end
p=[];
q=[];
for i=1:exmax
    poly=polyfit(x_(i,:),y_(i,:),1);
    p(i)=poly(1);
    q(i)=poly(2);
end
%%
matrix_ex_add1=matrix2;
for i=1:imax
    for j=[3,6,9]
        if matrix_ex_add1(i,j)~=exmax
            matrix_ex_add1(i,j)=matrix_ex_add1(i,j)+1;%who_
            who_=matrix_ex_add1(i,j);
            matrix_ex_add1(i,j+2)=(matrix_ex_add1(i,2)-q(who_))/p(who_);%px+q=c求x
        end
    end
    matrix_ex_add1(i,2)=(matrix_ex_add1(i,5)+matrix_ex_add1(i,8)+matrix_ex_add1(i,11))/3;
end
%%
pre_score=matrix2(:,2);
after_score=matrix_ex_add1(:,2);
error=0;
for i=1:imax
    error=error+abs(pre_score(i)-after_score(i));
end
error=error/imax
% %%
% %线性规划结果图 排名1和xx的专家
% poly1=polyfit(x_(1,:),y_(1,:),1);
% p=poly1(1);
% x1=linspace(min(x_(1,:)),max(x_(1,:)));
% y1=polyval(p,x1);
% plot(x,y,'*',x1,y1);
%%
x=x_(1,:); y=y_(1,:);  
p=polyfit(x,y,1);  
x1=linspace(min(x),max(x));  
y1=polyval(p,x1);  
plot(x,y,'*',x1,y1);
%%
x=x_(45,:); y=y_(45,:);  
p=polyfit(x,y,1);  
x1=linspace(min(x),max(x));  
y1=polyval(p,x1);  
plot(x,y,'*',x1,y1);
