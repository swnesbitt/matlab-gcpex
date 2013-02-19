function read_citation
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

[labels,x,y]=readColData('/Users/snesbitt/data/mc3e/cloudmicro/mc3e_citation_20110422_214935_rh_1Hz.txt',9,25);

Time=int32(x);
Nev_TWC=y(:,1);
Nev_LWC=y(:,2);
Air_T_P2T1=y(:,3);
Air_T_P2T2=y(:,4);
DEWPT=y(:,5);
RH=y(:,6);
RH_w=y(:,7);

[labels,x,y]=readColData('/Users/snesbitt/data/mc3e/cloudmicro/mc3e_navCit_20110422_214935_1Hz.txt',4,20);

Time2=int32(x);
lat=zeros(size(Time2));
lon=zeros(size(Time2));
alt=zeros(size(Time2));

for i=1:length(Time)
    in=find(Time2 == Time(i));
    in
if ~isempty(in)
    lat(i)=y(in,1);
    lon(i)=y(in,2);
    alt(i)=y(in,3);
end
end

in=find(Nev_TWC > 0. & Nev_TWC < 30. & RH < 200);

end

