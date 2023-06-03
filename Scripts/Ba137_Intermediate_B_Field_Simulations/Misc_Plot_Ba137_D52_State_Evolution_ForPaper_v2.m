%Script for generating and plotting the state evolution of the \tilde{F}, 
%m_{\tilde{F}} energy eigenstate in 5D_5/2 level of Ba-137+ as 
%magnetic field strength increases.
%Magnetic field strength is hard-coded to be from 0 to 10 G in steps of 1
%mG.

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

%Compute overlap of energy eigenstates with each |F,m_F> state.
F4mn4_array = nan(size(eigvectors_array,1)+1,size(eigvectors_array,3));
for h = 1:size(eigvectors_array,3)
    F4mn4_array(1:24,h)=FStates'*eigvectors_array(:,1,h);
end

F4mn3_array = nan(size(eigvectors_array,1)+1,size(eigvectors_array,3));
for h = 1:size(eigvectors_array,3)
    F4mn3_array(1:24,h)=FStates'*eigvectors_array(:,2,h);
end

F4mn2_array = nan(size(eigvectors_array,1)+1,size(eigvectors_array,3));
for h = 1:size(eigvectors_array,3)
    F4mn2_array(1:24,h)=FStates'*eigvectors_array(:,3,h);
end

F4mn1_array = nan(size(eigvectors_array,1)+1,size(eigvectors_array,3));
for h = 1:size(eigvectors_array,3)
    F4mn1_array(1:24,h)=FStates'*eigvectors_array(:,4,h);
end

F4m0_array = nan(size(eigvectors_array,1)+1,size(eigvectors_array,3));
for h = 1:size(eigvectors_array,3)
    F4m0_array(1:24,h)=FStates'*eigvectors_array(:,5,h);
end

F4mp1_array = nan(size(eigvectors_array,1)+1,size(eigvectors_array,3));
for h = 1:size(eigvectors_array,3)
    F4mp1_array(1:24,h)=FStates'*eigvectors_array(:,6,h);
end

F4mp2_array = nan(size(eigvectors_array,1)+1,size(eigvectors_array,3));
for h = 1:size(eigvectors_array,3)
    F4mp2_array(1:24,h)=FStates'*eigvectors_array(:,7,h);
end

F4mp3_array = nan(size(eigvectors_array,1)+1,size(eigvectors_array,3));
for h = 1:size(eigvectors_array,3)
    F4mp3_array(1:24,h)=FStates'*eigvectors_array(:,8,h);
end

F4mp4_array = nan(size(eigvectors_array,1)+1,size(eigvectors_array,3));
for h = 1:size(eigvectors_array,3)
    F4mp4_array(1:24,h)=FStates'*eigvectors_array(:,9,h);
end

F3mn3_array = nan(size(eigvectors_array,1)+1,size(eigvectors_array,3));
for h = 1:size(eigvectors_array,3)
    F3mn3_array(1:24,h)=FStates'*eigvectors_array(:,10,h);
end

F3mn2_array = nan(size(eigvectors_array,1)+1,size(eigvectors_array,3));
for h = 1:size(eigvectors_array,3)
    F3mn2_array(1:24,h)=FStates'*eigvectors_array(:,11,h);
end

F3mn1_array = nan(size(eigvectors_array,1)+1,size(eigvectors_array,3));
for h = 1:size(eigvectors_array,3)
    F3mn1_array(1:24,h)=FStates'*eigvectors_array(:,12,h);
end

F3m0_array = nan(size(eigvectors_array,1)+1,size(eigvectors_array,3));
for h = 1:size(eigvectors_array,3)
    F3m0_array(1:24,h)=FStates'*eigvectors_array(:,13,h);
end

F3mp1_array = nan(size(eigvectors_array,1)+1,size(eigvectors_array,3));
for h = 1:size(eigvectors_array,3)
    F3mp1_array(1:24,h)=FStates'*eigvectors_array(:,14,h);
end

F3mp2_array = nan(size(eigvectors_array,1)+1,size(eigvectors_array,3));
for h = 1:size(eigvectors_array,3)
    F3mp2_array(1:24,h)=FStates'*eigvectors_array(:,15,h);
end

F3mp3_array = nan(size(eigvectors_array,1)+1,size(eigvectors_array,3));
for h = 1:size(eigvectors_array,3)
    F3mp3_array(1:24,h)=FStates'*eigvectors_array(:,16,h);
end

