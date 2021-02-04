function [combowr_array,cweights,permus,comboswr] = genCombos(Npars,sdim)

permus = Npars^sdim; % permutations possible in stim space
comboswr = factorial(Npars+sdim-1)/(factorial(sdim)*factorial(Npars-1)); % combinations w/repeats in stim space
ncomboswr = int64(comboswr);

% generate array of combinations with repetition
combowr_array = nmultichoosek(1:Npars,sdim);

% generate weights for each combination based on how often each combo would
% show up in the set of all permutations
cweights = zeros(ncomboswr,1);
nmerf = factorial(sdim); %numerator of multinomial coefficient

% go through each combo, determine how many repeats of each unique element are in
% the combo. for example AAAAB has 4 A's and 1 B. a_counts returns [4;1].
for i = 1:ncomboswr
    combo1 = combowr_array(i,:); %one combo at a time
    [~,~,ic] = unique(combo1); %determine counts of unique partitions in combo1
    a_counts = accumarray(ic,1); %sum of a_counts equals sdim
    cweights(i) = nmerf/prod(factorial(a_counts)); %multinomial coefficient tells you how many times this combo shows up in the total permutations
end

if sum(cweights) ~= permus
    disp('mismatch of cweights with # of permutations')
end

