function read_gcpex_txt
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
path='C:\Users\admin\Data\gpm\cloud_microphyics_Citation\UND_cloud_microphysics\data\UND.gcpex';

files=dir(fullfile(path,'*.gcpex'));

for i=1:length(files)
    
    disp(files(i).name)
    
    data=importpp(fullfile(path,files(i).name));
    
    % baddate=find(tsec >= 86400);
    
    yymmdd=num2str(data(:,45));
    yy=yymmdd(:,1:2);
    mm=yymmdd(:,3:4);
    dd=yymmdd(:,5:6);
    
    YEAR=2000+str2num(yy);
    Mo=str2num(mm);
    Da=str2num(dd);
    
    Jday0=date2jd(YEAR(1),Mo(1),Da(1),0,0,0);
    
    %
    % dechr=24*(data(:,1)/86400.);
    % hr=floor(dechr);
    % if ~isempty(
    % decmi=60*(dechr-hr);
    % mi=floor(decmi);
    % decss=60*(decmi-mi);
    % ss=floor(decss);
    
    d2r=pi()/180.;
    
    v=-cosd(data(:,29)*d2r).*data(:,28);
    u=-sind(data(:,29)*d2r).*data(:,28);
    
    tsec=data(:,1);
    
    hh=floor(tsec/(60*60));
    mm=floor(tsec/(60))-(hh*60);
    
    Jday = Jday0+(tsec/(60*60*24));
    MastrLAT=data(:,19);
    MastrLON=data(:,20);
    Altit=data(:,21);
    GPS_HT=-99999.+data(:,1)*0.;
    TRTAlt=-99999.+data(:,1)*0.;
    NPres=data(:,10);
    RSTem=data(:,2);
    theta=data(:,7);
    Licort=-99999.+data(:,1)*0.;
    Licorp=-99999.+data(:,1)*0.;
    DewPt=data(:,11);
    mr=data(:,12);
    fp=data(:,14);
    ReHuW=-99999.+data(:,1)*0.;
    rlwc=-99999.+data(:,1)*0.;
    lwc100=data(:,31);
    pvmlwc=-99999.+data(:,1)*0.;
    pvmre_c=-99999.+data(:,1)*0.;
    pvmpsa=-99999.+data(:,1)*0.;
    plwcf_ibl=-99999.+data(:,1)*0.;
    nevlwc=data(:,33);
    nevtwc=data(:,32);
    cdplwc_NRB=data(:,35);
    cdpnc=data(:,34);
    cdpmdd=data(:,36);
    cdpmvd=data(:,37);
    cdpedr=data(:,38);
    p2dcnc=data(:,39);
    p2dcmdd=data(:,40);
    p2dcmvd=data(:,41);
    p2dcedr=data(:,42);
    idfreq=data(:,43);
    cpcnc=data(:,44);
    hthead=data(:,17);
    hpitch=data(:,16);
    hroll=data(:,15);
    hpitchr=-99999.+data(:,1)*0.;
    hrollr=-99999.+data(:,1)*0.;
    hyawr=-99999.+data(:,1)*0.;
    hu=u;
    hv=v;
    hw=data(:,27);
    halpha=data(:,24);
    hbeta=data(:,25);
    hw2s=data(:,26);
    hwac=data(:,28);
    tas=data(:,5);
    
    clear data u v
    
    hh0=sprintf('%02d', hh(1));
    mm0=sprintf('%02d', mm(1));

    
    save(['20' yymmdd(1,:) '_' hh0 mm0 '_1d_1sec.mat'],'Jday','tsec','MastrLAT','MastrLON','Altit','GPS_HT','TRTAlt','NPres','RSTem','theta','Licort','Licorp','DewPt','mr','fp','ReHuW','rlwc','lwc100','pvmlwc','pvmre_c','pvmpsa','plwcf_ibl','nevlwc','nevtwc','cdplwc_NRB','cdpnc','cdpmdd','cdpmvd','cdpedr','p2dcnc','p2dcmdd','p2dcmvd','p2dcedr','idfreq','cpcnc','hthead','hpitch','hroll','hpitchr','hrollr','hyawr','hu','hv','hw','halpha','hbeta','hw2s','hwac','tas');
    
end

end

