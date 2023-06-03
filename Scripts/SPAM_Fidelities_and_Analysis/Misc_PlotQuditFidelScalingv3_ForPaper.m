%Script for plotting estimated average qudit SPAM fidelity scaling, with
%optimal and worst choices of the transitions for each dimension d.
%File directory and data files are hard-coded.

Filepath = '..\..\Data\SPAM_13Level_Ba137\';
filename = 'D52_13Level_Qudit_SPAM_Run01_20msRepump_StartState*_Raw_001';
Misc_Get_StateFidel;
[fidel_sorted, sort_ind] = sort(diag(Fidel_Seq_Normed));
fidel_sorted = flipud(fidel_sorted);
sort_ind = flipud(sort_ind);

Meas_Sum = sum(State_fidel,1);
Valid_Samples = sum(sum(State_fidel,1),2);
Valid_Samples = Valid_Samples(:);
Valid_Samples = Valid_Samples(sort_ind);
Fidel_Sum = nan(size(Meas_Sum,2),1);
for h = 1:numel(Fidel_Sum)
    Fidel_Sum(h) = Meas_Sum(1,h,h);
end
Fidel_Sum = Fidel_Sum(sort_ind);

figure
hold on
for h=2:13
    fidel = mean(fidel_sorted(1:h));
    fidel_error = sqrt(fidel*(1-fidel)/sum(Valid_Samples(1:h)));
    errorbar(h,fidel,fidel_error,'ok');
    fidel = mean([fidel_sorted(1); fidel_sorted(end-h+2:end)]);
    fidel_error = sqrt(fidel*(1-fidel)/sum([Valid_Samples(1); Valid_Samples(end-h+2:end)]));
    errorbar(h,fidel,fidel_error,'^k');
end
xlabel('Qudit dimension','fontsize',18);
ylabel('Average fidelity','fontsize',18);
l = legend('Optimal choice','Worst choice','location','best');
set(gca,'fontsize',16);
axis([1 14 0.8 1]);
box on

pdfFilepath = 'C:\Users\pj3low\Documents\Qudit-Measurement-Paper_2022\Figures\';
pdffilename = 'QuditScalingv3.pdf';