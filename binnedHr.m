function [Hr,sdHru] = binnedHr(sdim,rdim,resp_func,sig_s,sig_n,sig_m,Nstim,edges,runs,varargin)

minArgs = 9;
maxArgs = 10;
narginchk(minArgs,maxArgs)

if nargin == 10
    Wsub = varargin{1};
end

% runs = 6;
Hru = zeros(1,runs);

tic
switch resp_func
    case 'linear'
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
            Pcounts = Pcounts(Pcounts>0);
            Hru(rur) = -nansum(Pcounts(Pcounts>0).*log2(Pcounts(Pcounts>0)));
        end
        
    case 'relu'
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
            Pcounts = Pcounts(Pcounts>0);
            Hru(rur) = -nansum(Pcounts(Pcounts>0).*log2(Pcounts(Pcounts>0)));
        end
        
    case 'relu_out'
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
            Pcounts = Pcounts(Pcounts>0);
            Hru(rur) = -nansum(Pcounts(Pcounts>0).*log2(Pcounts(Pcounts>0)));
        end
        
    case 'linear36'
        parfor rur = 1:runs
            stimstem = sig_s.*randn(sdim,Nstim);
            [resps] = linsubResp_sub36(stimstem,sig_n,sig_m,Wsub);
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
        
    case 'relu36'
        parfor rur = 1:runs
            stimstem = sig_s.*randn(sdim,Nstim);
            [resps] = nlsubsResp_reLu_sub36(stimstem,sig_n,sig_m,Wsub);
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
        
    case 'relu_out36'
        parfor rur = 1:runs
            stimstem = sig_s.*randn(sdim,Nstim);
            [resps] = linsub_reluResp_sub36(stimstem,sig_n,sig_m,Wsub);
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
        
    case 'linear_sqsc'
        parfor rur = 1:runs
            stimstem = sig_s.*randn(sdim,Nstim);
            [resps] = linsubResp_subn_sqsc(stimstem,sig_n,sig_m);
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
        
    case 'relu_sqsc'
        parfor rur = 1:runs
            stimstem = sig_s.*randn(sdim,Nstim);
            [resps] = nlsubsResp_reLu_subn_sqsc(stimstem,sig_n,sig_m);
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
        
    case 'relu_out_sqsc'
        parfor rur = 1:runs
            stimstem = sig_s.*randn(sdim,Nstim);
            [resps] = linsub_reluResp_subn_sqsc(stimstem,sig_n,sig_m);
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
        
            case 'linsubs_sqsc_cgout'
        parfor rur = 1:runs
            stimstem = sig_s.*randn(sdim,Nstim);
            [resps] = linsub_cgResp_subn_sqsc(stimstem,sig_n,sig_m);
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
        
    case 'nlsubs_sqsc_cgout'
        parfor rur = 1:runs
            stimstem = sig_s.*randn(sdim,Nstim);
            [resps] = nlsub_cgResp_subn_sqsc(stimstem,sig_n,sig_m);
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
end
toc

Hr = mean(Hru);
sdHru = std(Hru);

end
