function collect(path,outname)



years{1}.year=2014;
years{1}.months=10:12;

years{2}.year=2015;
years{2}.months=1:12;

years{3}.year=2016;
years{3}.months=1:12;

years{4}.year=2017;
years{4}.months=1:5;

%datamatrix=[];

%% Go through everything twice, first time: Count how long,
%% Then create empty structure
%% Second time: collect them

ntotal=0;

for y=1:length(years)

  years{y}.year
  
    for m=1:length(years{y}.months)

      years{y}.months(m)
      
        fullorigpath=fullfile(path,sprintf('%d',years{y}.year),...
            sprintf('%02d',years{y}.months(m)));
        
        % Could be empty
        try
            origfiles=ls2cell(fullfile(fullorigpath,'*.mat'));
        catch
            origfiles=[];
        end
    
        for f=1:length(origfiles)
            
            singleorigfile=fullfile(fullorigpath,origfiles{f});
            
            data=load(singleorigfile);
	    %%datamatrix=[datamatrix;data.datamatrix];
	    ntotal=ntotal + size(data.datamatrix,1);
        end
            
        
    end
end

ntotal

datamatrix=nan(ntotal,size(data.datamatrix,2));
count=0;

for y=1:length(years)
  years{y}.year
  
  for m=1:length(years{y}.months)

     years{y}.months(m)
        
        fullorigpath=fullfile(path,sprintf('%d',years{y}.year),...
            sprintf('%02d',years{y}.months(m)));
        
        % Could be empty
        try
            origfiles=ls2cell(fullfile(fullorigpath,'*.mat'));
        catch
            origfiles=[];
        end
    
        for f=1:length(origfiles)
            
            singleorigfile=fullfile(fullorigpath,origfiles{f});
            
            data=load(singleorigfile);
            
            datamatrix(count+1:count+size(data.datamatrix,1),:)=...
	    data.datamatrix;
   
	    count=count+size(data.datamatrix,1);
        end
            
        
    end
end

save(outname,'datamatrix','-v7.3')
