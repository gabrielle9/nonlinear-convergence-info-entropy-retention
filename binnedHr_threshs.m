function [Hr,sdHru] = binnedHr_threshs(sdim,rdim,subthreshs,sig_s,sig_n,sig_m,Nstim,bw,runs,nlout,out_threshs,varargin)

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

Hru = zeros(1,runs);

tic

parfor rur = 1:runs
    stimstem = sig_s.*randn(sdim,Nstim);
    [resps] = subunit_circuit_outnoise_pre_nl_cg_fix(stimstem,sig_n,sig_m,subthreshs,nlout,out_threshs,ro_n);
    eboundmin = floor(min(min(resps)) - 2*bw);
    eboundmax = ceil(max(max(resps)) + 2*bw);
    edges = eboundmin:bw:eboundmax;
    
    if rdim == 1
        resps = resps(:,1);
        [counts_resp,~] = histcounts(resps,edges);
    else
        [counts_resp,~,~] = histcounts2(resps(:,1),resps(:,2),edges,edges);
    end
    
    Pcounts = counts_resp(:)./sum(counts_resp(:));
    Pcounts = Pcounts(Pcounts>0);
    Hru(rur) = -nansum(Pcounts.*log2(Pcounts));
end

toc

Hr = mean(Hru);
sdHru = std(Hru);



