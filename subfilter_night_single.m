function subfilter_night_single(singleorigfile,singleoutfile)

rMars=3390;

dat=load(singleorigfile);

% Night is when sunstate x position is smaller than -sqrt(r^2-rMars^2);
night_index=(dat.datamatrix(:,7)<-sqrt(dat.datamatrix(:,1).^2-rMars^2));

datamatrix=dat.datamatrix(night_index,:);

% Only save if there are any night time data available
if sum(night_index)>0
    save(singleoutfile,'datamatrix')
end


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
