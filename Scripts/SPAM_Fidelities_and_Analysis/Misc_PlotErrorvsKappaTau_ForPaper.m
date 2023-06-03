%Script for plotting post-selected SPAM error vs kappa^2*tau_pi^2 and
%perform the error functional fit.

BfieldSensitivity = [2.7992 1.1202 -0.3554 -1.7009 -2.9234 1.705 0.5718 -0.5672 2.0094 0.3026 -1.3707 -0.7373];
PiPulseTime = [37.2038 29.6647 37.4828 54.9037 63.0073 204.7875 188.3022 151.1882 104.4574 87.3040 64.0586 105.3720];
Filepath = '..\..\Data\SPAM_13Level_Ba137\';
filename = 'D52_13Level_Qudit_SPAM_Run01_20msRepump_StartState*_Raw_001';
Misc_Get_StateFidel;
Error = 1-diag(Fidel_Seq_Normed);
Error(1) = [];
Error = Error';
Valid_Samples = sum(sum(State_fidel,1),2);
Valid_Samples = Valid_Samples(:);
Valid_Samples(1) = [];
Valid_Samples = Valid_Samples';
Error_errorbar = sqrt(Error.*(1-Error)./Valid_Samples);
x = abs(BfieldSensitivity.*BfieldSensitivity.*PiPulseTime.*PiPulseTime);
x_plot = linspace(0,max(x),10000);
[BETA,BETA_Err,Exitflag]=Getfunpara(@(P,x) Error_fun(P,x),[1/10000 0],x,Error);

figure
errorbar(x,Error,Error_errorbar,'ok');
hold on
plot(x_plot,Error_fun(BETA,x_plot),'k');
axis([0 140000 0 0.36]);
xlabel('\kappa^2 \tau_{\pi}^2 / MHz^2 µs^2 G^{-2}','interpreter','default','fontsize',18);
ylabel([char(949) '_{SPAM}'],'interpreter','default','fontsize',18);
l = legend('Data points','Functional fit','location','southeast');
set(gca,'fontsize',16);
box on

pdfFilepath = 'C:\Users\pj3low\Documents\Qudit-Measurement-Paper_2022\Figures\';
pdffilename = 'Errorvsktausquared_20221205.pdf';