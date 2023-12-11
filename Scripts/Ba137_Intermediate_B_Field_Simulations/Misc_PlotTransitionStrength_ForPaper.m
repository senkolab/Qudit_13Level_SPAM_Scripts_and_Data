%Script for plotting transition strength figure in the manuscript.
Misc_Calculate_SD_TransitionStrengths_Ba137; %Calculate the relative transition strengths.
B_ind = find(B_e_array==8.35);
p = nan(1,size(E_array_D52,1));

%Plot the simulated relative transition strengths from the S1/2, F=2, m=2
%state.
figure
hold on
for h = 1:size(E_array_D52,1)
    if h<=9
        if abs(TransitionStrength(8,h,B_ind))>1e-10
            p(h)=plot([E_array_D52(h,B_ind) E_array_D52(h,B_ind)],[0 abs(TransitionStrength(8,h,B_ind))],'k','linewidth',2);
        end
    elseif h>9 && h<=16
        if abs(TransitionStrength(8,h,B_ind))>1e-10
            p(h)=plot([E_array_D52(h,B_ind) E_array_D52(h,B_ind)],[0 abs(TransitionStrength(8,h,B_ind))],'r','linewidth',2);
        end
    elseif h>16 && h<=21
        if abs(TransitionStrength(8,h,B_ind))>1e-10
            p(h)=plot([E_array_D52(h,B_ind) E_array_D52(h,B_ind)],[0 abs(TransitionStrength(8,h,B_ind))],'b','linewidth',2);
        end
    else
        if abs(TransitionStrength(8,h,B_ind))>1e-10
            p(h)=plot([E_array_D52(h,B_ind) E_array_D52(h,B_ind)],[0 abs(TransitionStrength(8,h,B_ind))],'g','linewidth',2);
        end
    end
end

%Empirically estimated pi-pulse times and their errors.
pi_times = [63.0073 54.9037 37.4828 29.6647 37.2038 151.1882 188.3022 204.7875 64.0586 87.3040 104.4574 105.3720 214.6385];
pi_times_error = [0.3177 0.3052 0.2345 0.2658 0.3190 0.4263 0.6720 0.8499 0.3181 0.3274 0.5118 0.4078 1.1280];

%Calculated scaled Rabi frequencies from the pi-pulse times.
Rabi_freqs_prop = 1./pi_times;
Rabi_freqs_prop_error = pi_times_error.*Rabi_freqs_prop.*Rabi_freqs_prop;

%Index for picking the relevant transitions from the simulation result
%matrix.
Exp_ind = [5 6 7 8 9 13 14 15 19 20 21 23 24];
%Extract the simulated transition strengths from the matrix as a 1D array.
Sim_Trans_Strengths = [abs(TransitionStrength(8,Exp_ind,B_ind))];
Trans_Freqs = E_array_D52(Exp_ind,B_ind);
%Scale the empirically estimated Rabi frequencies to the simulated relative
%transition strengths and calculate the errors correspondingly.
Rabi_freqs_prop_error = mean(Sim_Trans_Strengths).*Rabi_freqs_prop_error./mean(Rabi_freqs_prop);
Rabi_freqs_prop = mean(Sim_Trans_Strengths).*Rabi_freqs_prop./mean(Rabi_freqs_prop);

%Plot the empirical data points as markers.
p(h+1) = plot(Trans_Freqs,Rabi_freqs_prop,'ok');
Rabi_freq_F3m3 = (1/2000)*mean(Sim_Trans_Strengths)/mean(Rabi_freqs_prop);
p(h+2) =  plot(E_array_D52(16,B_ind),Rabi_freq_F3m3,'or');

%Label and resize figure.
xlabel('Transition frequency - f_0 [MHz]','fontsize',16);
ylabel({'Relative'; 'transition'; 'strength'},'fontsize',16);
set(gcf,'Position',[0 0 470 310])
axis([-50 150 0 sqrt(3/2)*0.3])
l = legend(p([9 16 21 24 h+1]),'$\tilde{F}=4$','$\tilde{F}=3$','$\tilde{F}=2$','$\tilde{F}=1$','Empirical data','location','northeast','fontsize',14);
set(gca,'fontsize',14);
set(l,'interpreter','latex');
box on

pdfFilepath = 'C:\Users\pj3low\Documents\Qudit-Measurement-Paper_2022\Figures\';
pdffilename = 'TransitionStrengthsPlot.pdf';