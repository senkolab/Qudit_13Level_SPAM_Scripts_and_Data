%Script for generating |F,m_F> basis states expressed in terms of the
%|m_I,m_J> basis, for I=3/2 and J=5/2 (hard-coded).
%
%Output definition:
%F(M)m(p/n)(N): A 1D array of state amplitudes of |m_I,m_J> states, which
%make up the |F=M, m_F = p/n N> state, where p and n denotes positive and
%negative respectively. A |m_I,m_J> state is expressed as a tensor
%vector of (m_I *tensorproduct* m_J), sorted ascendingly from the lowest
%values of m_I and m_J.
%
%FStates: A 2D array, which is an aggregation of the F(M)m(p/n)(N) arrays.

[A,J_index,Jm_index,M1_index,M2_index]=GetClebschGordan(3/2,5/2);

F4mn4 = nan(24,1);
ind = 0;
for mI = -3/2:1:3/2
    for mJ = -5/2:1:5/2
        ind = ind + 1;
        F4mn4(ind) = A(M1_index==mI & M2_index==mJ,J_index==4 & Jm_index==-4);
    end
end

F4mn3 = nan(24,1);
ind = 0;
for mI = -3/2:1:3/2
    for mJ = -5/2:1:5/2
        ind = ind + 1;
        F4mn3(ind) = A(M1_index==mI & M2_index==mJ,J_index==4 & Jm_index==-3);
    end
end

F4mn2 = nan(24,1);
ind = 0;
for mI = -3/2:1:3/2
    for mJ = -5/2:1:5/2
        ind = ind + 1;
        F4mn2(ind) = A(M1_index==mI & M2_index==mJ,J_index==4 & Jm_index==-2);
    end
end

F4mn1 = nan(24,1);
ind = 0;
for mI = -3/2:1:3/2
    for mJ = -5/2:1:5/2
        ind = ind + 1;
        F4mn1(ind) = A(M1_index==mI & M2_index==mJ,J_index==4 & Jm_index==-1);
    end
end

F4m0 = nan(24,1);
ind = 0;
for mI = -3/2:1:3/2
    for mJ = -5/2:1:5/2
        ind = ind + 1;
        F4m0(ind) = A(M1_index==mI & M2_index==mJ,J_index==4 & Jm_index==0);
    end
end

F4mp1 = nan(24,1);
ind = 0;
for mI = -3/2:1:3/2
    for mJ = -5/2:1:5/2
        ind = ind + 1;
        F4mp1(ind) = A(M1_index==mI & M2_index==mJ,J_index==4 & Jm_index==1);
    end
end

F4mp2 = nan(24,1);
ind = 0;
for mI = -3/2:1:3/2
    for mJ = -5/2:1:5/2
        ind = ind + 1;
        F4mp2(ind) = A(M1_index==mI & M2_index==mJ,J_index==4 & Jm_index==2);
    end
end

F4mp3 = nan(24,1);
ind = 0;
for mI = -3/2:1:3/2
    for mJ = -5/2:1:5/2
        ind = ind + 1;
        F4mp3(ind) = A(M1_index==mI & M2_index==mJ,J_index==4 & Jm_index==3);
    end
end

F4mp4 = nan(24,1);
ind = 0;
for mI = -3/2:1:3/2
    for mJ = -5/2:1:5/2
        ind = ind + 1;
        F4mp4(ind) = A(M1_index==mI & M2_index==mJ,J_index==4 & Jm_index==4);
    end
end

F3mn3 = nan(24,1);
ind = 0;
for mI = -3/2:1:3/2
    for mJ = -5/2:1:5/2
        ind = ind + 1;
        F3mn3(ind) = A(M1_index==mI & M2_index==mJ,J_index==3 & Jm_index==-3);
    end
end

F3mn2 = nan(24,1);
ind = 0;
for mI = -3/2:1:3/2
    for mJ = -5/2:1:5/2
        ind = ind + 1;
        F3mn2(ind) = A(M1_index==mI & M2_index==mJ,J_index==3 & Jm_index==-2);
    end
end

