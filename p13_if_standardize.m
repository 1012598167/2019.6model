%%
load('matrix.mat');
%%
imax=1046;jmax=11;exmax=45;
matrix2=matrix;
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
r=1-sum(var_error,2)/sum(var_assess,2);
r=Spearman_Brown(r)
%%
function R=Spearman_Brown(believe,exmax)
    if (nargin<2)
        exmax=45;
    end
    R=exmax*believe/(1+(exmax-1)*believe);
end