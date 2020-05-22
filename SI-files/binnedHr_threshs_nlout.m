function [Hr,sdHru,mResps] = binnedHr_threshs_nlout(sdim,rdim,threshs,sig_s,sig_n,sig_m,Nstim,edges,nlout,varargin)

minArgs = 9;
maxArgs = 10;
narginchk(minArgs,maxArgs)

if nargin == 10
    Wsub = varargin{1};
end

runs = 6;
Hru = zeros(1,runs);
mRespsu = zeros(runs,rdim);

tic

        parfor rur = 1:runs
            stimstem = sig_s.*randn(sdim,Nstim);
            [resps] = nlsubsResp_thresh_reLu_subn_sqsc_nlout(stimstem,sig_n,sig_m,threshs,nlout);
            if rdim == 1
                resps = resps(:,1);
                [counts_resp,~] = histcounts(resps,edges);
            else
                [counts_resp,~,~] = histcounts2(resps(:,1),resps(:,2),edges,edges);
            end
            Pcounts = counts_resp(:)./sum(counts_resp(:));
            Hru(rur) = -nansum(Pcounts.*log2(Pcounts));
            mRespsu(rur,:) = mean(resps); % runs x rdim
        end

toc

Hr = mean(Hru);
sdHru = std(Hru);
mResps = mean(mRespsu); % 1 x rdim



