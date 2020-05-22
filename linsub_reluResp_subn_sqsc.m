function [resps] = linsub_reluResp_subn_sqsc(stimstem,sig_n,sig_m,varargin)
% assumes rdim = 2
% makes a portion of the subunit noise correlated and the rest uncorrelated between outputs
% ro_n is the desired correlation coefficient for the subunit noise between
% outputs - it is between 0 and 1
minArgs = 3;
maxArgs = 4;
narginchk(minArgs,maxArgs)

[sdim,Nstim] = size(stimstem);

if nargin == 4
    ro_n = varargin{1};
    if (ro_n>1)||(ro_n<0)
        sprintf('error')
    end
else
    ro_n = 0.5; % half-correlated subnoise by default
end

sig_n1 = sig_n*sqrt(ro_n); % for correlated part
sig_n2 = sig_n*sqrt(1-ro_n); % for uncorrelated part

subnoise = sig_n1.*randn(size(stimstem)); % correlated between outputs
subnoise_on = sig_n2.*randn(size(stimstem)); % subunit noise for ON only so that it is uncorrelated between outputs
subnoise_off = sig_n2.*randn(size(stimstem)); % subunit noise for OFF only so that it is uncorrelated between outputs

ONsub_resps = (stimstem + subnoise + subnoise_on)./sqrt(sdim); %sdim x Nstim
OFFsub_resps = -(stimstem + subnoise + subnoise_off)./sqrt(sdim); %sdim x Nstim

outnoiseON = sig_m.*randn(Nstim,1);
outnoiseOFF = sig_m.*randn(Nstim,1);

% should work for any sdim
% ReLU out
if sdim > 1
    ONsub_resps = sum(ONsub_resps)';
    ONsub_resps(ONsub_resps<0) = 0; %reLu output
    ON_resps1 = ONsub_resps + outnoiseON; % Nstim x 1, i.e. 1D linear output response
    
    OFFsub_resps = sum(OFFsub_resps)';
    OFFsub_resps(OFFsub_resps<0) = 0; %reLu output
    OFF_resps1 = OFFsub_resps + outnoiseOFF; % Nstim x 1, i.e. 1D linear output response
else
    ONsub_resps(ONsub_resps<0) = 0; %reLu output
    ON_resps1 = ONsub_resps' + outnoiseON; % Nstim x 1, i.e. 1D linear output response
    
    OFFsub_resps(OFFsub_resps<0) = 0; %reLu output
    OFF_resps1 = OFFsub_resps' + outnoiseOFF; % Nstim x 1, i.e. 1D linear output response
end

resps = [ON_resps1,OFF_resps1]; % Nstim x rdim

        

