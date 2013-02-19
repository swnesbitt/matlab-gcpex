function [ data2 ] = read_netcdf_cf_wkr( filen , hdr)
%read_nercdf reads netCDF data into a structure

%finfo = ncinfo(filen);
finfo.Variables(1).Name='DBZ';
finfo.Variables(2).Name='DBZ_TOT';
finfo.Variables(3).Name='ZDR';
finfo.Variables(4).Name='KDP';
finfo.Variables(5).Name='PHIDP';
finfo.Variables(6).Name='RHOHV';
finfo.Variables(7).Name='SQI';

for v=1:length(finfo.Variables)
    eval(['data.' finfo.Variables(v).Name '=ncread(filen,finfo.Variables(v).Name);'])
for i=1:length(hdr.ray_start_index)
    finfo.Variables(v).Name
    i 
    hdr.ray_start_index(i)+1 
    hdr.ray_n_gates(i)
    
    eval(['data2.' finfo.Variables(v).Name '(1:hdr.ray_n_gates(i),i)=data.' finfo.Variables(v).Name '(hdr.ray_start_index(i)+1:hdr.ray_start_index(i)+hdr.ray_n_gates(i));'])
end
end


end

