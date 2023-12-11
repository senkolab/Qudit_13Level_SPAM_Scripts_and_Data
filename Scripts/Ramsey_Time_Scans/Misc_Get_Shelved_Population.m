%Script for computing probabilities of detecting dark states, from arrays
%of PMT counts.
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
%Pumped_population: A 1D array of probabilities of detecting dark states.

files = dir([Filepath filename '*']); %Obtain files

%Extract data from the string data format, and store in PMTCount.
A = importdata([Filepath files(1).name]);
startind = find(A{1} == '[');
startind = startind(2);
endind = find(A{1} == ']');
endind = endind(1);
B = str2num(A{1}(startind:endind));
PMTCount = nan(numel(A),numel(B),numel(files));

for fileind = 1:numel(files)
    A = importdata([Filepath files(fileind).name]);
    for h = 1:numel(A)
        startind = find(A{h} == '[');
        startind = startind(2);
        endind = find(A{h} == ']');
        endind = endind(1);
        PMTCount(h,:,fileind) = str2num(A{h}(startind:endind));
    end
end

%Algorithm to dynamically determine PMT count threshold for discriminating
%bright/dark states.
PMTCount_Sorted = sort(PMTCount(:));
PMTCount_Sorted_Skip = PMTCount_Sorted(1:round(numel(PMTCount_Sorted)/1000):end);
PMTCount_Sorted_Diff = PMTCount_Sorted_Skip(2:end) - PMTCount_Sorted_Skip(1:end-1);
PMTCount_Sorted_Diff_max = max(PMTCount_Sorted_Diff);
PMTCount_Sorted_Diff_max = PMTCount_Sorted_Diff_max(1);
PMTCount_Sorted_Diff_ind = find(PMTCount_Sorted_Diff == PMTCount_Sorted_Diff_max);
PMTCount_Sorted_Diff_ind = PMTCount_Sorted_Diff_ind(1);

Pumped_Indicator = zeros(size(PMTCount));
Pumped_Indicator(PMTCount < PMTCount_Sorted_Skip(PMTCount_Sorted_Diff_ind)+PMTCount_Sorted_Diff_max/2) = 1;
Pumped_population = mean(Pumped_Indicator,2);
Pumped_population = reshape(Pumped_population,[size(Pumped_population,1) size(Pumped_population,3)]);