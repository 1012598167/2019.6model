%%
load('scheme_Rank_1234.mat');
%%
exmax=45;
for i=1:4
    for j=1:4
        diff_(i,j)=dif(scheme_rank(:,i+1),scheme_rank(:,j+1),scheme_rank(:,1));
    end
end
diff_
%%
%scheme_rank
function difnum=dif(rowa,rowb,rank_init)
    thesize=size(rowa,1);
    difnum=0;
    for i=1:thesize
        rowa_rank=rank_init(i)
        for j=1:thesize
            if rowb(j)==rowa(i)
                rowb_rank=rank_init(j)
                break
            end
        end
        difnum=difnum+abs(rowa_rank-rowb_rank);
    end
    difnum=difnum/thesize;
end
