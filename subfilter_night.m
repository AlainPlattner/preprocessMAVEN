function subfilter_night()
% Retain only those points that have sunstate x axis smaller than -sqrt(r-rMars)

onesec=1;
  
maxrad=3390+300;

if onesec
  origpath=sprintf('/mnt/MarsDrive/MavenData/onesec/merged/maxrad_%d',maxrad);
  
  outpath=sprintf('/mnt/MarsDrive/MavenData/onesec/merged/maxrad_%d_night',maxrad);
else
  origpath=sprintf('/mnt/MarsDrive/MavenData/highres/merged/maxrad_%d',maxrad);
  
  outpath=sprintf('/mnt/MarsDrive/MavenData/highres/merged/maxrad_%d_night',maxrad);
end

years{1}.year=2014;
years{1}.months=10:12;

years{2}.year=2015;
years{2}.months=1:12;

years{3}.year=2016;
years{3}.months=1:12;

years{4}.year=2017;
years{4}.months=1:5;

%years{1}.year=2016;
%years{1}.months=1:12;

%years{2}.year=2017;
%years{2}.months=1:5;


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
	%for f=1:length(origfiles)
                                    
            singleorigfile=fullfile(fullorigpath,origfiles{f});
            [~,name,~]=fileparts(singleorigfile);
            
            outname=[name,'_night'];
            singleoutfile=fullfile(fulloutpath,outname);
            
            subfilter_night_single(singleorigfile,singleoutfile);
            
        end
        
    end
    
end
        
