%Plots Ramsey time delay experiments for S1/2 to D5/2 transitions of
%Ba-137. Data collected on 20221111. Decaying sine is used to fit the data.

%Define filepath and filenames for the data to be imported.
Filepath = '..\..\Data\Ramsey_Time_Scans\'; %Set directory which contains the data files.
Filepath = 'Z:\Lab Data\Sessions\2022\2022_11\2022_11_11\Ramsey_Time_Scan_Ba137\';
files_list = dir([Filepath '*0-2-1000usRamseyTime*001*']);

%Time steps for the data points.
time = 0:2:1000;

%State labels, only used for saving figure.
States = {'F1m1'; 'F1m0'; 'F2m2'; 'F2m1'; 'F2m0'; 'F4m4'; 'F3m2'; 'F4m3';...
    'F3m1'; 'F4m2'; 'F3m0'; 'F4m1'; 'F4m0'};

%Output path of figures.
pdfFilepath = 'C:\Users\pj3low\Documents\Qudit-Measurement-Paper_2022\Figures\';

for fileindex = 1:numel(files_list)
    %New figure window.
    fg = figure;
    
    %Select filename from the list of files, needed for
    %Misc_Get_Shelved_Population.
    filename = files_list(fileindex).name;
    
    %Determine photon count threshold dynamically and determine dark state
    %probability.
    Misc_Get_Shelved_Population;
    
    %Plot empirical data points with error bars.
    errorbar(time,mean(Pumped_population,2),sqrt((1-mean(Pumped_population,2)).*mean(Pumped_population,2)./(100*size(Pumped_population,2))),'o-','linewidth',1)
    hold on
    
    %Fit data to a decaying sine curve.
    [BETA,BETA_Err,Exitflag]=Getfunpara(@(P,time) Decay_sin(P,time),[-1 100 500 pi/2],time',mean(Pumped_population,2),[],[],options);
    
    %Plot fit curve.
    plot(time,Decay_sin(BETA,time),'linewidth',2);
    
    %Label and resize figure.
    axis([0 1000 0 1])
    xlabel('Time [µs]','interpreter','default','fontsize',24);
    ylabel('Dark state probability','fontsize',24);
    set(gca,'fontsize',21);
    textstring_eq = '$P(D) = Asin(t/\tau_R + \phi)exp(-t/T_2) + A/2$';
    textstring_param = ['$T_2 = \,' num2str(round(BETA(3),-floor(log10(BETA_Err(3))))) '\pm' num2str(round(BETA_Err(3),-floor(log10(BETA_Err(3))))) '\, \mu s$'];
    tb = PlotText(30,90,{textstring_param});
    pdffilename = ['RamseyTimeScan' States{fileindex} '.pdf'];
    %CustomSaveAsPDF; %Custom written code for saving figure as pdf. Not used as a reference code.
    %close(fg);
end