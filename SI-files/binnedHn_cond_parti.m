function [Hn,sdHnu] = binnedHn_cond_parti(sdim,rdim,subthreshs,sig_s,sig_n,sig_m,Nreps,bw,Ncap,nlout,out_threshs,varargin)%(rdim,sig_m,Nstim,bw,runs)
%conditional noise entropy calculation
% Ncap should be the optimal number of samples to represent the 2D response
% distribution without/before noise

minArgs = 11;
maxArgs = 12;
narginchk(minArgs,maxArgs)

if nargin == maxArgs
    ro_n = varargin{1};
    if (ro_n>1)||(ro_n<0)
        sprintf('error')
    end
else
    ro_n = 0; % uncorrelated subnoise by default
end

tic

% Npars = 2*floor((Ncap^(1/sdim))/2); %try to get this to be an even number

% before parfor, get P[s]
Npars = 10; % maximum number of partitions
% n = 0:Npars-2;
n = 0:2:Npars-2;
combo_cap = Ncap; % maximum for comboswr
% combo_cap = 5e2; %5e4; % maximum for comboswr
comboswr_n = factorial(Npars-n+sdim-1)./(factorial(sdim).*factorial(Npars-n-1));
ind = find(comboswr_n<=combo_cap,1);
Npars = Npars-n(ind); % number of partitions for this simulation given combo_cap

% make partitioned stim line
y = (0.5/Npars):1/(Npars):1; % these are the partition centers
pdf_obj = makedist('Normal','mu',0,'sigma',sig_s);
partiStims = icdf(pdf_obj,y); % this creates stims that are spaced appropriately
partipdf = normpdf(partiStims,0,sig_s);
ppdf = partipdf./sum(partipdf); % these are the corresponding probabilities for those partitioned stims

% compute combos and weights to loop through
[combowr_array,cweights,~,~] = genCombos(Npars,sdim);
combo_probs = ppdf(combowr_array); % the corresponding probs for all the stims that will be run. think of combowr_array as a matrix of indices.
if sdim > 1
    cprobs = prod(combo_probs,2); %products of probs correspond to probs of each stim image
else
    cprobs = combo_probs';
end
weighted_cprobs = cprobs.*cweights; %probs for each stim combo run. should sum to 1.
combo_partiStims = partiStims(combowr_array')'; %these are the stim combos that will be run

ncomboswr = size(combowr_array,1);

Hnu = zeros(ncomboswr,1); % for some reason, using ncomboswr here and parfor loop bounds didn't work

parfor s = 1:ncomboswr %int64(comboswr)
    stimsamp = repmat(combo_partiStims(s,:)',1,Nreps);
    [noiseresps] = subunit_circuit_outnoise_pre_nl_cg_fix(stimsamp,sig_n,sig_m,subthreshs,nlout,out_threshs,ro_n);
%     eboundmin = floor(min(min(noiseresps)) - 2*bw);
%     eboundmax = ceil(max(max(noiseresps)) + 2*bw);
    eboundmin = floor(min(min(noiseresps)) - 4*bw);
    eboundmax = ceil(max(max(noiseresps)) + 4*bw);
    edges = eboundmin:bw:eboundmax;
    
    if rdim == 1
        [counts_noise,~] = histcounts(noiseresps(:,1),edges);
    else
        [counts_noise,~,~] = histcounts2(noiseresps(:,1),noiseresps(:,2),edges,edges);
    end
    Prs = counts_noise(:)./sum(counts_noise(:)); %P[r|s]
%     Prs = Prs(Prs>0); %this freaks me out and shouldn't be necessary with the custom edges
    Hnu(s) = -nansum(Prs.*log2(Prs)); % summed over responses for stim repeats
end
toc

Hn = sum(weighted_cprobs.*Hnu); % sum(P[s]*H[r|s])
% Hn = mean(Hnu);
sdHnu = std(Hnu); % std isn't very meaningful here since it's not something I want to try to reduce, but i'll send it out so i can see how variable the noise entropy is for different stims and partitions.

end

