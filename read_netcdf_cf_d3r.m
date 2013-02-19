function [ data ] = read_netcdf_cf_d3r( filen, hdr )
%read_nercdf reads netCDF data into a structure

%finfo = ncinfo(filen);
finfo.Variables(1).Name='Reflectivity';
finfo.Variables(2).Name='Velocity';
finfo.Variables(3).Name='SpectralWidth';
finfo.Variables(4).Name='DifferentialReflectivity';
finfo.Variables(5).Name='DifferentialPhase';
finfo.Variables(6).Name='CrossPolCorrelation';
finfo.Variables(7).Name='NormalizedCoherentPower';
finfo.Variables(8).Name='SpecificPhase';

for v=1:length(finfo.Variables)
 eval(['data.' regexprep(finfo.Variables(v).Name,'[A-Z]','${lower($0)}') '=ncread(filen,finfo.Variables(v).Name);'])
end


end

