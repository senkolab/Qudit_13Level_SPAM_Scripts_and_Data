%Script for plotting transition strength figure in the manuscript.
Misc_Calculate_SD_TransitionStrengths_Ba137;
B_ind = find(B_e_array==8.35);
p = nan(1,size(E_array_D52,1));

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

%pi_times = [64 56 38 30 37 152 185 203 65 87 100 104 210];
pi_times = [63.0073 54.9037 37.4828 29.6647 37.2038 151.1882 188.3022 204.7875 64.0586 87.3040 104.4574 105.3720 214.6385];
pi_times_error = [0.3177 0.3052 0.2345 0.2658 0.3190 0.4263 0.6720 0.8499 0.3181 0.3274 0.5118 0.4078 1.1280];
Rabi_freqs_prop = 1./pi_times;
Rabi_freqs_prop_error = pi_times_error.*Rabi_freqs_prop.*Rabi_freqs_prop;
Exp_ind = [5 6 7 8 9 13 14 15 19 20 21 23 24];
Sim_Trans_Strengths = [abs(TransitionStrength(8,Exp_ind,B_ind))];
Trans_Freqs = E_array_D52(Exp_ind,B_ind);
Rabi_freqs_prop_error = mean(Sim_Trans_Strengths).*Rabi_freqs_prop_error./mean(Rabi_freqs_prop);
Rabi_freqs_prop = mean(Sim_Trans_Strengths).*Rabi_freqs_prop./mean(Rabi_freqs_prop);
p(h+1) = plot(Trans_Freqs,Rabi_freqs_prop,'ok');
Rabi_freq_F3m3 = (1/2000)*mean(Sim_Trans_Strengths)/mean(Rabi_freqs_prop);
p(h+2) =  plot(E_array_D52(16,B_ind),Rabi_freq_F3m3,'or');

xlabel('Transition frequency - f_0 / MHz','fontsize',16);
ylabel({'Relative'; 'transition'; 'strength'},'fontsize',16);
set(gcf,'Position',[0 0 900 170])
axis([-50 150 0 0.3])
l = legend(p([9 16 21 24 h+1]),'$\tilde{F}=4$','$\tilde{F}=3$','$\tilde{F}=2$','$\tilde{F}=1$','Empirical data','location','eastoutside','fontsize',14);
set(gca,'fontsize',14);
set(l,'interpreter','latex');
box on

pdfFilepath = 'C:\Users\pj3low\Documents\Qudit-Measurement-Paper_2022\Figures\';
pdffilename = 'TransitionStrengthsPlot.pdf';