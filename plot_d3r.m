function plot_d3r

d3rku_file='C:\Users\admin\Data\gpm\d3r\kud3r_20120218_130432_01.nc';
data_d3rku_hdr=read_d3r_hdr(d3rku_file);
data_d3rku=read_netcdf_cf_d3r(d3rku_file,data_d3rku_hdr);
d3rka_file='C:\Users\admin\Data\gpm\d3r\kad3r_20120218_130432_01.nc';
data_d3rka=read_netcdf_cf_d3r(d3rka_file,data_d3rku_hdr);
[pathstr,name,ext]=fileparts(d3rku_file);
fp=[name ext];

data_d3rku_hdr.azimuth(data_d3rku_hdr.azimuth < 0)=data_d3rku_hdr.azimuth(data_d3rku_hdr.azimuth < 0) + 360;
t_in=datenum(fp(7:21),'yyyymmdd_HHMMSS');
sz=size(data_d3rku.reflectivity)
t_in=repmat(t_in,sz);
el=repmat(data_d3rku_hdr.elevation',[sz(1) 1]);
az=repmat(data_d3rku_hdr.azimuth',[sz(1) 1]);
rg=data_d3rku_hdr.range;

earthr=6371.56e3;

z_in_d3r=sqrt(rg.^2+(((4/3).*earthr).^2)+2*rg.*(4/3).*earthr.*sind(el))-((4/3).*earthr);
r_in_d3r=(4/3).*earthr.*asin((rg.*cosd(el))./((4/3).*earthr+z_in_d3r));

x_in_d3r = (sind(az) .* cosd(el)) .* rg;
y_in_d3r = (cosd(az) .* cosd(el)) .* rg;

d3rku_file2='C:\Users\admin\Data\gpm\d3r\kud3r_20120218_130251_01.nc';
data_d3rku_hdr2=read_d3r_hdr(d3rku_file2);
data_d3rku2=read_netcdf_cf_d3r(d3rku_file2,data_d3rku_hdr2);
d3rka_file2='C:\Users\admin\Data\gpm\d3r\kad3r_20120218_130251_01.nc';
data_d3rka2=read_netcdf_cf_d3r(d3rka_file2,data_d3rku_hdr2);
[pathstr,name,ext]=fileparts(d3rku_file2);
fp=[name ext];

data_d3rku_hdr2.azimuth(data_d3rku_hdr2.azimuth < 0)=data_d3rku_hdr2.azimuth(data_d3rku_hdr2.azimuth < 0) + 360;
t_in=datenum(fp(7:21),'yyyymmdd_HHMMSS');
sz=size(data_d3rku2.reflectivity)
t_in=repmat(t_in,sz);
el=repmat(data_d3rku_hdr2.elevation',[sz(1) 1]);
az=repmat(data_d3rku_hdr2.azimuth',[sz(1) 1]);
rg=data_d3rku_hdr2.range;

earthr=6371.56e3;

z_in_d3r2=sqrt(rg.^2+(((4/3).*earthr).^2)+2*rg.*(4/3).*earthr.*sind(el))-((4/3).*earthr);
r_in_d3r2=(4/3).*earthr.*asin((rg.*cosd(el))./((4/3).*earthr+z_in_d3r2));

x_in_d3r2 = (sind(az) .* cosd(el)) .* rg;
y_in_d3r2 = (cosd(az) .* cosd(el)) .* rg;


%subplot(3,1,1)

surface(x_in_d3r/1e3,y_in_d3r/1e3,z_in_d3r/1e3,double(data_d3rku.reflectivity))
hold on
surface(x_in_d3r2/1e3,y_in_d3r2/1e3,z_in_d3r2/1e3,double(data_d3rku2.reflectivity))
set(gca,'CLim',[-10 30])
xlim([-30 30])
ylim([-60 60])
zlim([0 8])
shading flat
view(-30,10)
end