F3mn1 = nan(24,1);
ind = 0;
for mI = -3/2:1:3/2
    for mJ = -5/2:1:5/2
        ind = ind + 1;
        F3mn1(ind) = A(M1_index==mI & M2_index==mJ,J_index==3 & Jm_index==-1);
    end
end

F3m0 = nan(24,1);
ind = 0;
for mI = -3/2:1:3/2
    for mJ = -5/2:1:5/2
        ind = ind + 1;
        F3m0(ind) = A(M1_index==mI & M2_index==mJ,J_index==3 & Jm_index==0);
    end
end

F3mp1 = nan(24,1);
ind = 0;
for mI = -3/2:1:3/2
    for mJ = -5/2:1:5/2
        ind = ind + 1;
        F3mp1(ind) = A(M1_index==mI & M2_index==mJ,J_index==3 & Jm_index==1);
    end
end

F3mp2 = nan(24,1);
ind = 0;
for mI = -3/2:1:3/2
    for mJ = -5/2:1:5/2
        ind = ind + 1;
        F3mp2(ind) = A(M1_index==mI & M2_index==mJ,J_index==3 & Jm_index==2);
    end
end

F3mp3 = nan(24,1);
ind = 0;
for mI = -3/2:1:3/2
    for mJ = -5/2:1:5/2
        ind = ind + 1;
        F3mp3(ind) = A(M1_index==mI & M2_index==mJ,J_index==3 & Jm_index==3);
    end
end

F2mn2 = nan(24,1);
ind = 0;
for mI = -3/2:1:3/2
    for mJ = -5/2:1:5/2
        ind = ind + 1;
        F2mn2(ind) = A(M1_index==mI & M2_index==mJ,J_index==2 & Jm_index==-2);
    end
end

F2mn1 = nan(24,1);
ind = 0;
for mI = -3/2:1:3/2
    for mJ = -5/2:1:5/2
        ind = ind + 1;
        F2mn1(ind) = A(M1_index==mI & M2_index==mJ,J_index==2 & Jm_index==-1);
    end
end

F2m0 = nan(24,1);
ind = 0;
for mI = -3/2:1:3/2
    for mJ = -5/2:1:5/2
        ind = ind + 1;
        F2m0(ind) = A(M1_index==mI & M2_index==mJ,J_index==2 & Jm_index==0);
    end
end

F2mp1 = nan(24,1);
ind = 0;
for mI = -3/2:1:3/2
    for mJ = -5/2:1:5/2
        ind = ind + 1;
        F2mp1(ind) = A(M1_index==mI & M2_index==mJ,J_index==2 & Jm_index==1);
    end
end

F2mp2 = nan(24,1);
ind = 0;
for mI = -3/2:1:3/2
    for mJ = -5/2:1:5/2
        ind = ind + 1;
        F2mp2(ind) = A(M1_index==mI & M2_index==mJ,J_index==2 & Jm_index==2);
    end
end

F1mn1 = nan(24,1);
ind = 0;
for mI = -3/2:1:3/2
    for mJ = -5/2:1:5/2
        ind = ind + 1;
        F1mn1(ind) = A(M1_index==mI & M2_index==mJ,J_index==1 & Jm_index==-1);
    end
end

F1m0 = nan(24,1);
ind = 0;
for mI = -3/2:1:3/2
    for mJ = -5/2:1:5/2
        ind = ind + 1;
        F1m0(ind) = A(M1_index==mI & M2_index==mJ,J_index==1 & Jm_index==0);
    end
end

F1mp1 = nan(24,1);
ind = 0;
for mI = -3/2:1:3/2
    for mJ = -5/2:1:5/2
        ind = ind + 1;
        F1mp1(ind) = A(M1_index==mI & M2_index==mJ,J_index==1 & Jm_index==1);
    end
end

FStates = [F4mn4 F4mn3 F4mn2 F4mn1 F4m0 F4mp1 F4mp2 F4mp3 F4mp4...
    F3mn3 F3mn2 F3mn1 F3m0 F3mp1 F3mp2 F3mp3...
    F2mn2 F2mn1 F2m0 F2mp1 F2mp2...
    F1mn1 F1m0 F1mp1];