function [Hr,sdHru] = binnedHr_subweights(sdim,rdim,resp_func,sig_s,sig_n,sig_m,Nstim,bw,nlout,varargin)

minArgs = 9;
maxArgs = 10;
narginchk(minArgs,maxArgs)

if nargin == 10
    Wsub = varargin{1};
else
    Wsub = [cos(pi/4),sin(pi/4);cos(pi/4),sin(pi/4)];
end

runs = 6;
Hru = zeros(1,runs);

tic
switch resp_func
    case 'linear'
        parfor rur = 1:runs
            stimstem = sig_s.*randn(sdim,Nstim);
            [resps] = linsubResp_sub36(stimstem,sig_n,sig_m,Wsub,nlout);
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
            Hru(rur) = -nansum(Pcounts(Pcounts>0).*log2(Pcounts(Pcounts>0)));
        end
        
    case 'relu'
        parfor rur = 1:runs
            stimstem = sig_s.*randn(sdim,Nstim);
            [resps] = nlsubsResp_reLu_sub36(stimstem,sig_n,sig_m,Wsub,nlout);
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
            Hru(rur) = -nansum(Pcounts(Pcounts>0).*log2(Pcounts(Pcounts>0)));
        end
end
toc

Hr = mean(Hru);
sdHru = std(Hru);

end
