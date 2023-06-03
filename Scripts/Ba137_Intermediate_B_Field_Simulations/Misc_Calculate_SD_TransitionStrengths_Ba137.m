%Script for calculating relative quadrupole transition strengths of states 
%in 6S_1/2 to 5D_5/2 of Ba-137+ ion. The inputs are hard-coded, with
%magnetic field strength values from 0 to 10 G in steps of 1 mG, laser
%angle (relative to B field axis) of 45 degrees, and linear polarization
%angle of 58 degrees.
%
%Output definition:
%TransitionStrength: A 3-dimensional matrix of relative transition
%strengths. The first dimension corresponds to the energy eigenstates in
%the 6S_1/2 level, sorted from the lowest to highest energies at low
%magnetic field strengths, which is \tilde{F}=1, m = 1 to -1, followed by
%\tilde{F}=2, m = -2 to 2. The second dimension corresponds to the energy 
%eigenstates in the 5D_5/2 level, sorted from the lowest to highest 
%energies at low magnetic field strengths, which is \tilde{F}=4, m = -4 to 
%4, then \tilde{F}=3, m = -3 to 3, then \tilde{F}=2, m = -2 to 2, and
%finally \tilde{F}=1, m = -1 to 1. The third dimension corresponds to the
%magnetic field strength, from 0 to 10 G in steps of 1 mG.

Misc_Plot_Ba137_D52_S12_Levels; %Computes the energy eigenvalues and 
%eigenstates of 6S_1/2 and 5D_5/2 levels, from 0 to 10 G in steps of 1 mG.

I_num = -3/2:1:3/2;
J_num_S12 = -1/2:1:1/2;
I_num_S12 = kron(I_num,ones(size(J_num_S12)));
J_num_S12 = kron(ones(size(I_num)),J_num_S12);
J_num_D52 = -5/2:1:5/2;
J_num_D52 = kron(ones(size(I_num)),J_num_D52); %Useful array for indexing later.

[A,J_index,Jm_index,M1_index,M2_index]=GetClebschGordan(1/2,2); %Compute 
%Clebsch-Gordan coefficients table, stored in A, for an angular momentum
%number of J=1/2 and the quadrupole transition of rank k=2. 

k_angle = 45; %Laser angle in degrees.
pol_angle = 58; %Laser polarization angle in degrees.

k_angle = k_angle*pi/180; %Convert to radians.
pol_angle = pol_angle*pi/180; %Convert to radians.

%Define the geometric factors.
geometric_factor = nan(1,5);
geometric_factor(1) = (1/sqrt(6))*abs(0.5*cos(pol_angle)*sin(2*k_angle)+1i*sin(pol_angle)*cos(k_angle));
geometric_factor(2) = (1/sqrt(6))*abs(cos(pol_angle)*cos(2*k_angle)+1i*sin(pol_angle)*cos(k_angle));
geometric_factor(3) = 0.5*abs(cos(pol_angle)*sin(2*k_angle));
geometric_factor(4) = (1/sqrt(6))*abs(-cos(pol_angle)*cos(2*k_angle)+1i*sin(pol_angle)*cos(k_angle));
geometric_factor(5) = (1/sqrt(6))*abs(0.5*cos(pol_angle)*sin(2*k_angle)-1i*sin(pol_angle)*cos(k_angle));

%Initialize TransitionStrength matrix with zeros.
TransitionStrength = zeros(size(eigvectors_array_S12,1),size(eigvectors_array_D52,1),numel(B_e_array));

for S12_ind = 1:size(eigvectors_array_S12,1)
    for D52_ind = 1:size(eigvectors_array_D52,1)
        for pol_ind = -2:1:2
            %Extract relevant Clebsch-Gordan coefficients from A.
            CB_array = nan(8,1);
            CB_array(1:2:end) = A(M1_index==-1/2 & M2_index==pol_ind,J_index==5/2 & Jm_index==-1/2+pol_ind);
            CB_array(2:2:end) = A(M1_index==1/2 & M2_index==pol_ind,J_index==5/2 & Jm_index==1/2+pol_ind);
            CB_array = repmat(CB_array,[1 1 numel(B_e_array)]);
            
            %Compute transition strengths.
            TransitionStrength(S12_ind,D52_ind,:) = TransitionStrength(S12_ind,D52_ind,:)+...
                geometric_factor(3+pol_ind).*sum(eigvectors_array_S12(:,S12_ind,:)...
                .*eigvectors_array_D52(J_num_D52>=-1/2+pol_ind & J_num_D52<=1/2+pol_ind,D52_ind,:)...
                .*CB_array,1);
        end
    end
end