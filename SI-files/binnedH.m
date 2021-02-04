function [Hn,sdHnu] = binnedH(rdim,sig_s,Nstim,bw,runs)
% assumes signal is gaussian with no correlations

tic
Hnu = zeros(1,runs);
parfor rur = 1:runs
    signal = sig_s.*randn(Nstim,rdim);
    
    if rdim == 1
        eboundmin = floor(min(signal) - 2*bw);
        eboundmax = ceil(max(signal) + 2*bw);
        edges = eboundmin:bw:eboundmax;
        [counts_noise,~] = histcounts(signal,edges);
    else
        eboundmin = floor(min(min(signal)) - 2*bw);
        eboundmax = ceil(max(max(signal)) + 2*bw);
        edges = eboundmin:bw:eboundmax;
        [counts_noise,~,~] = histcounts2(signal(:,1),signal(:,2),edges,edges);
    end
    Pnoise = counts_noise(:)./sum(counts_noise(:));
    Pnoise = Pnoise(Pnoise>0);
    Hnu(rur) = -nansum(Pnoise.*log2(Pnoise));
end
toc

Hn = mean(Hnu);
sdHnu = std(Hnu);

end

