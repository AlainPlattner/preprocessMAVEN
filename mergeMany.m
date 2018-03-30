function mergeMany(maxrad)

onesec=1;
  
if nargin<1
    maxrad=3390+300;
end

years{1}.year=2014;
years{1}.months=10:12;

years{2}.year=2015;
years{2}.months=1:12;

years{3}.year=2016;
years{3}.months=1:12;

years{4}.year=2017;
years{4}.months=1:11;

%years{1}.year=2016;
%years{1}.months=5;

if onesec
  pcpath='/mnt/MarsDrive/MavenData/onesec/planetocentric';
  sspath='/mnt/MarsDrive/MavenData/onesec/sunstate';
  outpath=sprintf('/mnt/MarsDrive/MavenData/onesec/merged/maxrad_%d',maxrad);
  namerange=24:31;
else
  pcpath='/mnt/MarsDrive/MavenData/highres/planetocentric';
  sspath='/mnt/MarsDrive/MavenData/highres/sunstate';
  outpath=sprintf('/mnt/MarsDrive/MavenData/highres/merged/maxrad_%d',maxrad);
  namerange=22:29;
end

for y=1:length(years)
%y=1;
    for m=1:length(years{y}.months)
    %m=1;
        fullpcpath=fullfile(pcpath,sprintf('%d',years{y}.year),...
            sprintf('%02d',years{y}.months(m)));
    
        fullsspath=fullfile(sspath,sprintf('%d',years{y}.year),...
            sprintf('%02d',years{y}.months(m)));
    
        fulloutpath=fullfile(outpath,sprintf('%d',years{y}.year),...
            sprintf('%02d',years{y}.months(m)));
        
        mkdir(fulloutpath);
        
        pcfiles=ls2cell(fullfile(fullpcpath,'*.sts'));
        ssfiles=ls2cell(fullfile(fullsspath,'*.sts'));

	
              
        % parfor
        parfor f=1:length(pcfiles)
        %f=1;
            yearmonthday_pc=pcfiles{f}(namerange);
            yearmonthday_ss=ssfiles{f}(namerange);
            if ~strcmp(yearmonthday_pc,yearmonthday_ss)
                error('missing file %s, %s',...
                    yearmonthday_pc,yearmonthday_ss)
            end
            
            yearmonthdaymaxrad=[yearmonthday_pc,sprintf('_maxrad%d',maxrad)];
            
            singlepcfile=fullfile(fullpcpath,pcfiles{f});
            singlessfile=fullfile(fullsspath,ssfiles{f});
            singleoutfile=fullfile(fulloutpath,yearmonthdaymaxrad);
            
            mergeSingle(singlepcfile,singlessfile,singleoutfile,maxrad)  
            
        end
        
    end
end
