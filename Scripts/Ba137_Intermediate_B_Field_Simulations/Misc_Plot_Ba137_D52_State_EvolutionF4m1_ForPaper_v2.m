%Script for generating and plotting the state evolution of the \tilde{F} =
%4, m_{\tilde{F}} = 1 energy eigenstate in 5D_5/2 level of Ba-137+ as 
%magnetic field strength increases.
%Magnetic field strength is hard-coded to be from 0 to 10 G in steps of 1
%mG.

set(groot,'defaulttextinterpreter','default');
set(groot,'defaultLegendInterpreter','default');
set(groot,'defaultAxesTickLabelInterpreter','default'); 

Misc_Plot_Ba137_D52_S12_Levels; %Compute 6S_1/2 and 5D_5/2 energy eigenvalues and eigenstates.

eigvectors_array = eigvectors_array_D52;

Misc_Get_FmF_CB_Coeffs; %Generate |F,m_F> states for 5D_5/2 level, in the |m_I,m_J> basis.

%The eigenvectors obtained from MATLAB's eig solver can have sign flip
%differences. The following regulates the signs to the |F, m_F> basis
%states.
for h = 2:size(eigvectors_array,3)
    for hh = 1:size(eigvectors_array,2)
        if h==2
            eigvector_sign_flip = FStates(:,hh)'*eigvectors_array(:,hh,h);
        else
            eigvector_sign_flip = eigvectors_array(:,hh,h-1)'*eigvectors_array(:,hh,h);
        end
        eigvectors_array(:,hh,h) = sign(eigvector_sign_flip).*eigvectors_array(:,hh,h);
    end
end

ytlabel = {'F = 4, m_F = -4';'F = 4, m_F = -3';...
    'F = 4, m_F = -2';'F = 4, m_F = -1';'F = 4, m_F = 0';...
    'F = 4, m_F = 1';'F = 4, m_F = 2';'F = 4, m_F = 3';...
    'F = 4, m_F = 4';'F = 3, m_F = -3';'F = 3, m_F = -2';...
    'F = 3, m_F = -1';'F = 3, m_F = 0';'F = 3, m_F = 1';...
    'F = 3, m_F = 2';'F = 3, m_F = 3';'F = 2, m_F = -2';...
    'F = 2, m_F = -1';'F = 2, m_F = 0';'F = 2, m_F = 1';...
    'F = 2, m_F = 2';'F = 1, m_F = -1';'F = 1, m_F = 0';...
    'F = 1, m_F = 1';};

%Compute overlap of energy eigenstates with each |F,m_F> state.
F4mp1_array = nan(size(eigvectors_array,1)+1,size(eigvectors_array,3));
for h = 1:size(eigvectors_array,3)
    F4mp1_array(1:24,h)=FStates'*eigvectors_array(:,6,h);
end

Fm_array = F4mp1_array;
p = nan(1,size(F4mp1_array,1)-1);
pbool = nan(1,size(F4mp1_array,1)-1);
IsLargeCount = 0;
figure
hold on
for h=1:numel(p)
    IsLarge = abs(Fm_array(h,end))>0.001;
    pbool(h) = IsLarge;
    IsLargeCount = IsLargeCount + IsLarge;
    if ~IsLarge
        %p(h) = plot(B_e_array(2:end),Fm_array(h,2:end),'r','linewidth',2);
    elseif IsLargeCount == 1
        p(h) = plot(B_e_array(2:end),Fm_array(h,2:end),'k','linewidth',2);
    elseif IsLargeCount == 2
        p(h) = plot(B_e_array(2:end),Fm_array(h,2:end),'k--','linewidth',2);
    elseif IsLargeCount == 3
        p(h) = plot(B_e_array(2:end),Fm_array(h,2:end),'k-.','linewidth',2);
    elseif IsLargeCount == 4
        p(h) = plot(B_e_array(2:end),Fm_array(h,2:end),'k:','linewidth',2);
    end
end
l = legend(p(pbool==1),ytlabel{pbool==1},'location','best','fontsize',16);
pos = get(l,'Position');
set(l,'Position',[0.58 0.32 pos(3) pos(4)]);
xlabel('Magnetic field strength / Gauss','fontsize',18);
ylabel('State amplitude','fontsize',18);
title('$\tilde{F}=4, m_{\tilde{F}}=1$','interpreter','latex','fontsize',18);
axis([0 10 0 1]);
set(gca,'fontsize',16);
box on

pdfFilepath = 'C:\Users\pj3low\Documents\Qudit-Measurement-Paper_2022\Figures\';
pdffilename = 'StateEvolutionF4m1.pdf';