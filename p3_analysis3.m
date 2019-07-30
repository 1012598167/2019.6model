%%
imax=1046;jmax=11,exmax=45;
sort_mat=sortrows(matrix,-2);%按得分排序
%%
clus=5;
[idx,c,sumd,D]=kmeans(sort_mat(:,2),clus);
iter=2;
group=[];
while 1
    if size(group,1)>=4
        break
    end
    if idx(iter)~=idx(iter-1)
        group=[group;iter];
    end
    iter=iter+1;
end
group=[group;imax+1];    
%下为五个聚类分数中心，可见较为分散平均，比较合适
%[39.0477258566978;64.8715891472868;44.8588490770901;50.1618082788671;56.2315000000000]
%根据group 1-86 一等奖 87-326 二等奖 327-632三等奖 633-939优秀奖 940-1046参与奖
%k-means聚类 假设按一等奖二等奖三等奖优秀奖参与奖分五类 不设名额限制
%然后将分组置于sort_mat中
%%
k=1;
form_j=1;
j=1;
for j=group'
    for i=form_j:j-1
        sort_mat(i,12)=k;
    end
    form_j=j;
    k=k+1;
end
%%
x=[];e=nan*ones(imax,exmax);
x(imax,exmax)=0;
t=matrix(:,2);%meanx =t
for i=1:imax
    for j=[5;8;11]
        x(i,matrix(i,j-2))=matrix(i,j);
        e(i,matrix(i,j-2))=t(i)-x(i,matrix(i,j-2));
    end
end
%%
group_length=diff([1;group],1);
group_length_norm=group_length/norm(group_length,1);
believe=[];
for jj=1:exmax
    k=1;
    form_j=1;
    j=1;
    ex_take_num=0;
    error=[];
    assess=[];
    sum_var_divide=0;
    for j=group'
        for i=form_j:j-1
            if x(i,jj)~=0
                error=[error;e(i,jj)];
                assess=[assess;x(i,jj)];
                ex_take_num=ex_take_num+1;
            end
        end
        form_j=j;
        devi=1-var(error)/var(assess);
        sum_var_divide=sum_var_divide+group_length_norm(k)*devi;%受每等奖人数影响
        k=k+1;
    end
    believe=[believe;sum_var_divide];
end
%%
R=[];
for j=1:exmax
    R(j)=exmax*believe(j)/(1+(exmax-1)*believe(j));
end
R=R';%1-2节的R为法3的专家信度