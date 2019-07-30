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
realm=[];realn=[];%要把0去掉再统计
n=imax;m=exmax;
xij=0;
xip=zeros(1,n);
xpj=zeros(m,1);
for i=1:n
    xipiter=0;
    realni=0;
    for j=1:m
        if(x(i,j)~=0)
            xipiter=xipiter+x(i,j);
            xij=xij+x(i,j);
            realni=realni+1;
        end
    end
    realn(i)=realni;
    xip(i)=xipiter/realni;
end
for j=1:m
    xpjiter=0;
    realmj=0;
    for i=1:n
        if(x(i,j)~=0)
            xpjiter=xpjiter+x(i,j);
            realmj=realmj+1;
        end
    end
    realm(j)=realmj;
    xpj(j)=xpjiter/realmj;
end
x_ba=xij/(3*n);
xip;
xpj';
%%
%n1046m45
sa=0;
% for i=1:n
%     sa=sa+(xip(i)-x_ba)^2;
% end
% sa=m*sa
sb=0;
% for j=1:m
%     sb=sb+(xpj(j)-x_ba)^2;
% end
% sb=n*sb
semp=0;
sall=0;
for i=1:n
    for j=1:m
        if(x(i,j)~=0)%一旦出现x(i,j)必须排除掉0
            sa=sa+(xip(i)-x_ba)^2;
            sb=sb+(xpj(j)-x_ba)^2;
            semp=semp+(x(i,j)-xip(i)-xpj(j)+x_ba)^2;
            sall=sall+(x(i,j)-x_ba)^2;
        end
    end
end
sa
sb
semp
sall
%经验证sa+sb+semp=sall
%%
%69.73*45=3*1046
fa=(sa/(n-1))/(semp/(2*(n-1)))
falpha=1/finv(0.05,n-1,2*(n-1))
fa>falpha
fb=(sb/2)/(semp/(2*(n-1)))
fbeta=1/finv(0.05,2,2*(n-1))
fb<=fbeta