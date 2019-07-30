%%
load('believe_rank.mat');
load('matrix.mat');
% believe_rank1=believe_rank(41:45);
% believe_rank2=believe_rank(36:45);
% cutnum=0;
% cut0=group_believe(believe_rank,matrix,cutnum)
% cutnum=5;
% cut5=group_believe(believe_rank,matrix,cutnum)
cut_=[];
for cutnum=0:10
    cut_(cutnum+1)=group_believe(believe_rank,matrix,cutnum);
end
cut_
%%
%ÌÞ³ýcutnum¸ö
function br=cut(mat,cutnum)
    br=mat(46-cutnum:45);
end
function r=group_believe(believe_rank,matrix,cutnum)
    believe_rank1=cut(believe_rank,cutnum);
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
    exmax=45-cutnum;
    x(:,believe_rank1)=[];
    for i=1:imax
        rr=0;
        ss=0;
        for j=1:exmax
            if x(i,j)~=0
%                 x(i,matrix(i,j-2))=matrix(i,j);
%                 e(i,matrix(i,j-2))=t(i)-x(i,matrix(i,j-2));
                rr=rr+x(i,j);
                ss=ss+1;
            end
        end
        if ss==0
            t(i)=0;
        else
            t(i)=rr/ss;
        end
    end
    for i=1:imax
        for j=1:exmax
            e(i,j)=t(i)-x(i,j);
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
    r=Spearman_Brown(r,cutnum);
end
function R=Spearman_Brown(believe,cutnum,exmax)
    if (nargin<3)
        exmax=45-cutnum;
    end
    R=exmax*believe/(1+(exmax-1)*believe);
end