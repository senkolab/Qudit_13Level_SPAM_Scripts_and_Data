%Script for plotting a 3D bar of Ba-137+ 13-level qudit SPAM measurement
%probabilities.
%The directory and filenames are hard-coded.

Filepath = '..\..\Data\SPAM_13Level_Ba137\';
filename = 'D52_13Level_Qudit_SPAM_Run01_20msRepump_StartState*_Raw_001';
Misc_Get_StateFidel;
set(groot,'defaultAxesTickLabelInterpreter','default');  
figure
b = bar3(Fidel_Seq_Normed);

for k = 1:length(b)
    zdata = b(k).ZData;
    b(k).CData = zdata;
    b(k).FaceColor = 'interp';
end

xlabel('Measured state','fontsize',18);
ylabel('Prepared state','fontsize',18);
zlabel('Measurement probability','fontsize',18);
set(gca,'xticklabel',0:12);
set(gca,'yticklabel',0:12);
set(gca,'fontsize',12);

ticklabel = {'$\lvert 0 \rangle$'; '$\lvert 1 \rangle$'; '$\lvert 2 \rangle$';...
    '$\lvert 3 \rangle$'; '$\lvert 4 \rangle$'; '$\lvert 5 \rangle$';...
    '$\lvert 6 \rangle$'; '$\lvert 7 \rangle$'; '$\lvert 8 \rangle$';...
    '$\lvert 9 \rangle$'; '$\lvert 10 \rangle$'; '$\lvert 11 \rangle$';
    '$\lvert 12 \rangle$'};

pdfFilepath = 'C:\Users\pj3low\Documents\Qudit-Measurement-Paper_2022\Figures\';
pdffilename = 'Fidel3DBarPlot.pdf';