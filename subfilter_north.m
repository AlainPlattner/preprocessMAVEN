function subfilter_north(min_lat)
% Retain only those points that have latitude [degrees] greater than
% min_lat

maxrad=3390+300;

origpath=sprintf('/mnt/MarsDrive/MavenData/merged/maxrad_%d',maxrad);

outpath=sprintf('/mnt/MarsDrive/MavenData/merged/maxrad_%d_minlat%d',maxrad,min_lat);

max_cola=pi/180*(90-min_lat);



years{1}.year=2014;
years{1}.months=10:12;

years{2}.year=2015;
years{2}.months=1:12;

years{3}.year=2016;
years{3}.months=1:12;

years{4}.year=2017;
years{4}.months=1:5;


for y=1:length(years)
%y=1;
    for m=1:length(years{y}.months)
        
        fullorigpath=fullfile(origpath,sprintf('%d',years{y}.year),...
            sprintf('%02d',years{y}.months(m)));
        
        fulloutpath=fullfile(outpath,sprintf('%d',years{y}.year),...
            sprintf('%02d',years{y}.months(m)));
                
        mkdir(fulloutpath);
        
        origfiles=ls2cell(fullfile(fullorigpath,'*.mat'));
        
       parfor f=1:length(origfiles)
                             
            singleorigfile=fullfile(fullpcpath,origfiles{f});
            [~,name,~]=fileparts(singleorigfile);
            
            outname=[name,sprintf('_minlat%d',minlat)];
            singleoutfile=fullfile(fulloutpath,outname);
            
            subfilter_north_single(singleorigfile,singleoutfile,max_cola);
            
        end
        
    end
    
end
        
