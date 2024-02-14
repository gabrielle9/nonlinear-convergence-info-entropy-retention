function [Hr,sdHru,mResps] = binnedHr_threshs_stimcorr(sdim,rdim,threshs,sig_s,sig_n,sig_m,Nstim,bw,varargin)

% works for any size sdim

minArgs = 8;
maxArgs = 9;
narginchk(minArgs,maxArgs)

if nargin == 9
    Wsub = varargin{1};
end

runs = 6;
nlout = 'relu';
sig_c = 0.1*sig_s;

Hru = zeros(1,runs);
mRespsu = zeros(runs,rdim);

tic

parfor rur = 1:runs
    stimstem = sig_s.*randn(sdim,Nstim);
    stimstem(2:end,:) = repmat(stimstem(1,:),sdim-1,1) + sig_c.*randn(sdim-1,Nstim);
    
    [resps] = nlsubsResp_thresh_reLu_subn_sqsc_nlout(stimstem,sig_n,sig_m,threshs,nlout);
    eboundmin = floor(min(resps(:)) - 2*bw);
    eboundmax = ceil(max(resps(:)) + 2*bw);
    edges = eboundmin:bw:eboundmax;
    if rdim == 1
        resps = resps(:,1);
        [counts_resp,~] = histcounts(resps,edges);
    else
        [counts_resp,~,~] = histcounts2(resps(:,1),resps(:,2),edges,edges);
    end
    Pcounts = counts_resp(:)./sum(counts_resp(:));
    Hru(rur) = -Pcounts'*log2(Pcounts);
    mRespsu(rur,:) = mean(resps); % runs x rdim
end

toc

Hr = mean(Hru);
sdHru = std(Hru);
mResps = mean(mRespsu); % 1 x rdim