F2mn2_array = nan(size(eigvectors_array,1)+1,size(eigvectors_array,3));
for h = 1:size(eigvectors_array,3)
    F2mn2_array(1:24,h)=FStates'*eigvectors_array(:,17,h);
end

F2mn1_array = nan(size(eigvectors_array,1)+1,size(eigvectors_array,3));
for h = 1:size(eigvectors_array,3)
    F2mn1_array(1:24,h)=FStates'*eigvectors_array(:,18,h);
end

F2m0_array = nan(size(eigvectors_array,1)+1,size(eigvectors_array,3));
for h = 1:size(eigvectors_array,3)
    F2m0_array(1:24,h)=FStates'*eigvectors_array(:,19,h);
end

F2mp1_array = nan(size(eigvectors_array,1)+1,size(eigvectors_array,3));
for h = 1:size(eigvectors_array,3)
    F2mp1_array(1:24,h)=FStates'*eigvectors_array(:,20,h);
end

F2mp2_array = nan(size(eigvectors_array,1)+1,size(eigvectors_array,3));
for h = 1:size(eigvectors_array,3)
    F2mp2_array(1:24,h)=FStates'*eigvectors_array(:,21,h);
end

F1mn1_array = nan(size(eigvectors_array,1)+1,size(eigvectors_array,3));
for h = 1:size(eigvectors_array,3)
    F1mn1_array(1:24,h)=FStates'*eigvectors_array(:,22,h);
end

F1m0_array = nan(size(eigvectors_array,1)+1,size(eigvectors_array,3));
for h = 1:size(eigvectors_array,3)
    F1m0_array(1:24,h)=FStates'*eigvectors_array(:,23,h);
end

F1mp1_array = nan(size(eigvectors_array,1)+1,size(eigvectors_array,3));
for h = 1:size(eigvectors_array,3)
    F1mp1_array(1:24,h)=FStates'*eigvectors_array(:,24,h);
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

Fm_arrays = nan(size(F4mn4_array,1),size(F4mn4_array,2),24);
Fm_arrays(:,:,1) = F4mn4_array;
Fm_arrays(:,:,2) = F4mn3_array;
Fm_arrays(:,:,3) = F4mn2_array;
Fm_arrays(:,:,4) = F4mn1_array;
Fm_arrays(:,:,5) = F4m0_array;
Fm_arrays(:,:,6) = F4mp1_array;
Fm_arrays(:,:,7) = F4mp2_array;
Fm_arrays(:,:,8) = F4mp3_array;
Fm_arrays(:,:,9) = F4mp4_array;
Fm_arrays(:,:,10) = F3mn3_array;
Fm_arrays(:,:,11) = F3mn2_array;
Fm_arrays(:,:,12) = F3mn1_array;
Fm_arrays(:,:,13) = F3m0_array;
Fm_arrays(:,:,14) = F3mp1_array;
Fm_arrays(:,:,15) = F3mp2_array;
Fm_arrays(:,:,16) = F3mp3_array;
Fm_arrays(:,:,17) = F2mn2_array;
Fm_arrays(:,:,18) = F2mn1_array;
Fm_arrays(:,:,19) = F2m0_array;
Fm_arrays(:,:,20) = F2mp1_array;
Fm_arrays(:,:,21) = F2mp2_array;
Fm_arrays(:,:,22) = F1mn1_array;
Fm_arrays(:,:,23) = F1m0_array;
Fm_arrays(:,:,24) = F1mp1_array;

F_nums = [4 3 2 1];

%Plot graphs and save
ind_count = 0;
for F_ind = 1:numel(F_nums)
    for m_ind = -F_nums(F_ind):1:F_nums(F_ind)
        ind_count = ind_count+1;
        p = nan(1,size(Fm_arrays,1)-1);
        pbool = nan(1,size(Fm_arrays,1)-1);
        IsLargeCount = 0;
        Fm_array = Fm_arrays(:,:,ind_count);
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
        l = legend(p(pbool==1),ytlabel{pbool==1},'location','southeast');
        xlabel('Magnetic field strength / Gauss','fontsize',14);
        ylabel('State amplitude');
        axis([0 10 -1 1]);
        pdffilename = ['StateEvol_B_F' num2str(F_nums(F_ind)) 'm' num2str(m_ind) '.pdf'];
        %CustomSaveAsPDF; %This line is commented out as it is a custom
        %script written to save a MATLAB figure as a pdf file. As a
        %reference script, this is unnecessary.
        close all
    end
end