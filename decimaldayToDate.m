function [Month,Day,Hour,Minute,Second]=decimaldayToDate(dday,year)
% This takes care of leap years too! That's why we need the year.

dday=dday+datenum(year,1,1)-1;

[~,Month,Day,Hour,Minute,Second]=datevec(dday);

