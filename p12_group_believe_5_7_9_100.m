%%
mat5=mat_mark(matrix,5);
r5=group_believe(mat5)
mat7=mat_mark(matrix,7);
r7=group_believe(mat7)
mat9=mat_mark(matrix,9);
r9=group_believe(mat9)
mat100=mat_mark(matrix,100);
r100=group_believe(mat100)
%%
function y=mark_system(x,base)
    y=round(x/100*base);
end 
function mat=mat_mark(matrix,base)
    mat=matrix;
    mat(:,5)=mark_system(mat(:,5),base);
    mat(:,8)=mark_system(mat(:,8),base);
    mat(:,11)=mark_system(mat(:,11),base);
    mat(:,2)=(mat(:,5)+mat(:,8)+mat(:,11))/3;
end 
function r=group_believe(matrix)
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
    r=Spearman_Brown(r);
end
function R=Spearman_Brown(believe,exmax)
    if (nargin<2)
        exmax=45;
    end
    R=exmax*believe/(1+(exmax-1)*believe);
end