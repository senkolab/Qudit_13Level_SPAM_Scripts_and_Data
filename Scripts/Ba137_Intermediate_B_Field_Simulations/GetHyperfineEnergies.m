function [eigvalues,eigvectors] = GetHyperfineEnergies(I_num,J_num,L_num,A_const,B_const,C_const,B_e)
%A function to calculate energy eigenvalues and eigenvectors of a hyperfine
%splitting Hamiltonian, by solving the Hamiltonian numerically. Includes
%contribution from magnetic dipole and electric quadrupole.
%
%Output definition:
%eigvalues: A 1D array of energy eigenvalues.
%
%eigvectors: A 2D array of energy eigenstates. The first dimension 
%corresponds to the |m_I,m_J> basis states, expressed as a tensor vector of
%(m_I *tensorproduct* m_J), sorted ascendingly from the lowest values of 
%m_I and m_J.
%
%Input definition:
%I_num: A scalar number, representing the nuclear spin number.
%
%J_num: A scalar number, representing the electronic angular momentum 
%number.
%
%L_num: A scalar number, representing the orbital angular momentum 
%number.
%
%A_const: A scalar number, representing the magnetic dipole hyperfine
%structure constant in MHz.
%
%B_const: A scalar number, representing the electric quadrupole hyperfine
%structure constant in MHz.
%
%C_const: A scalar number, representing the octupole hyperfine
%structure constant in MHz.
%
%B_e: A scalar number, representing the magnetic field strength in Gauss.

u_Bohr = 9.2740100783*10^(-28); %Bohr magneton in SI units.
Plank_h = 6.62607015*10^(-34); %Planck constant in SI units.

g_J = 1 + (J_num*(J_num + 1) + (1/2)*(1/2 + 1) - L_num*(L_num + 1))/(2*J_num*(J_num + 1)); %g_J factor.
g_I = 0; %Valid assumption for g_I<<g_J.

%Define an array of m_I values, in ascending order.
I_m_array = nan(1,2*I_num+1);
for h = 1:(2*I_num+1)
    I_m_array(h) = -I_num + h - 1;
end

%Define the I_+ operator, the raising operator for nuclear spin.
I_plus = diag(ones(2*I_num,1),-1);
for h = 1:(2*I_num+1)
    I_plus(:,h) = sqrt(I_num*(I_num+1)-I_m_array(h)*(I_m_array(h)+1)).*I_plus(:,h);
end

%Define the I_- operator, the lowering operator for nuclear spin.
I_minus = diag(ones(2*I_num,1),1);
for h = 1:(2*I_num+1)
    I_minus(:,h) = sqrt(I_num*(I_num+1)-I_m_array(h)*(I_m_array(h)-1)).*I_minus(:,h);
end

I_z = diag(I_m_array); %Define the I_z array.

I_Iden = diag(ones(2*I_num+1,1)); %Define the identity operator for nuclear spin.

%Repeat the same for electronic angular momentum, J.
J_m_array = nan(1,2*J_num+1);
for h = 1:(2*J_num+1)
    J_m_array(h) = -J_num + h - 1;
end

J_plus = diag(ones(2*J_num,1),-1);
for h = 1:(2*J_num+1)
    J_plus(:,h) = sqrt(J_num*(J_num+1)-J_m_array(h)*(J_m_array(h)+1)).*J_plus(:,h);
end

J_minus = diag(ones(2*J_num,1),1);
for h = 1:(2*J_num+1)
    J_minus(:,h) = sqrt(J_num*(J_num+1)-J_m_array(h)*(J_m_array(h)-1)).*J_minus(:,h);
end

J_z = diag(J_m_array);

J_Iden = diag(ones(2*J_num+1,1));

%Define dot product of I and J angular momentum vectors, which is I_xJ_x +
%I_yJ_y + I_zJ_z
IdotJ = (1/4).*kron(I_plus + I_minus, J_plus + J_minus)...
    - (1/4).*kron(I_plus - I_minus, J_plus - J_minus)...
    + kron(I_z,J_z);

%Construct hyperfine splitting Hamiltonian

if C_const~=0
    H = A_const.*IdotJ...
        + (B_const/(2*I_num*(2*I_num-1)*J_num*(2*J_num-1))).*...
        (3.*IdotJ*IdotJ + (3/2).*IdotJ - (I_num*(I_num+1)*J_num*(J_num+1)).*kron(I_Iden,J_Iden))...
        + (C_const/(I_num*(I_num-1)*(2*I_num-1)*J_num*(J_num-1)*(2*J_num-1))).*...
        (10*IdotJ*IdotJ*IdotJ + 20*IdotJ*IdotJ...
        + 2*IdotJ*(I_num*(I_num+1) + J_num*(J_num + 1) + 3 - 3*I_num*(I_num + 1)*J_num*(J_num+1))...
        - 5*I_num*(I_num + 1)*J_num*(J_num + 1))...
        + (10^(-6))*(B_e*u_Bohr/Plank_h).*(g_I.*kron(I_z,J_Iden) + g_J.*kron(I_Iden,J_z));
elseif C_const == 0 && B_const~=0
    H = A_const.*IdotJ +...
        (B_const/(2*I_num*(2*I_num-1)*J_num*(2*J_num-1))).*...
        (3.*IdotJ*IdotJ + (3/2).*IdotJ - (I_num*(I_num+1)*J_num*(J_num+1)).*kron(I_Iden,J_Iden))...
        + (10^(-6))*(B_e*u_Bohr/Plank_h).*(g_I.*kron(I_z,J_Iden) + g_J.*kron(I_Iden,J_z));
else
    H = A_const.*IdotJ +...
        (10^(-6))*(B_e*u_Bohr/Plank_h).*(g_I.*kron(I_z,J_Iden) + g_J.*kron(I_Iden,J_z));
end  

[eigvectors,D] = eig(H); %Solve for Hamiltonian
eigvalues = diag(D);