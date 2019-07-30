%%
%经测试没有两个专家同时看过多个指定作品，所以就用一个人的
load('matrix.mat');
a1=round(rand(1)*45);
% a2=round(rand(1)*45);
% while a2==a1
%     a2=round(rand(1)*45);
% end
%%
imax=1046;jmax=11;exmax=45;
nodrop=[];
for i=1:imax
    for j=[3,6,9]
        if matrix(i,j)==a1%&&matrix(i,j)==a2
            nodrop=[nodrop,i];
        end
    end
end
matrix2=matrix;
matrix2=matrix2(nodrop,:);
size(matrix2)
%%
imax=size(matrix2,1);jmax=11;exmax=45;
matrix2(1:imax,1)=[1:imax]';
%%
x=[];e=nan*ones(imax,exmax);
x(imax,exmax)=0;
t=matrix2(:,2);%meanx =t
for i=1:imax
    for j=[5,8,11]
        x(i,matrix2(i,j-2))=matrix2(i,j);
        e(i,matrix2(i,j-2))=t(i)-x(i,matrix2(i,j-2));
    end
end
believe=[];
var_error=[];
var_assess=[];
for j=1:exmax
    error=[];
    assess=[];
    ex_take_num=0;
    for i=1:imax
        if x(i,j)~=0
            error=[error;e(i,j)];
            assess=[assess;x(i,j)];
            ex_take_num=ex_take_num+1;
        end
    end
    var_error=[var_error,var(error)];
    var_assess=[var_assess,var(assess)];
end
id=isnan(var_error) & isnan(var_error);
var_error(id)=[];%去除不参加的人
id=isnan(var_assess) & isnan(var_assess);
var_assess(id)=[];
r=1-sum(var_error,2)/sum(var_assess,2);
r=Spearman_Brown(r)
%%
function R=Spearman_Brown(believe,exmax)
    if (nargin<2)
        exmax=45;
    end
    R=exmax*believe/(1+(exmax-1)*believe);
end