%Script for estimating the pi pulse errors and pi pulse times from Rabi
%flopping time scans 1762 nm transitions of Ba-137+, collected on 20221205.
%The start state is the 6S_1/2 F=2, m_F=2 state.
%The dataset is hard-coded via Filepath.
%
%Output definition:
%Error_pi: A 1D array of estimated pi-pulse errors for transitions to the
%5D_5/2 level, sorted in the order from \tilde{F}=4, m_{\tilde{F}} = 4 to
%0, then \tilde{F}=3, m_{\tilde{F}} = 2 to 0, then \tilde{F}=2, 
%m_{\tilde{F}} = 2 to 0, and finally \tilde{F}=1, m_{\tilde{F}} = 1
%
%Error_pi_error: A 1D array of the uncertainty of the estimated pi-pulse
%errors from the functional fit in Error_pi.
%
%pi_times: A 1D array of the estimated pi-pulse times. Same sort order as
%Error_pi.

Filepath = '..\..\Data\Rabi_Flop_Scans_D52_Ba137\'; %Set directory which contains the data files.
dirfiles = dir([Filepath 'Shelving*']); %Data filenames start with 'Shelving'.
time = 0:1:500; %Pulse times in us.

%Initialize output arrays
Error_pi = nan(1,numel(dirfiles));
Error_pi_error = nan(1,numel(dirfiles));
pi_times = nan(1,numel(dirfiles));

for file_ind = 1:numel(dirfiles)
    filename = dirfiles(file_ind).name; %extract the filename of a single file from dirfiles, required to run Misc_Get_Shelved_Population.
    Misc_Get_Shelved_Population; %Evaluate data points that are shelved and unshelved, from raw data of photon counts.
    options=optimset('tolfun',1e-14,'tolx',1e-6,'MaxFunEvals',50000,'maxiter',10000); %Set non-linear regression exit criteria.
    
    %Extract the pulse time corresponding to the data point with the first
    %peak in Rabi flopping
    peak_time = time(Pumped_population(time<100) == max(Pumped_population(time<100)));
    peak_time = peak_time(1);
    if peak_time>80
        peak_time = time(Pumped_population == max(Pumped_population));
        peak_time = peak_time(1);
    end
    
    %Set data fit domain to be around the first peak.
    x = time(time>0.5*peak_time & time<1.5*peak_time)';
    y = Pumped_population(time>0.5*peak_time & time<1.5*peak_time);
    
    [BETA,BETA_Err,Exitflag]=Getfunpara(@(P,x) Scaled_cos(P,x),[1 peak_time peak_time 0],x,y,[],[],options);
    Error_pi(file_ind) = 1 - BETA(1) - BETA(4);
    Error_pi_error(file_ind) = BETA_Err(1) - BETA_Err(4);
    pi_times(file_ind) = BETA(3);
end

sort_ind = [13 12 11 10 9 8 7 6 5 4 3 1 2];
Error_pi = Error_pi(sort_ind);
Error_pi_error = Error_pi_error(sort_ind);
pi_times = pi_times(sort_ind);