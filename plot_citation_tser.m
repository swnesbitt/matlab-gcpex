function plot_citation_tser
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

clear all
close all

coast=load('gcpex_coastline.dat');
bound=load('gcpex_boundaries.dat');

data=load('20120119_1448_1d_1sec.mat')

wkr_file='C:\Users\admin\Data\gpm\WKR\cf\20120218\cfrad.20120218_130255.701_to_20120218_130258.701_KING_v36_s00_az331.00_RHI.nc';
%wkr_file='C:\Users\admin\Data\gpm\WKR\cf\20120218\cfrad.20120218_120255.836_to_20120218_120258.836_KING_v24_s00_az331.00_RHI.nc';
data_wkr_hdr=read_netcdf_hdr(wkr_file);
data_wkr=read_netcdf_cf_wkr(wkr_file,data_wkr_hdr);


lat_king=data_wkr_hdr.latitude;
lon_king=data_wkr_hdr.longitude;

t1=15.0*60*60;
t2=15.5*60*60;

xmin=-80.1;
xmax=-79.5;

ymin=43.9; 
ymax=44.5;

zmin=0;
zmax=4.5;

in=find(data.MastrLON < 180 & data.RSTem < 300 & data.nevtwc < 10 & data.tsec >= t1 & data.tsec <= t2 & data.lwc100 < 5);

figure
plot3(coast(:,1),coast(:,2),0.*coast(:,2),'-k')
hold on
plot3(bound(:,1),bound(:,2),0.*bound(:,2),'-k')

scatter3(data.MastrLON(in),data.MastrLAT(in),data.Altit(in)/1000,3,data.nevtwc(in))

lat_care=44.2329;
lon_care=-79.781467;
%set(gca,'CLim',[-10 30])
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

scatter3(data.MastrLON(in),data.MastrLAT(in),data.Altit(in)/1000,3,data.lwc100(in))

lat_care=44.2329;
lon_care=-79.781467;
%set(gca,'CLim',[-10 30])
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

bins=-30:2:20;

[YYYY,MO,DY,hh,mm,ss]=jd2date(data.Jday);
frachr=12+24*(data.Jday-floor(data.Jday(1)));
frachr=data.tsec/(60*60);

subplot(3,1,1)

%plot(data.TSEC(in),data.GPS HT(in))
[AX,H1,H2]=plotyy(frachr(in),data.Altit(in),frachr(in),data.RSTem(in))
set(get(AX(1),'Ylabel'),'String','ALTIT (m)') 
set(get(AX(2),'Ylabel'),'String','RSTEM (^{o}C)') 
%set(gca,'Xlim',[20.2 21.6])
%set(get(AX(2),'XLim'),'Float',[20.2 21.6])
%axis(AX(1),[20.2 21.6 0 10000]);
%axis(AX(2),[20.2 21.6 -50 30]);


xlabel('Time (UTC h)')
subplot(3,1,2)

%plot(data.TSEC(in),data.GPS_HT(in))
[AX,H1,H2]=plotyy(frachr(in),data.nevtwc(in),frachr(in),data.lwc100(in))
set(get(AX(1),'Ylabel'),'String','Nevzorov TWC (g/m^3)') 
set(get(AX(2),'Ylabel'),'String','King LWC (g/m^3)') 
%axis(AX(1),[20.2 21.6 -20 20]);
%axis(AX(2),[20.2 21.6 -20 20]);
%set(get(AX(1),'Xlim'),'Float',[20.2 21.6]) 
%set(get(AX(2),'XLim'),'Float',[20.2 21.6]) 
xlabel('Time (UTC h)')

subplot(3,1,3)
%plot(data.TSEC(in),data.GPS_HT(in))
[AX,H1,H2]=plotyy(frachr(in),data.MastrLAT(in),frachr(in),data.MastrLON(in))
set(get(AX(1),'Ylabel'),'String','LAT (deg)') 
set(get(AX(2),'Ylabel'),'String','LON (deg)') 
%set(gca,'Xlim',[20.2 21.6])
%axis(AX(1),[20.2 21.6 min(data.MastrLAT(in)) max(data.MastrLAT(in))]);
%axis(AX(2),[20.2 21.6 min(data.MastrLON(in)) max(data.MastrLON(in))]);


%set(get(AX(1),'Xlim'),'Float',[20.2 21.6]) 
%set(get(AX(2),'XLim'),'Float',[20.2 21.6]) 
xlabel('Time (UTC h)')


end

