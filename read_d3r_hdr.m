function [ data ] = read_d3r_hdr( filen )
%read_nercdf reads netCDF data into a structure

%fileinfo = ncinfo(filen);
finfo.Variables(1).Name='Time';
finfo.Variables(2).Name='Elevation';
finfo.Variables(3).Name='Azimuth';
finfo.Variables(4).Name='StartRange';
finfo.Variables(5).Name='StartGate';
finfo.Variables(6).Name='GateWidth';
finfo.Variables(7).Name='Reflectivity';


for v=1:length(finfo.Variables)
    %use regexp to change the case of the files
 eval(['data.' regexprep(finfo.Variables(v).Name,'[A-Z]','${lower($0)}') '=ncread(filen,finfo.Variables(v).Name);'])
end
sz=size(data.reflectivity);
clear data.reflectivity

for i=1:sz(2);
data.range(:,i)=double(data.startrange(1))+1e-3*double(data.gatewidth(i)).*double(1:sz(1));
end

end

