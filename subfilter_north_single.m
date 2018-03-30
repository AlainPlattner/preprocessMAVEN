function subfilter_north_single(singleorigfile,singleoutfile,max_cola)

dat=load(singleorigfile);
datamatrix=dat.datamatrix(dat.datamatrix(:,2)<max_cola,:);
            
save(singleoutfile,'datamatrix')