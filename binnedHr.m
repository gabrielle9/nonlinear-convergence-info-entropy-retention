function [Hr,sdHru] = binnedHr(sdim,rdim,resp_func,sig_s,sig_n,sig_m,Nstim,edges)
% Computes binned entropy of responses generated based on resp-func

runs = 6;

tic
switch resp_func
    case 'linear'
        Hru = zeros(1,runs);
        parfor rur = 1:runs
        stimstem = sig_s.*randn(sdim,Nstim);
        [resps] = linsubResp_subn(stimstem,sig_n,sig_m);
        if rdim == 1
            resps = resps(:,1);
            [counts_resp,~] = histcounts(resps,edges);
        else
            [counts_resp,~,~] = histcounts2(resps(:,1),resps(:,2),edges,edges);
        end
        Pcounts = counts_resp(:)./sum(counts_resp(:));
        Hru(rur) = -nansum(Pcounts.*log2(Pcounts));
        end
        
    case 'relu'
        Hru = zeros(1,runs);
        parfor rur = 1:runs
        stimstem = sig_s.*randn(sdim,Nstim);
        [resps] = nlsubsResp_reLu_subn(stimstem,sig_n,sig_m);
        if rdim == 1
            resps = resps(:,1);
            [counts_resp,~] = histcounts(resps,edges);
        else
            [counts_resp,~,~] = histcounts2(resps(:,1),resps(:,2),edges,edges);
        end
        Pcounts = counts_resp(:)./sum(counts_resp(:));
        Hru(rur) = -nansum(Pcounts.*log2(Pcounts));
        end
        
    case 'relu_out'
        Hru = zeros(1,runs);
        parfor rur = 1:runs
        stimstem = sig_s.*randn(sdim,Nstim);
        [resps] = linsub_reluResp_subn(stimstem,sig_n,sig_m);
        if rdim == 1
            resps = resps(:,1);
            [counts_resp,~] = histcounts(resps,edges);
        else
            [counts_resp,~,~] = histcounts2(resps(:,1),resps(:,2),edges,edges);
        end
        Pcounts = counts_resp(:)./sum(counts_resp(:));
        Hru(rur) = -nansum(Pcounts.*log2(Pcounts));
        end
end
toc

Hr = mean(Hru);
sdHru = std(Hru);

end
