%Script for computing the measurement outcomes of a SPAM experiment.
%The following variables have to be defined in the command window before
%running this script.
%
%Filepath: A string which is the directory which contains the data files to
%be analyzed. The string should end with a backslash for Windows machines.
%
%filename: A string which specify the filename of the data to be analyzed.
%The string can be only partial of the filename, and all the files which
%share the same part of the filename specified will be analyzed and
%aggregated.
%
%Output definition:
%Fidel_Raw: A 2D array of measurement probabilities. The first dimension
%corresponds to the prepared state. The second dimension corresponds to the
%measured state. The less robust interpretation of treating not only one 
%measurement outcomes as error is used.
%
%Fidel_Normed: A 2D array of measurement probabilities. This is the
%post-selected version of Fidel_Raw, where outcomes with not only one 
%bright measurement outcome are discarded.
%
%Fidel_Seq: A 2D array of measurement probabilities. The first dimension
%corresponds to the prepared state. The second dimension corresponds to the
%measured state. The main interpretation of treating the first bright state
%detection as the measurement outcome is used.
%
%Fidel_Seq_Normed: A 2D array of measurement probabilities. This is the
%post-selected version of Fidel_Seq, where outcomes with no bright 
%measurement outcome are discarded.

Misc_Get_Shelved_Population; %Get bright/dark states probabilities.

State_fidel = nan(size(Pumped_Indicator));
State_fidel(1,:,:) = [];

for hh = 1:size(Pumped_Indicator,3)
    for h=2:size(Pumped_Indicator,1)
        for hhh = 1:size(Pumped_Indicator,2)
            Expected_outcome = ones([1 size(Pumped_Indicator,2) 1]);
            Expected_outcome(hhh) = 0;
            State_fidel(h-1,hhh,hh) = floor(mean(Pumped_Indicator(h,:,hh) == Expected_outcome));    
        end
    end
end

Fidel_Raw = mean(State_fidel,1);
Fidel_Normed = mean(State_fidel,1)./repmat(sum(mean(State_fidel,1)),[1 size(Pumped_Indicator,2)]);

for hh = 1:size(Pumped_Indicator,3)
    for h=2:size(Pumped_Indicator,1)
        for hhh = 1:size(Pumped_Indicator,2)
            Expected_outcome = ones([1 hhh 1]);
            Expected_outcome(hhh) = 0;
            State_fidel(h-1,hhh,hh) = floor(mean(Pumped_Indicator(h,1:hhh,hh) == Expected_outcome));    
        end
    end
end

Fidel_Seq = mean(State_fidel,1);
Fidel_Seq_Normed = mean(State_fidel,1)./repmat(sum(mean(State_fidel,1)),[1 size(Pumped_Indicator,2)]);

Fidel_Raw = reshape(Fidel_Raw,[size(Fidel_Raw,2) size(Fidel_Raw,3)]);
Fidel_Raw = Fidel_Raw';
Fidel_Normed = reshape(Fidel_Normed,[size(Fidel_Normed,2) size(Fidel_Normed,3)]);
Fidel_Normed = Fidel_Normed';
Fidel_Seq = reshape(Fidel_Seq,[size(Fidel_Seq,2) size(Fidel_Seq,3)]);
Fidel_Seq = Fidel_Seq';
Fidel_Seq_Normed = reshape(Fidel_Seq_Normed,[size(Fidel_Seq_Normed,2) size(Fidel_Seq_Normed,3)]);
Fidel_Seq_Normed = Fidel_Seq_Normed';

dlmwrite([Filepath 'Fidel_Raw.txt'],Fidel_Raw,'delimiter','\t');
dlmwrite([Filepath 'Fidel_Raw_Normed.txt'],Fidel_Normed,'delimiter','\t');
dlmwrite([Filepath 'Fidel_Seq.txt'],Fidel_Seq,'delimiter','\t');
dlmwrite([Filepath 'Fidel_Seq_Normed.txt'],Fidel_Seq_Normed,'delimiter','\t');