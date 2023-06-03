%Script for calculating energy eigenvalues and eigenstates of states 
%in 6S_1/2 to 5D_5/2 of Ba-137+ ion. The inputs are hard-coded, with
%magnetic field strength values from 0 to 10 G in steps of 1 mG.
%
%Output definition:
%E_array_S12: A 2-dimensional matrix of 6S_12 energy eigenvalues in MHz.
%The first dimension corresponds to the energy eigenstates in
%the 6S_1/2 level, sorted from the lowest to highest energies at low
%magnetic field strengths, which is \tilde{F}=1, m = 1 to -1, followed by
%\tilde{F}=2, m = -2 to 2. The second dimension corresponds to the
%magnetic field strength, from 0 to 10 G in steps of 1 mG.
%
%eigvectors_array_S12: A 3-dimensional matrix of energy eigenstates of
%6S_1/2 in terms of state amplitudes in the |m_I,m_J> basis. The first
%dimension corresponds to the |m_I,m_J> basis states, expressed as a tensor
%vector of (m_I *tensorproduct* m_J), sorted ascendingly from the lowest
%values of m_I and m_J. The second dimension corresponds to the energy 
%eigenstates in the 6S_1/2 level, sorted from the lowest to highest 
%energies at low magnetic field strengths, which is \tilde{F}=1, m = 1 to 
%-1, followed by \tilde{F}=2, m = -2 to 2. The third dimension corresponds 
%to the magnetic field strength, from 0 to 10 G in steps of 1 mG.
%
%E_array_D52: Same as E_array_S12, but for the 5D_5/2 level.
%eigvectors_array_D52: Same as eigvectors_array_S12, but for the 5D_5/2 
%level.

B_e_array = 0:0.001:10; %Define magnetic field strengths in G.
E_array = nan(24,numel(B_e_array)); %Initialize energy eigenvalues array for 5D-5/2
eigvectors_array = nan(24,24,numel(B_e_array)); %Initialize energy eigenstates array for 5D-5/2
for hh=1:numel(B_e_array)
    if hh>1
        eigvectors_ref = eigvectors;
    end
    [E_levels, eigvectors] = GetHyperfineEnergies(3/2,5/2,2,-12.028,59.533,B_e_array(hh)); %Computes energy eigenvalues and eigenstates for a given B.
    if B_e_array(hh)>0.04 %0.04 Gauss is determined to the a point where the energy eigenvalues have not crossed each other. If B is larger than this value, 
        %a more complex sorting algorithm is used to sort the energy eigenvalues and eigenstates arrays.
        sort_index = nan(24,1);
        E_levels_new = nan(24,1);
        eigvectors_new = nan(size(eigvectors));
        for hhh = 1:24
            max_index = find(abs(eigvectors_ref(:,hhh)'*eigvectors) == max(abs(eigvectors_ref(:,hhh)'*eigvectors)));
            sort_index(hhh) = max_index;
            E_levels_new(hhh) = E_levels(max_index);
            eigvectors_new(:,hhh) = eigvectors(:,max_index);
        end
        E_levels = E_levels_new;
        eigvectors = eigvectors_new;
    else %If B is not larger than 0.04 Gauss, the energy eigenvalues have not crossed and can be simply sorted in ascending order.
        [E_levels_new,sort_index] = sort(E_levels);
        E_levels = E_levels_new;
        eigvectors = eigvectors(:,sort_index);
    end
    E_array(:,hh) = E_levels;
    eigvectors_array(:,:,hh) = eigvectors;
end
E_array_D52 = E_array; %Assign energy eigenvalues to E_array_D52
eigvectors_array_D52 = eigvectors_array; %Assign energy eigenstates to eigvectors_array_D52

%Repeat the same for 6S_1/2
E_array = nan(8,numel(B_e_array));
eigvectors_array = nan(8,8,numel(B_e_array));
for hh=1:numel(B_e_array)
    if hh>1
        eigvectors_ref = eigvectors;
    end
    [E_levels, eigvectors] = GetHyperfineEnergies(3/2,1/2,0,4018.871,0,B_e_array(hh));
    if B_e_array(hh)>0.04
        sort_index = nan(8,1);
        E_levels_new = nan(8,1);
        eigvectors_new = nan(size(eigvectors));
        for hhh = 1:8
            max_index = find(abs(eigvectors_ref(:,hhh)'*eigvectors) == max(abs(eigvectors_ref(:,hhh)'*eigvectors)));
            sort_index(hhh) = max_index;
            E_levels_new(hhh) = E_levels(max_index);
            eigvectors_new(:,hhh) = eigvectors(:,max_index);
        end
        E_levels = E_levels_new;
        eigvectors = eigvectors_new;
    else
        [E_levels_new,sort_index] = sort(E_levels);
        E_levels = E_levels_new;
        eigvectors = eigvectors(:,sort_index);
    end
    E_array(:,hh) = E_levels;
    eigvectors_array(:,:,hh) = eigvectors;
end
E_array_S12 = E_array;
eigvectors_array_S12 = eigvectors_array;