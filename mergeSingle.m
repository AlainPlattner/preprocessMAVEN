function mergeSingle(filepc,filess,fileout,maxrad)


%% Planetocentric
% Load PC file
[PC_X,PC_Y,PC_Z,PC_BX,PC_BY,PC_BZ,PC_date,~,~,~]=MAVENloadpds(filepc);
year=PC_date(:,1);
dday=PC_date(:,7);
%PC_rad=sqrt(PC_X.^2 + PC_Y.^2 + PC_Z.^2);
% Delete the remaining date components to save memory
clear PC_date;

% Turn cartesian of PC into spherical coordinates
[lon,lat,rad] = cart2sph(PC_X,PC_Y,PC_Z);
% The output of this function is in latitudes. We need colatitudes to
% proceed:
cola=pi/2-lat;
% The longitudes are between -pi and pi. Let's put them between 0 and 2pi.
% That's easy, just use modulo
lon=mod(lon,2*pi);

% We don't need posX,posY,posZ anymore. Delete them (they take up memory)
clear PC_X; clear PC_Y; clear PC_Z;

% Now transform cartesian magnetic data into spherical format
[PC_Blon,PC_Bcola,PC_Br]=dcart2dsph(lon,cola,PC_BX,PC_BY,PC_BZ);

% Remove the cartesian components
clear PC_BX; clear PC_BY; clear PC_BY;


%% Sun state
[SS_X,SS_Y,SS_Z,~,~,~,~,~,~,~]=MAVENloadpds(filess);


%% Output

% Decided on the following columns

% column 1: Planetocentric radial distance from center of planet (r) [km] 
% column 2: Planetocentric colatitudinal position (\theta) [radians]
% column 3: Planetocentric longitudinal position (\phi) [radians]
% column 4: Planetocentric radial magnetic field component (B_r) [nT]
% column 5: Planetocentric colatitudinal magnetic field component (B_\theta) [nT]
% column 6: Planetocentric longitudinal magnetic field component (B_\phi) [nT]
% column 7: Sun state X coordinate [km]
% column 8: Sun state Y coordinate [km]
% column 9: Sun state Z coordinate [km]
% column 10: year
% column 11: decimal day

datamatrix=[rad,cola,lon,PC_Br,PC_Bcola,PC_Blon,SS_X,SS_Y,SS_Z,year,dday];    
    
% We are removing the entries with radial position larger than maxrad
datamatrix=datamatrix(rad<=maxrad,:);

save(fileout,'datamatrix');




