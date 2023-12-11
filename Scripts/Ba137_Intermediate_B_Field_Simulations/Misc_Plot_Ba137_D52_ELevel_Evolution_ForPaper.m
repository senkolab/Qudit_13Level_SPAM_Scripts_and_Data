Misc_Plot_Ba137_D52_S12_Levels; %Generate energy eigenvalues from the Hamiltonian
figure

%Compute the offset to shift the zero energy reference to F=4 at 0 G.
offset = min(E_array_D52(:,1)-repmat(E_array_S12(end,1),[size(E_array_D52,1) 1])); 

%Plot the S1/2, F=2, m=2 to D5/2 transition energy levels with color-coded
%lines.
plot(B_e_array,E_array_D52(1:9,:)-repmat(E_array_S12(end,:),[9 1]) - offset,'k');
hold on
plot(B_e_array,E_array_D52(10:16,:)-repmat(E_array_S12(end,:),[7 1]) - offset,'r');
plot(B_e_array,E_array_D52(17:21,:)-repmat(E_array_S12(end,:),[5 1]) - offset,'b');
plot(B_e_array,E_array_D52(22:24,:)-repmat(E_array_S12(end,:),[3 1]) - offset,'g');
Ax = axis;

%Plot the empirically measured frequencies as horizontal lines.
Measured_freqs = -[457.869 481.43 528.771 542.483 555.877 584.251 592.25 598.091 601.151 609.91 610.385 620.689 630.59];
Measured_freqs_shifted = Measured_freqs - max(Measured_freqs) + E_array_D52(end,8351) - E_array_S12(end,8351) - offset;
for h = 1:numel(Measured_freqs_shifted)
    plot([0 10],[Measured_freqs_shifted(h) Measured_freqs_shifted(h)],':k');
end

plot([8.35 8.35],[Ax(3) Ax(4)],'--k'); %Marks the optimal intercept of the 
%simulated and empirically measured transition lines.

xlabel('Magnetic field strength [Gauss]','fontsize',16);
ylabel('Transition frequency - f_0 [MHz]','fontsize',16);
set(gca,'fontsize',14);
set(gcf,'Position',[680   558   600   320]);

pdfFilepath = 'C:\Users\pj3low\Documents\Qudit-Measurement-Paper_2022\Figures\';
pdffilename = 'TransitionFreq_vs_B_Sim_Ba137.pdf';