% sparse weights
clearvars

cd('/Users/gabriellegutierrez/Documents/MATLAB/Retina/2020/September/11')
load('sparse_weights_2Dout.mat')

% rdim = 2;
% max_sdim = 15;
% sig_s = 10;
% sig_n = 0;
% sig_m = 0;
% Nstim = 1e6;
% bw = 0.25;
% runs = 10;
% 
% sdims = 1:max_sdim; %zeros(1,sdim);
% prob_nonzerow = sdims./max_sdim;
% 
% savestr = 'sparse_weights_2Dout.mat';

% %% linsubs
% Hr_linsubs_sparse = zeros(runs,max_sdim);
% 
% for j = 1:runs
%     stimstem = sig_s.*randn(max_sdim,Nstim);
%     
%     ONsub_resps = stimstem;
%     OFFsub_resps = -stimstem;
%             
%     parfor i = sdims %1:max_sdim
%         weights = zeros(1,max_sdim);
%         weights(1:i) = 1;
%         
%         weights = weights./sqrt(i);%[1xsdim] % if normalizing on active weights (it's like in nDin sims)
%         %     weights = weights./sqrt(max_sdim);%[1xsdim] % if normalizing on active and inactive weights (it's like not normalizing)
%         
%         ONweights = weights(randperm(max_sdim)); %randomly rearranges the weights
%         OFFweights = weights(randperm(max_sdim));
%         
%         ONresps_sparse = (ONweights*ONsub_resps)'; % Nstim x 1    %
%         OFFresps_sparse = (OFFweights*OFFsub_resps)'; % Nstim x 1    %
%         
%         resps_sparse = [ONresps_sparse,OFFresps_sparse]; % Nstim x rdim
%         resps_sparse(resps_sparse<0) = 0; % nlout
%         
%         eboundmin = floor(min(min(resps_sparse)) - 2*bw);
%         eboundmax = ceil(max(max(resps_sparse)) + 2*bw);
%         edges = eboundmin:bw:eboundmax;
%         [counts_resp,~,~] = histcounts2(resps_sparse(:,1),resps_sparse(:,2),edges,edges);
%         Pcounts = counts_resp(:)./sum(counts_resp(:));
%         Hr_linsubs_sparse(j,i) = -nansum(Pcounts.*log2(Pcounts));
%     end
% end
% mHr_linsubs_sparse = mean(Hr_linsubs_sparse);
% sdHr_linsubs_sparse = std(Hr_linsubs_sparse);
% 
% %% nlsubs
% Hr_nlsubs_sparse = zeros(runs,max_sdim);
% 
% for j = 1:runs
%     stimstem = sig_s.*randn(max_sdim,Nstim);
%     
%     ONsub_resps = stimstem;
%     OFFsub_resps = -stimstem;
%     
%     ONsub_resps(ONsub_resps<0) = 0; % nlsubs
%     OFFsub_resps(OFFsub_resps<0) = 0; % nlsubs
%         
%     parfor i = sdims %1:max_sdim
%         weights = zeros(1,max_sdim);
%         weights(1:i) = 1;
%         
%         weights = weights./sqrt(i);%[1xsdim] % if normalizing on active weights (it's like in nDin sims)
%         %     weights = weights./sqrt(max_sdim);%[1xsdim] % if normalizing on active and inactive weights (it's like not normalizing)
%         
%         ONweights = weights(randperm(max_sdim)); %randomly rearranges the weights
%         OFFweights = weights(randperm(max_sdim));
%         
%         ONresps_sparse = (ONweights*ONsub_resps)'; % Nstim x 1    %
%         OFFresps_sparse = (OFFweights*OFFsub_resps)'; % Nstim x 1    %
%         
%         resps_sparse = [ONresps_sparse,OFFresps_sparse]; % Nstim x rdim
%         resps_sparse(resps_sparse<0) = 0; % nlout
%         
%         eboundmin = floor(min(min(resps_sparse)) - 2*bw);
%         eboundmax = ceil(max(max(resps_sparse)) + 2*bw);
%         edges = eboundmin:bw:eboundmax;
%         [counts_resp,~,~] = histcounts2(resps_sparse(:,1),resps_sparse(:,2),edges,edges);
%         Pcounts = counts_resp(:)./sum(counts_resp(:));
%         Hr_nlsubs_sparse(j,i) = -nansum(Pcounts.*log2(Pcounts));
%     end
% end
% mHr_nlsubs_sparse = mean(Hr_nlsubs_sparse);
% sdHr_nlsubs_sparse = std(Hr_nlsubs_sparse);
% 
% %%
% clear stimstem ON* OFF*
% save(savestr)

%%
figure; hold on

errorbar(prob_nonzerow,mHr_linsubs_sparse,sdHr_linsubs_sparse,'LineWidth',3)
errorbar(prob_nonzerow,mHr_nlsubs_sparse,sdHr_nlsubs_sparse,'LineWidth',3)

set(gca,'FontSize',14)
xlabel('P[non-zero w]')
ylabel('entropy (bits)')
% legend('sparse, linsubs','sparse, nlsubs')%,'nDin, linsubs','nDin, nlsubs')
% title('Sparse decorrelated weights vs. full rank weights')
grid on

ax1 = gca;
ax1_pos = ax1.Position;
ax2 = axes('Position',ax1_pos,'XAxisLocation','top','YAxisLocation','right','Color','none');
hold on

cd('/Users/gabriellegutierrez/Documents/MATLAB/Retina/2020/September/4')
load('H_binned_nDin_sigs10_sqsc_cg_relu_out_4Sep20.mat')

% errorbar(prob_nonzerow,Hr_linsubs_nlout_nDin_2Dout_sqsc(1:max_sdim),sdHru_linsubs_nlout_nDin_2Dout_sqsc(1:max_sdim),'--','LineWidth',3)
% errorbar(prob_nonzerow,Hr_nlsubs_nlout_nDin_2Dout_sqsc(1:max_sdim),sdHru_nlsubs_nlout_nDin_2Dout_sqsc(1:max_sdim),'--','LineWidth',3)
errorbar(sdims(1:max_sdim),Hr_linsubs_nlout_nDin_2Dout_sqsc(1:max_sdim),sdHru_linsubs_nlout_nDin_2Dout_sqsc(1:max_sdim),'--','LineWidth',3)
errorbar(sdims(1:max_sdim),Hr_nlsubs_nlout_nDin_2Dout_sqsc(1:max_sdim),sdHru_nlsubs_nlout_nDin_2Dout_sqsc(1:max_sdim),'--','LineWidth',3)

set(gca,'FontSize',14)
xlabel('# of inputs')
ylabel('entropy (bits)')
% legend('nDin, linsubs','nDin, nlsubs')
legend('linear subunits','ReLU subunits')
title('Sparse decorrelated weights vs. full rank weights')
% title('Sparse decorrelated weights vs. nDin')
grid on


