function plot_gcpex
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

clear all
close all

coast=load('gcpex_coastline.dat');
bound=load('gcpex_boundaries.dat');

load 20120218_1d_1sec.mat

t1=11.5*60*60;
t2=13.5*60*60;

in=find(MastrLON < 180 & RSTem < 300 & nevtwc < 10);

%scatter3(MastrLON(in),MastrLAT(in),Altit(in),1,nevtwc(in))

%hold on



wkr_file='C:\Users\admin\Data\gpm\WKR\cf\20120218\cfrad.20120218_130255.701_to_20120218_130258.701_KING_v36_s00_az331.00_RHI.nc';
%wkr_file='C:\Users\admin\Data\gpm\WKR\cf\20120218\cfrad.20120218_120255.836_to_20120218_120258.836_KING_v24_s00_az331.00_RHI.nc';
data_wkr_hdr=read_netcdf_hdr(wkr_file);
data_wkr=read_netcdf_cf_wkr(wkr_file,data_wkr_hdr);


lat_king=data_wkr_hdr.latitude;
lon_king=data_wkr_hdr.longitude;

data_wkr_hdr.azimuth(data_wkr_hdr.azimuth < 0)=data_wkr_hdr.azimuth(data_wkr_hdr.azimuth < 0) + 360;
t_in=datenum(data_wkr_hdr.time_coverage_start','yyyy-mm-ddTHH:MM:SS')+...
    data_wkr_hdr.time/(60*60*24);
t_in=repmat(t_in',[length(data_wkr_hdr.range) 1]);
el=repmat(data_wkr_hdr.elevation',[length(data_wkr_hdr.range) 1]);
az=repmat(data_wkr_hdr.azimuth',[length(data_wkr_hdr.range) 1]);
rg=repmat(data_wkr_hdr.range,[1 length(data_wkr_hdr.azimuth)]);

earthr=6371.56e3;

z_in=sqrt(rg.^2+(((4/3).*earthr).^2)+2*rg.*(4/3).*earthr.*sind(el))-((4/3).*earthr);
r_in=(4/3).*earthr.*asin((rg.*cosd(el))./((4/3).*earthr+z_in));

x_in = (sind(az) .* cosd(el)) .* rg;
y_in = (cosd(az) .* cosd(el)) .* rg;

d3rku_file='C:\Users\admin\Data\gpm\d3r\kud3r_20120218_130432_01.nc';
%d3rku_file='C:\Users\admin\Data\gpm\d3r\kud3r_20120218_120435_01.nc';
data_d3rku_hdr=read_d3r_hdr(d3rku_file);
data_d3rku=read_netcdf_cf_d3r(d3rku_file,data_d3rku_hdr);
d3rka_file='C:\Users\admin\Data\gpm\d3r\kad3r_20120218_130432_01.nc';
%d3rka_file='C:\Users\admin\Data\gpm\d3r\kad3r_20120218_120435_01.nc';
data_d3rka_hdr=read_d3r_hdr(d3rka_file);
data_d3rka=read_netcdf_cf_d3r(d3rka_file,data_d3rka_hdr);
[pathstr,name,ext]=fileparts(d3rku_file);
fp=[name ext];

data_d3rku_hdr.azimuth(data_d3rku_hdr.azimuth < 0)=data_d3rku_hdr.azimuth(data_d3rku_hdr.azimuth < 0) + 360;
t_in=datenum(fp(7:21),'yyyymmdd_HHMMSS');
sz=size(data_d3rku.reflectivity)
t_in=repmat(t_in,sz);
el=repmat(data_d3rku_hdr.elevation',[sz(1) 1]);
az=repmat(data_d3rku_hdr.azimuth',[sz(1) 1]);
az(:)=az(1);
rg=data_d3rku_hdr.range;

earthr=6371.56e3;

z_in_d3r=sqrt(rg.^2+(((4/3).*earthr).^2)+2*rg.*(4/3).*earthr.*sind(el))-((4/3).*earthr);
r_in_d3r=(4/3).*earthr.*asin((rg.*cosd(el))./((4/3).*earthr+z_in_d3r));

x_in_d3r = (sind(az) .* cosd(el)) .* rg;
y_in_d3r = (cosd(az) .* cosd(el)) .* rg;

d3rku_file2='C:\Users\admin\Data\gpm\d3r\kud3r_20120218_130251_01.nc';
%d3rku_file2='C:\Users\admin\Data\gpm\d3r\kud3r_20120218_120255_01.nc';
data_d3rku_hdr2=read_d3r_hdr(d3rku_file2);
data_d3rku2=read_netcdf_cf_d3r(d3rku_file2,data_d3rku_hdr2);
d3rka_file2='C:\Users\admin\Data\gpm\d3r\kad3r_20120218_130251_01.nc';
%d3rka_file2='C:\Users\admin\Data\gpm\d3r\kad3r_20120218_120255_01.nc';
data_d3rka_hdr2=read_d3r_hdr(d3rka_file2);
data_d3rka2=read_netcdf_cf_d3r(d3rka_file2,data_d3rka_hdr2);
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

x_in_d3r2 =  (sind(az) .* cosd(el)) .* rg;
y_in_d3r2 = (cosd(az) .* cosd(el)) .* rg;

xmin=-80.1;
xmax=-79.5;

ymin=43.9; 
ymax=44.5;

zmin=0;
zmax=4.5;

figure
plot3(coast(:,1),coast(:,2),0.*coast(:,2),'-k')
hold on
plot3(bound(:,1),bound(:,2),0.*bound(:,2),'-k')

lat_care=44.2329;
lon_care=-79.781467;
good=find(data_d3rku_hdr.range(1,:) >= 0);
surface(lon_care+(1/(111.1*cosd(lat_care)))*x_in_d3r(:,good)/1e3,lat_care+(1/111.1)*y_in_d3r(:,good)/1e3,z_in_d3r(:,good)/1e3,double(data_d3rku.reflectivity(:,good)))
good=find(data_d3rku_hdr2.range(1,:) >= 0);
surface(lon_care+(1/(111.1*cosd(lat_care)))*x_in_d3r2(:,good)/1e3,lat_care+(1/111.1)*y_in_d3r2(:,good)/1e3,z_in_d3r2(:,good)/1e3,double(data_d3rku2.reflectivity(:,good)))
set(gca,'CLim',[-10 30])
xlim([xmin xmax])
ylim([ymin ymax])
zlim([zmin zmax])
shading flat
view(-52,12);
text(lon_care,lat_care,'\uparrow',... 
     'HorizontalAlignment','center',...
     'VerticalAlignment','cap',...
     'FontSize',16,'Color',[0 0 1])
 text(lon_king,lat_king,'\uparrow',... 
     'HorizontalAlignment','center',...
     'VerticalAlignment','cap',...
     'FontSize',16,'Color',[1 0 0])
set(gca,'DataAspectRatio',[1 1 10])

figure
plot3(coast(:,1),coast(:,2),0.*coast(:,2),'-k')
hold on
plot3(bound(:,1),bound(:,2),0.*bound(:,2),'-k')

lat_care=44.2329;
lon_care=-79.781467;
good=find(data_d3rku_hdr.range(1,:) >= 0);
surface(lon_care+(1/(111.1*cosd(lat_care)))*x_in_d3r(:,good)/1e3,lat_care+(1/111.1)*y_in_d3r(:,good)/1e3,z_in_d3r(:,good)/1e3,double(data_d3rku.differentialreflectivity(:,good)))
good=find(data_d3rku_hdr2.range(1,:) >= 0);
surface(lon_care+(1/(111.1*cosd(lat_care)))*x_in_d3r2(:,good)/1e3,lat_care+(1/111.1)*y_in_d3r2(:,good)/1e3,z_in_d3r2(:,good)/1e3,double(data_d3rku2.differentialreflectivity(:,good)))
set(gca,'CLim',[-1 3])
xlim([xmin xmax])
ylim([ymin ymax])
zlim([zmin zmax])
shading flat
view(-52,12);
text(lon_care,lat_care,'\uparrow',... 
     'HorizontalAlignment','center',...
     'VerticalAlignment','cap',...
     'FontSize',16,'Color',[0 0 1])
 text(lon_king,lat_king,'\uparrow',... 
     'HorizontalAlignment','center',...
     'VerticalAlignment','cap',...
     'FontSize',16,'Color',[1 0 0])
set(gca,'DataAspectRatio',[1 1 10])


figure
plot3(coast(:,1),coast(:,2),0.*coast(:,2),'-k')
hold on
plot3(bound(:,1),bound(:,2),0.*bound(:,2),'-k')

lat_care=44.2329;
lon_care=-79.781467;
good=find(data_d3rku_hdr.range(1,:) >= 0);
surface(lon_care+(1/(111.1*cosd(lat_care)))*x_in_d3r(:,good)/1e3,lat_care+(1/111.1)*y_in_d3r(:,good)/1e3,z_in_d3r(:,good)/1e3,double(data_d3rku.crosspolcorrelation(:,good)))
good=find(data_d3rku_hdr2.range(1,:) >= 0);
surface(lon_care+(1/(111.1*cosd(lat_care)))*x_in_d3r2(:,good)/1e3,lat_care+(1/111.1)*y_in_d3r2(:,good)/1e3,z_in_d3r2(:,good)/1e3,double(data_d3rku2.crosspolcorrelation(:,good)))
set(gca,'CLim',[0 1])
xlim([xmin xmax])
ylim([ymin ymax])
zlim([zmin zmax])
shading flat
view(-52,12);
text(lon_care,lat_care,'\uparrow',... 
     'HorizontalAlignment','center',...
     'VerticalAlignment','cap',...
     'FontSize',16,'Color',[0 0 1])
 text(lon_king,lat_king,'\uparrow',... 
     'HorizontalAlignment','center',...
     'VerticalAlignment','cap',...
     'FontSize',16,'Color',[1 0 0])
set(gca,'DataAspectRatio',[1 1 10])

 
figure
plot3(coast(:,1),coast(:,2),0.*coast(:,2),'-k')
hold on
plot3(bound(:,1),bound(:,2),0.*bound(:,2),'-k')

lat_care=44.2329;
lon_care=-79.781467;
good=find(data_d3rku_hdr.range(1,:) >= 0);
surface(lon_care+(1/(111.1*cosd(lat_care)))*x_in_d3r(:,good)/1e3,lat_care+(1/111.1)*y_in_d3r(:,good)/1e3,z_in_d3r(:,good)/1e3,double(data_d3rku.differentialphase(:,good)))
good=find(data_d3rku_hdr2.range(1,:) >= 0);
surface(lon_care+(1/(111.1*cosd(lat_care)))*x_in_d3r2(:,good)/1e3,lat_care+(1/111.1)*y_in_d3r2(:,good)/1e3,z_in_d3r2(:,good)/1e3,double(data_d3rku2.differentialphase(:,good)))
set(gca,'CLim',[0 1])
xlim([xmin xmax])
ylim([ymin ymax])
zlim([zmin zmax])
shading flat
view(-52,12);
text(lon_care,lat_care,'\uparrow',... 
     'HorizontalAlignment','center',...
     'VerticalAlignment','cap',...
     'FontSize',16,'Color',[0 0 1])
 text(lon_king,lat_king,'\uparrow',... 
     'HorizontalAlignment','center',...
     'VerticalAlignment','cap',...
     'FontSize',16,'Color',[1 0 0])
set(gca,'DataAspectRatio',[1 1 10])


figure
plot3(coast(:,1),coast(:,2),0.*coast(:,2),'-k')
hold on
plot3(bound(:,1),bound(:,2),0.*bound(:,2),'-k')

lat_care=44.2329;
lon_care=-79.781467;
good=find(data_d3rka_hdr.range(1,:) > 0);
surface(lon_care+(1/(111.1*cosd(lat_care)))*x_in_d3r(:,good)/1e3,lat_care+(1/111.1)*y_in_d3r(:,good)/1e3,z_in_d3r(:,good)/1e3,double(data_d3rka.reflectivity(:,good)))
good=find(data_d3rka_hdr2.range(1,:) > 0);
surface(lon_care+(1/(111.1*cosd(lat_care)))*x_in_d3r2(:,good)/1e3,lat_care+(1/111.1)*y_in_d3r2(:,good)/1e3,z_in_d3r2(:,good)/1e3,double(data_d3rka2.reflectivity(:,good)))
set(gca,'CLim',[-10 30])
xlim([xmin xmax])
ylim([ymin ymax])
zlim([zmin zmax])
shading flat
view(-52,12);
text(lon_care,lat_care,'\uparrow',... 
     'HorizontalAlignment','center',...
     'VerticalAlignment','cap',...
     'FontSize',16,'Color',[0 0 1])
 text(lon_king,lat_king,'\uparrow',... 
     'HorizontalAlignment','center',...
     'VerticalAlignment','cap',...
     'FontSize',16,'Color',[1 0 0])
set(gca,'DataAspectRatio',[1 1 10])


figure
plot3(coast(:,1),coast(:,2),0.*coast(:,2),'-k')
hold on
plot3(bound(:,1),bound(:,2),0.*bound(:,2),'-k')

lat_care=44.2329;
lon_care=-79.781467;
good=find(data_d3rku_hdr.range(1,:) > 0);
surface(lon_care+(1/(111.1*cosd(lat_care)))*x_in_d3r(:,good)/1e3,lat_care+(1/111.1)*y_in_d3r(:,good)/1e3,z_in_d3r(:,good)/1e3,double(data_d3rku.reflectivity(:,good)-data_d3rka.reflectivity(:,good)))
good=find(data_d3rku_hdr.range(1,:) > 0);
surface(lon_care+(1/(111.1*cosd(lat_care)))*x_in_d3r2(:,good)/1e3,lat_care+(1/111.1)*y_in_d3r2(:,good)/1e3,z_in_d3r2(:,good)/1e3,double(data_d3rku2.reflectivity(:,good)-data_d3rka2.reflectivity(:,good)))
set(gca,'CLim',[0 10])
xlim([xmin xmax])
ylim([ymin ymax])
zlim([zmin zmax])
shading flat
view(-52,12);
text(lon_care,lat_care,'\uparrow',... 
     'HorizontalAlignment','center',...
     'VerticalAlignment','cap',...
     'FontSize',16,'Color',[0 0 1])
 text(lon_king,lat_king,'\uparrow',... 
     'HorizontalAlignment','center',...
     'VerticalAlignment','cap',...
     'FontSize',16,'Color',[1 0 0])
set(gca,'DataAspectRatio',[1 1 10])


figure
plot3(coast(:,1),coast(:,2),0.*coast(:,2),'-k')
hold on
plot3(bound(:,1),bound(:,2),0.*bound(:,2),'-k')

surface(lon_king+(1/(111.1*cosd(lat_king)))*x_in/1e3,lat_king+(1/111.1)*y_in/1e3,z_in/1e3,double(data_wkr.DBZ_TOT))
set(gca,'CLim',[-10 30])
xlim([xmin xmax])
ylim([ymin ymax])
zlim([zmin zmax])
shading flat
view(-52,12);
text(lon_care,lat_care,'\uparrow',... 
     'HorizontalAlignment','center',...
     'VerticalAlignment','cap',...
     'FontSize',16,'Color',[0 0 1])
 text(lon_king,lat_king,'\uparrow',... 
     'HorizontalAlignment','center',...
     'VerticalAlignment','cap',...
     'FontSize',16,'Color',[1 0 0])
set(gca,'DataAspectRatio',[1 1 10])
shading interp


figure
plot3(coast(:,1),coast(:,2),0.*coast(:,2),'-k')
hold on
plot3(bound(:,1),bound(:,2),0.*bound(:,2),'-k')


surface(lon_king+(1/(111.1*cosd(lat_king)))*x_in/1e3,lat_king+(1/111.1)*y_in/1e3,z_in/1e3,double(data_wkr.ZDR))
set(gca,'CLim',[-1 3])
xlim([xmin xmax])
ylim([ymin ymax])
zlim([zmin zmax])
shading flat
view(-52,12);
text(lon_care,lat_care,'\uparrow',... 
     'HorizontalAlignment','center',...
     'VerticalAlignment','cap',...
     'FontSize',16,'Color',[0 0 1])
 text(lon_king,lat_king,'\uparrow',... 
     'HorizontalAlignment','center',...
     'VerticalAlignment','cap',...
     'FontSize',16,'Color',[1 0 0])
set(gca,'DataAspectRatio',[1 1 10])

figure
plot3(coast(:,1),coast(:,2),0.*coast(:,2),'-k')
hold on
plot3(bound(:,1),bound(:,2),0.*bound(:,2),'-k')
shading interp


surface(lon_king+(1/(111.1*cosd(lat_king)))*x_in/1e3,lat_king+(1/111.1)*y_in/1e3,z_in/1e3,double(data_wkr.RHOHV))
set(gca,'CLim',[.6 1])
xlim([xmin xmax])
ylim([ymin ymax])
zlim([zmin zmax])
shading flat
view(-52,12);
text(lon_care,lat_care,'\uparrow',... 
     'HorizontalAlignment','center',...
     'VerticalAlignment','cap',...
     'FontSize',16,'Color',[0 0 1])
 text(lon_king,lat_king,'\uparrow',... 
     'HorizontalAlignment','center',...
     'VerticalAlignment','cap',...
     'FontSize',16,'Color',[1 0 0])
set(gca,'DataAspectRatio',[1 1 10])

figure
plot3(coast(:,1),coast(:,2),0.*coast(:,2),'-k')
hold on
plot3(bound(:,1),bound(:,2),0.*bound(:,2),'-k')
shading interp

surface(lon_king+(1/(111.1*cosd(lat_king)))*x_in/1e3,lat_king+(1/111.1)*y_in/1e3,z_in/1e3,double(data_wkr.PHIDP))
set(gca,'CLim',[.6 1])
xlim([xmin xmax])
ylim([ymin ymax])
zlim([zmin zmax])
shading flat
view(-52,12);
text(lon_care,lat_care,'\uparrow',... 
     'HorizontalAlignment','center',...
     'VerticalAlignment','cap',...
     'FontSize',16,'Color',[0 0 1])
 text(lon_king,lat_king,'\uparrow',... 
     'HorizontalAlignment','center',...
     'VerticalAlignment','cap',...
     'FontSize',16,'Color',[1 0 0])
set(gca,'DataAspectRatio',[1 1 10])
shading interp
end

