function [posX,posY,posZ,magX,magY,magZ,date,corX,corY,corZ]=MAVENloadpds(filename)
%[posX,posY,posZ,magX,magY,magZ,date,corX,corY,corZ]=MAVENloadpds(filename)
%
% Reads a .STS file and returns the locations, magnetic field components,
% and meta data
%
% INPUT:
%
% filename      directory and name of the .STS file to be read
%
% OUTPUT:
%
% posX, posY, posZ  location in coordinates of the .STS file
% magX, magY, magZ  magnetic field components in coordinate system defined
%                   in the  .STS file (e.g. Planetocentric or SunState)
% date              date when the measurement was made by MGS
% corX, corY, corZ  Outboard dynamic correction. Ask Jack.
%    
% Last modified by plattner-at-alumni.ethz.ch, 03/07/2017

fid=fopen(filename,'r');    

% Skip the header. It is always from line 1 to line 149
%headlength=149;
%for i=1:headlength
%    line=fgets(fid);
%end

% We don't know how long the header is. It varies. Therefore, search for
% the first record. The year will be 2014 or above and there will be two 
% empty spaces before. So look for '  20'
inheader=1;
while inheader
   line=fgets(fid); 
   if strcmp(line(1:4),'  20')
       inheader=0;
   end
end
   

% Now we start reading. Need to go one back
first=textscan(line, '%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f');

C = textscan(fid, '%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f');
fclose(fid);

date=[first{1} first{2} first{3} first{4} first{5} first{6} first{7};...
      C{1} C{2} C{3} C{4} C{5} C{6} C{7}];
magX=[first{8};C{8}];
magY=[first{9};C{9}];
magZ=[first{10};C{10}];

posX=[first{12};C{12}];
posY=[first{13};C{13}];
posZ=[first{14};C{14}];

corX=[first{16};C{16}];
corY=[first{17};C{17}];
corZ=[first{18};C{18}];





