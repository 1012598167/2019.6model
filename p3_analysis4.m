%%
load('matrix.mat');
%�Ȱ�matrix���³�matrix2 ר�ұ��ֱ�ӻ���ר������
imax=1046;jmax=11;exmax=45;
matrix2=matrix;
%%
%x_=[];%x_(ר��)={[Ԥ������]}
%y_=[];%y_(ר��)={[ʵ�ʷ���]}
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
p2=p;%p2������ԭ��p��1��ƫ�� ֵԽ��ר��Խ��רҵ
for i=1:exmax
    p2(i)=abs(p(i)-1);
    p3(i)=1-p2(i);
end