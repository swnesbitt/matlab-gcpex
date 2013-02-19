function [ data ] = read_netcdf_hdr( filen )
%read_nercdf reads netCDF data into a structure

%fileinfo = ncinfo(filen);
finfo.Variables(1).Name='latitude';
finfo.Variables(2).Name='longitude';
finfo.Variables(3).Name='altitude';
finfo.Variables(4).Name='time_coverage_start';
finfo.Variables(5).Name='time';
finfo.Variables(6).Name='sweep_mode';
finfo.Variables(7).Name='elevation';
finfo.Variables(8).Name='azimuth';
finfo.Variables(9).Name='range';
finfo.Variables(10).Name='ray_n_gates';
finfo.Variables(11).Name='ray_start_index';


for v=1:length(finfo.Variables)
 eval(['data.' finfo.Variables(v).Name '=ncread(filen,finfo.Variables(v).Name);'])
end

end

